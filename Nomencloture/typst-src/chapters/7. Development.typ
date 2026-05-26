#import "../thesis-base.typ": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: codly-init.with()
#codly(languages: codly-languages, breakable: true)

#chapter(3, "Реализация инструмента RICOVER")

== Общая архитектура и конвейер

RICOVER (RISC-V Compiler Optimization VERification) --- инструмент формальной верификации, реализованный на языке Rust. Он принимает два RISC-V ассемблерных файла и снимок Isla IR RISC-V модели, и транслирует это в формат SMT-LIB2, формируя CHC-запрос. Архитектура конвейера представлена на рисунке @fig-pipeline.

#figure(
  image("../diagrams/pipeline.jpg"),
  caption: [Архитектура конвейера RICOVER],
) <fig-pipeline>

Проект организован следующим образом:

- `src/main.rs` --- точка входа CLI (Clap), маршрутизирует команды `translate-ir` и `check-equiv`;
- `src/isla_ir.rs` --- загружает `.ir` файл через isla-lib, извлекает тела execute-клозов, специализирует варианты и транслирует в CHC;
- `src/asm_parse.rs` --- разбирает RISC-V ассемблерные файлы в структурированные последовательности инструкций;
- `src/chc_emit/` --- формирует финальный CHC-запрос: соединяет CHC-правила инструкций в цепочку состояний и добавляет запрос на эквивалентность;
- `chc_stdlib/stdlib.smt2` --- CHC стандартная библиотека.

Точка входа RICOVER определяет две подкоманды через интерфейс командной строки. Листинг @listing-cli демонстрирует их объявление.

#figure(
  caption: [Перечисление команд CLI в main.rs],
  ```rust
  /// RICOVER - RISC-V Compiler Optimization Verification via CHC
  #[derive(Parser)]
  #[command(name = "ricover")]
  enum Cli {
      /// Translate Isla IR instruction definitions to CHC
      TranslateIR {
          #[arg(short, long)] ir_file: PathBuf,
          #[arg(short, long)] output: PathBuf,
          #[arg(short, long)] functions: Vec<String>,
      },

      /// Emit CHC equivalence query from two RISC-V assembly functions
      CheckEquiv {
          #[arg(long)] before: PathBuf,
          #[arg(long)] after: PathBuf,
          #[arg(short, long)] function: String,
          #[arg(long)] before_fn: Option<String>,
          #[arg(long)] after_fn: Option<String>,
          #[arg(short, long)] output: PathBuf,
          #[arg(long)] ir: PathBuf,
      },
  }
  ```,
) <listing-cli>

RICOVER поддерживает две команды:

+ `translate-ir` --- транслирует execute-функции из `.ir` файла в CHC-правила инструкций;
+ `check-equiv` --- строит полный запрос на эквивалентность двух функций.

== Трансляция Sail IR в CHC

Основная задача модуля `isla_ir.rs` --- преобразовать тела execute-функций Isla IR в CHC-правила, формально кодирующие семантику каждой инструкции RISC-V.

Загрузка IR выполняется через публичные структуры данных модуля. Структура `IslaIRModel` хранит разобранные определения IR и таблицу символов; `IrFunction` представляет одну функцию с её телом (листинг @listing-structs).

#figure(
  caption: [Структуры данных модуля isla\_ir.rs (Rust)],
  ```rust
  pub struct IslaIRModel<'ir> {
      pub defs: Vec<Def<Name, B129>>,
      pub symtab: Symtab<'ir>,
  }

  pub struct IrFunction<'a> {
      pub name: String,
      pub params: Vec<Name>,
      pub body: &'a [Instr<Name, B129>],
  }
  ```,
) <listing-structs>

Загрузка и разбор `.ir` файла выполняются функцией `parse_ir`, которая делегирует синтаксический анализ парсеру isla-lib (листинг @listing-parse-ir).

#figure(
  caption: [Загрузка и разбор Isla IR через isla-lib (Rust)],
  ```rust
  pub fn parse_ir(contents: &str) -> Result<IslaIRModel<'_>> {
      let mut symtab = Symtab::new();
      let defs = IrParser::new()
          .parse(&mut symtab, new_ir_lexer(contents))
          .map_err(|e| anyhow!("IR parse error: {}", e))?;
      Ok(IslaIRModel { defs, symtab })
  }
  ```,
) <listing-parse-ir>

*Алгоритм трансляции* состоит из четырёх шагов.

+ *Загрузка IR.* Функция `read_ir_file` читает бинарный `.ir` файл с диска; `parse_ir` десериализует содержимое в AST Isla IR (листинг @listing-parse-ir). Модуль ищет функции с именем `execute` (или указанные через флаг `-f`).

+ *Обнаружение вариантов* (`discover_variants`). Тело функции `execute` содержит `match`-выражения по типу инструкции. Модуль рекурсивно обходит IR, сопоставляя ветки `match` с конкретными вариантами инструкций (ADDI, LOAD, BRANCH и т. д.).

+ *Специализация варианта* (`emit_variant_chc`). Для каждого варианта: параметры инструкции (поля операнда, регистровые номера) становятся свободными переменными CHC-правила, каждое присваивание регистра (`X(rd) = ...`) кодируется через `set_reg(regs0, rd, val)`, обращения к памяти --- через `mem_read_N`/`write_mem_*`, обновление PC: если инструкция не осуществляет переход, то `pc1 = bvadd(pc0, 4)`.

+ *Оптимизация: устранение переменных памяти.* Инструкции, не изменяющие память (например, арифметические, логические), не получают собственной переменной памяти `memN`. Вместо этого используется предыдущая переменная `memK`, устраняя некоторые тривиальные ограничения вида `(= memN memN-1)` над массивами.

Результатом шага 3 является CHC-правило для каждой инструкции. Листинг @listing-addi-chc демонстрирует правило для `addi rd, rs1, imm`, полученное из Sail-клоза `execute ITYPE` через Isla IR.

#figure(
  caption: [Транслированное CHC-правило инструкции addi (SMT-LIB2)],
  raw(
    block: true,
    lang: none,
    "(declare-rel addi
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8))
   (_ BitVec 64)
   (_ BitVec 12) (_ BitVec 5) (_ BitVec 5)))

(rule
  (forall ((regs0 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem0  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc0   (_ BitVec 64))
           (regs1 (Array (_ BitVec 5) (_ BitVec 64)))
           (mem1  (Array (_ BitVec 64) (_ BitVec 8)))
           (pc1   (_ BitVec 64))
           (p0 (_ BitVec 12)) (p1 (_ BitVec 5)) (p2 (_ BitVec 5)))
    (=> (and
          (= regs1 (set_reg regs0 p2
                    (bvadd (get_reg regs0 p1)
                           ((_ sign_extend 52) p0))))
          (= mem1 mem0)
          (= pc1 (bvadd pc0 (_ bv4 64))))
        (addi regs0 mem0 pc0 regs1 mem1 pc1 p0 p1 p2))))",
  ),
) <listing-addi-chc>

Читать это правило следует так: «Начиная из состояния `(regs0, mem0, pc0)`, исполнение `addi` с операндами `imm=p0, rs1=p1, rd=p2` приводит к состоянию `(regs1, mem1, pc1)`, где регистр `rd` получает значение `rs1 + sign_extend(imm)`, память не изменяется, а PC увеличивается на 4». Тело правила было механически получено из Sail-клоза через Isla IR --- оно не написано вручную.

Команда `translate-ir` генерирует для каждой инструкции отдельное CHC-отношение (`declare-rel` + `rule`), как показано в листинге @listing-addi-chc. Вместо обращения к инструкционным отношениям, `check-equiv` применяет прямое встраивание (inline): тело каждого правила блока содержит три равенства-ограничения непосредственно, без ссылки на инструкцию в виде отношения. Такой подход сокращает глубину CHC-системы с двух уровней (инструкционные отношения, программные отношения) до одного (только блочные и композиционные отношения), что упрощает задачу поиска индуктивного инварианта алгоритмом Spacer.

Технически инлайнинг реализован через структуру `InlinedSemantics` (листинг @listing-inlined-sem) --- три строковых шаблона, хранящих SMT-выражения для нового регистрового файла, памяти и PC.

#figure(
  caption: [Структура InlinedSemantics и метод instantiate\_compressed (ir\_emit.rs, Rust)],
  ```rust
  pub(crate) struct InlinedSemantics {
      /// Шаблон для regs_out. Содержит "regs0" и "p0".."pN".
      pub regs_expr: String,
      /// Шаблон для mem_out. "mem0" если память не меняется.
      pub mem_expr: String,
      /// Шаблон для pc_out. Обычно "(bvadd pc0 (_ bv4 64))".
      pub pc_expr: String,
      pub n_params: usize,
  }

  impl InlinedSemantics {
      pub fn instantiate_compressed(
          &self, operands: &[String], si: usize, so: usize,
          mi: usize, mo: usize,
      ) -> Vec<String> {
          let mut regs_e = self.regs_expr.replace("regs0", &format!("regs{si}"));
          let mut mem_e  = self.mem_expr .replace("mem0",  &format!("mem{mi}"));
          let mut pc_e   = self.pc_expr  .replace("pc0",   &format!("pc{si}"));
          for i in (0..self.n_params).rev() {
              for expr in [&mut regs_e, &mut mem_e, &mut pc_e] {
                  *expr = expr.replace(&format!("p{i}"), &operands[i]);
              }
          }
          let mut out = vec![
              format!("(= regs{so} {regs_e})"),
              format!("(= pc{so} {pc_e})"),
          ];
          if mi != mo { out.insert(1, format!("(= mem{mo} {mem_e})")); }
          out
      }
  }
  ```,
) <listing-inlined-sem>

При построении правила блока `emit_block_body_rule_inlined` вызывает `instantiate_compressed` для каждой инструкции: результирующие три строки добавляются непосредственно в тело `(and ...)`. Когда `mi == mo` (инструкция не изменяет память), ограничение `(= memN memN)` опускается --- это и есть оптимизация устранения переменных памяти, совмещённая с инлайнингом в одном проходе.

Из 746 вариантов в полном Isla IR `rv64d.ir` успешно транслируются 199. Покрытые инструкции включают полный профиль RV64IM: ITYPE (addi/addiw/andi/ori/xori/slti/sltiu), RTYPE (add/sub/and/or/xor + W-варианты, сдвиги), LOAD (lb/lbu/lh/lhu/lw/lwu/ld), STORE (sb/sh/sw/sd), BRANCH (beq/bne/blt/bge/bltu/bgeu), JAL, JALR, LUI, MUL/MULH/DIV/REM и их варианты. Остальные 547 относятся к расширениям с плавающей точкой (F, D, H), векторным (V), криптографическим (K) и привилегированным (M/S) инструкциям --- для целочисленных программ, генерируемых Csmith, все используемые инструкции покрыты.

Формирование SMT-LIB2-вывода сосредоточено в модуле `src/chc_emit/`, организованном в виде восьми специализированных подмодулей (листинг @listing-submodules).

#figure(
  caption: [Объявление подмодулей chc\_emit (src/chc\_emit/mod.rs, Rust)],
  ```rust
  mod format;            // текстовое представление SMT-выражений
  mod smt;               // трансляция Isla IR Exp -> SMT-строка
  mod known_calls;       // классификация известных Sail вызовов
  mod variant_discovery; // обнаружение вариантов execute в IR-дереве
  mod ir_translate;      // PathTranslation: обход пути варианта
  mod ir_emit;           // InlinedSemantics: шаблоны ограничений
  mod asm_emit;          // emit_program_rule_inlined: правила блоков
  mod equiv;             // emit_equivalence_query: сборка запроса

  pub use ir_emit::emit_instruction_chc;
  pub use equiv::emit_equivalence_query;
  ```,
) <listing-submodules>

Ключевой поток данных через модули: `variant_discovery` находит все пути выполнения в IR для каждого варианта инструкции в `ir_translate` обходит каждый путь и строит структуру `PathTranslation` в `ir_emit` преобразует `PathTranslation` в `InlinedSemantics` --- готовые SMT-шаблоны в `asm_emit` применяет шаблоны к конкретным ассемблерным операндам при построении правил блоков. Функция `emit_equivalence_query` в `equiv.rs` является точкой сборки.

== Разбор RISC-V ассемблера и формирование запроса

Команда `check-equiv` принимает два ассемблерных файла, имя функции, путь к `.ir` и выходной файл.

Разборщик читает GAS-совместимые `.s` файлы и строит для каждой функции список структурированных инструкций. Поддерживаются базовые инструкции RV64GC, псевдоинструкции (`ret` в `jalr x0, 0(ra)`, `mv` в `addi rd, rs, 0`, `li`, `snez`, `zext.b`, `lui`) и сжатые инструкции (`c.addi`, `c.li`, `c.mv`, `c.ld`, `c.sd`, `c.beqz`, `c.bnez`), раскрываемые в базовые при разборе.

Разбор основан на пяти структурах данных, отображающих элементы ассемблерного текста на типизированные объекты Rust (листинг @listing-asm-structs).

#figure(
  caption: [Структуры данных модуля asm\_parse.rs (Rust)],
  ```rust
  pub struct AsmInstruction {
      pub opcode: String,
      pub operands: Vec<Operand>,
  }

  pub enum Operand {
      Reg(String),                          // регистр: "sp", "a0", "ra"
      Imm(i64),                             // непосредственный операнд: -32
      MemRef { offset: i64, base: String }, // ссылка: -20(s0), 24(sp)
      Label(String),                        // цель ветвления: ".LBB0_2"
  }

  pub struct AsmFunction {
      pub name: String,
      pub instructions: Vec<AsmInstruction>,
      pub labels: HashMap<String, usize>,
  }

  pub struct BasicBlock {
      pub id: usize,
      pub instr_range: Range<usize>,
      pub terminator: Terminator,
  }

  pub enum Terminator {
      Branch {
          branch_instr_idx: usize,
          taken_block: usize,
          fallthrough_block: usize,
      },
      Fallthrough(usize),
      Exit,
  }
  ```,
) <listing-asm-structs>

Функция `parse_asm` сканирует текст построчно: при нахождении метки `function_name:` начинает сбор инструкций; при встрече следующей внешней метки (без точки) завершает разбор; внутрифункциональные метки вида `.LBB0_2:` записываются в `labels` с текущим индексом инструкции и впоследствии используются функцией `build_cfg` для выявления границ блоков.

Функция `instruction_to_chc` сопоставляет каждую инструкцию с именем соответствующего CHC-правила и списоком SMT-операндов. Порядок операндов определяется порядком полей в кортеже Sail для каждого класса инструкций (листинг @listing-asm-emit).

#figure(
  caption: [Отображение ассемблерных инструкций в SMT-операнды (asm\_emit.rs, Rust)],
  ```rust
  match op {
      // I-type: addi rd, rs1, imm в (imm_bv12, rs1_idx, rd_idx)
      "addi" | "addiw" | "andi" | "ori" | "xori" | "slti" | "sltiu" => {
          let rd  = reg_to_smt(&instr.operands[0])?;
          let rs1 = reg_to_smt(&instr.operands[1])?;
          let imm = imm_to_bv12(imm_val);
          Ok((op.to_string(), vec![imm, rs1, rd]))
      }
      // Store: sd rs2, off(base) в (off_bv12, rs2_idx, base_idx)
      "sb" | "sh" | "sw" | "sd" => {
          let rs2  = reg_to_smt(rs2_name)?;
          let base = reg_to_smt(base_name)?;
          Ok((op.to_string(), vec![imm_to_bv12(offset), rs2, base]))
      }
      // Load: ld rd, off(base) в (off_bv12, base_idx, rd_idx)
      "lb" | "lbu" | "lh" | "lhu" | "lw" | "lwu" | "ld" => {
          let rd   = reg_to_smt(rd_name)?;
          let base = reg_to_smt(base_name)?;
          Ok((op.to_string(), vec![imm_to_bv12(offset), base, rd]))
      }
      // R-type: add rd, rs1, rs2 в (rs2_idx, rs1_idx, rd_idx)
      "add" | "sub" | "and" | "or" | "xor" | "slt" | "sltu" |
      "sll" | "srl" | "sra" | "addw" | "subw" | "mul" | ... => {
          let rd  = reg_to_smt(&instr.operands[0])?;
          let rs1 = reg_to_smt(&instr.operands[1])?;
          let rs2 = reg_to_smt(&instr.operands[2])?;
          Ok((op.to_string(), vec![rs2, rs1, rd]))
      }
      // Псевдоинструкция: ret = jalr x0, 0(ra)
      "ret" => Ok(("jalr".to_string(),
                   vec!["(_ bv0 12)".into(), "reg_ra".into(),
                        "reg_zero".into()])),
  }
  ```,
) <listing-asm-emit>

Формирование CHC-запроса --- это связывание всех инструкций функции через промежуточные переменные состояния:

$
  ("regs"_0, "mem"_0, "pc"_0) arrow.r^("instr"_1) ("regs"_1, "mem"_1, "pc"_1) arrow.r^("instr"_2) ... arrow.r^("instr"_n) ("regs"_n, "mem"_n, "pc"_n)
$

где $n$ --- количество инструкций функции; каждая тройка $("regs"_i, "mem"_i, "pc"_i)$ --- промежуточное состояние машины после $i$-й инструкции.

Итоговое CHC-правило для блока функции формируется с инлайнингом семантики инструкций --- без промежуточных CHC-отношений. Листинг @listing-func-rule показывает фактически сгенерированное RICOVER правило для блока `func_361_bb0` из бенчмарка Csmith (функция `src`, 10 инструкций, 1 базовый блок).

#figure(
  caption: [Сгенерированное CHC-правило func\_361\_bb0 (SMT-LIB2, вывод RICOVER)],
  raw(
    block: true,
    lang: none,
    "(declare-rel func_361_bb0
  ((Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)
   (Array (_ BitVec 5) (_ BitVec 64))
   (Array (_ BitVec 64) (_ BitVec 8)) (_ BitVec 64)))

(rule
  (forall
    ;; 11 переменных regs0..regs10, только 5 переменных mem0..mem4
    ((regs0 ...) (mem0 ...) (pc0 ...)
     (regs1 ...)             (pc1 ...)
     (regs2 ...) (mem1 ...) (pc2 ...)
     ...
     (regs10 ...)            (pc10 ...))
  (=> (and
        ; addi sp, sp, -32
        (= regs1 (set_reg regs0 reg_sp (bvadd (get_reg regs0 reg_sp)
                          ((_ sign_extend 52) (_ bv4064 12)))))
        (= pc1 (bvadd pc0 (_ bv4 64)))
        ; sd ra, 24(sp)
        (= regs2 regs1)
        (= mem1 (write_mem_dword mem0
                  (bvadd (get_reg regs1 reg_sp)
                         ((_ sign_extend 52) (_ bv24 12)))
                  ((_ extract 63 0) (get_reg regs1 reg_ra))))
        (= pc2 (bvadd pc1 (_ bv4 64)))
        ; ... остальные инструкции ...
        ; ret = jalr x0, 0(ra)
        (= regs10 (set_reg regs9 reg_zero (bvadd pc9 (_ bv4 64))))
        (= pc10 (concat ((_ extract 63 1)
                          (bvadd (get_reg regs9 reg_ra)
                                 ((_ sign_extend 52) (_ bv0 12))))
                        (_ bv0 1))))
      (func_361_bb0 regs0 mem0 pc0 regs10 mem4 pc10))))",
  ),
) <listing-func-rule>

В блоке `forall` видна оптимизация устранения переменных памяти: из 10 инструкций лишь 4 (`sd`, `sd`, `sw`, `sh`) записывают память --- вводятся переменные `mem1`--`mem4`. Инструкции `addi`, `ld` и `ret` не получают собственной переменной `memN`. Константа `(_ bv4064 12)` --- 12-битное дополнение до двух для $-32$ (поскольку $4096 - 32 = 4064$).

Оптимизированная версия `func_362` (8 инструкций, `sw`/`sh` удалены instcombine) содержит только `mem0`--`mem2`: оба мёртвых сохранения исчезли вместе со своими переменными памяти. CHC-решатель Z3 отвечает `unsat` за 27 секунд: мёртвые записи выполнялись в приватный фрейм $["sp"_0 - 32, "sp"_0)$, который исключён из $"ObsMem"$, и ABI-видимые регистры (`a0`, `ra`, `sp`, `s0`) совпадают в обоих вариантах.

== Стандартная библиотека CHC

Стандартная библиотека определяет примитивы, общие для всех сгенерированных запросов. Операции над регистрами реализованы как SMT-функции (листинг @listing-stdlib).

#figure(
  caption: [Операции get\_reg и set\_reg в stdlib.smt2 (SMT-LIB2)],
  raw(
    block: true,
    lang: none,
    ";; Read register: returns 0 for x0, otherwise reads from Regs array
(define-fun get_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx  (_ BitVec 5))) (_ BitVec 64)
  (ite (= idx (_ bv0 5))
       (_ bv0 64)
       (select regs idx)))

;; Write register: writes to x0 are discarded
(define-fun set_reg ((regs (Array (_ BitVec 5) (_ BitVec 64)))
                     (idx  (_ BitVec 5))
                     (val  (_ BitVec 64))) (Array (_ BitVec 5) (_ BitVec 64))
  (ite (= idx (_ bv0 5))
       regs
       (store regs idx val)))",
  ),
) <listing-stdlib>

Функция `get_reg` возвращает 0 при чтении регистра с индексом 0 (`x0` --- особый регистр в RISC-V), `set_reg` игнорирует запись при `idx = 0`. Это гарантирует семантику нулевого регистра без дополнительных ограничений в теле каждого CHC-правила.

Помимо регистровых операций, стандартная библиотека содержит:

- *Операции с памятью:* `mem_read_N` (сырое чтение $N$ байт), `read_mem_word`/`read_mem_dword` (знаковое расширение до 64 бит), `write_mem_word`/`write_mem_dword` (запись в little-endian порядке), аналоги для 1- и 2-байтовых операций;
- *Константы ABI:* `reg_zero = 0b00000`, `reg_ra = 0b00001`, `reg_sp = 0b00010`, `reg_s0 = 0b01000`, `reg_a0 = 0b01010`.

== Модель наблюдаемого состояния и приватный стековый фрейм

Формулировка проекционной эквивалентности $tilde.eq_"proj"$ (формула~2.7) требует точного определения множества $"ObsMem"(sigma_0)$ --- наблюдаемой памяти.

При разборе функции `check-equiv` ищет первую инструкцию вида `addi sp, sp, -N` (или `c.addi sp, -N`). Число $N$ является размером стекового фрейма функции. Приватный фрейм определяется как интервал $["sp"_0 - N, "sp"_0)$, где $"sp"_0$ --- значение указателя стека в начальном состоянии.

CHC-запрос `bad` эмитируется как два правила, реализующих формулы из раздела 2.4, показанные в листинге @listing-bad.

#figure(
  caption: [Bad-state запрос на эквивалентность (SMT-LIB2)],
  raw(
    block: true,
    lang: none,
    "; Компонент 1: расхождение ABI-видимых регистров
(rule (=> (and (P regs0 mem0 pc0 regsP memP pcP)
               (Q regs0 mem0 pc0 regsQ memQ pcQ)
               (or (distinct (get_reg regsP reg_a0)
                             (get_reg regsQ reg_a0))
                   (distinct (get_reg regsP reg_ra)
                             (get_reg regsQ reg_ra))
                   (distinct (get_reg regsP reg_sp)
                             (get_reg regsQ reg_sp))))
         (bad)))

; Компонент 2: расхождение памяти вне приватного фрейма
(rule (=> (and (P regs0 mem0 pc0 regsP memP pcP)
               (Q regs0 mem0 pc0 regsQ memQ pcQ)
               (obs-addr addr regs0)
               (distinct (select memP addr)
                         (select memQ addr)))
         (bad)))

(query bad)",
  ),
) <listing-bad>

Предикат `obs-addr` выводим тогда и только тогда, когда адрес `addr` находится вне приватного фрейма `[sp0 - N, sp0)`, то есть является наблюдаемым. Если `bad` выводимо --- найден контрпример; если нет --- обе программы семантически эквивалентны относительно $tilde.eq_"proj"$.

== Кодирование ветвлений и граф потока управления

Функции с условными переходами требуют многоблочного CHC-кодирования. RICOVER строит граф потока управления (CFG) и кодирует его через два слоя CHC-отношений.

*Построение CFG.* Функция `build_cfg` в `asm_parse.rs` делит функцию на базовые блоки: границы блоков проставляются на начало функции, на инструкцию-цель каждого перехода и на инструкцию сразу после каждой ветки. Блоки отделены друг от друга "терминаторами": `Branch` (условный переход с адресом обоих путей), `Fallthrough` (непосредственный переход к следующему блоку) и `Exit` (блок заканчивается инструкцией `ret`).

Для каждого базового блока `bb<N>` функции `f` генерируются:

+ *Тело блока* --- `f_bb<N>(state_in, state_out)`: цепочка ограничений для инструкций блока (без инструкции-терминатора);
+ *Композиция* --- `f_from_bb<N>(state_in, state_out)`: описывает все пути выполнения от входа в блок `bb<N>` до завершения функции. Для входного блока (`bb0`) эта функция именуется просто `f`.

Такая структура позволяет естественно моделировать обратные рёбра (циклы) через рекурсивные CHC-правила: цикл-заголовок получает рекурсивное правило для `f_from_bb<N>`, а CHC-решатель находит индуктивный инвариант через фиксированную точку.

Рассмотрим функцию `src`:

```
src:
    lw   a3, 0(a2)       ; bb0: загрузка из памяти
    lw   a4, 0(a1)       ; bb0: загрузка из памяти
    blt  a3, a4, .LBB0_2 ; bb0: терминатор - условный переход
    mv   a1, a2          ; bb1: fallthrough
.LBB0_2:
    ld   a1, 0(a1)       ; bb2: загрузка двойного слова
    sd   a1, 0(a0)       ; bb2: сохранение в память
    ret                  ; bb2: выход
```

CFG: `bb0 в (blt взята) в bb2 [exit]`; `bb0 в (blt не взята) в bb1 в bb2 [exit]`.

Функция `build_cfg` разделяет функцию на три блока. `bb0` содержит две инструкции `lw` (тело) и ветку `blt` (терминатор); `bb1` --- одну инструкцию `mv` (терминатор `Fallthrough(2)`); `bb2` --- три инструкции `ld`, `sd`, `ret` (терминатор `Exit`). Листинг @listing-cfg показывает фактически сгенерированные правила CFG-композиции.

#figure(
  caption: [Правила CFG-композиции функции src из PR44306 (SMT-LIB2)],
  raw(
    block: true,
    lang: none,
    ";; Входной блок bb0, ветвь взята (blt a3, a4): тело bb0 -> from_bb2
(rule
  (forall ((regs0 ...) (mem0 ...) (pc0 ...)
           (regs1 ...) (mem1 ...) (pc1 ...)
           (regs2 ...) (mem2 ...) (pc2 ...))
    (=> (and (PR443061_bb0 regs0 mem0 pc0 regs1 mem1 pc1)
             (bvslt (get_reg regs1 (_ bv13 5))
                    (get_reg regs1 (_ bv14 5)))
             (PR443061_from_bb2 regs1 mem1 pc1 regs2 mem2 pc2))
        (PR443061 regs0 mem0 pc0 regs2 mem2 pc2))))

;; Входной блок bb0, ветвь не взята: тело bb0 -> from_bb1
(rule
  (forall ((regs0 ...) (mem0 ...) (pc0 ...)
           (regs1 ...) (mem1 ...) (pc1 ...)
           (regs2 ...) (mem2 ...) (pc2 ...))
    (=> (and (PR443061_bb0 regs0 mem0 pc0 regs1 mem1 pc1)
             (not (bvslt (get_reg regs1 (_ bv13 5))
                         (get_reg regs1 (_ bv14 5))))
             (PR443061_from_bb1 regs1 mem1 pc1 regs2 mem2 pc2))
        (PR443061 regs0 mem0 pc0 regs2 mem2 pc2))))",
  ),
) <listing-cfg>

Условие ветвления `(bvslt ...)` читает регистры из состояния *после* выполнения тела блока (`regs1`), а не из входного состояния (`regs0`): сначала исполняются инструкции-данные блока, затем вычисляется условие перехода. Это соответствует семантике инструкции `blt`: условие проверяется на актуальных значениях регистров в момент ветвления.

Все `declare-rel` эмитируются до всех `rule` --- это требование Z3 Fixedpoint API: при обработке правила каждый предикат, используемый в теле, уже должен быть объявлен. `emit_composition_rules` поэтому делает два прохода: сначала объявляет все отношения, затем эмитирует правила.
