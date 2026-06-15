use anyhow::Result;
use clap::Parser;
use std::path::PathBuf;

/// RICOVER — RISC-V Compiler Optimization Verification via CHC
#[derive(Parser)]
#[command(name = "ricover")]
enum Cli {
    /// Translate Isla IR instruction definitions to CHC
    TranslateIR {
        /// Path to .ir file (e.g., riscv64.ir)
        #[arg(short, long)]
        ir_file: PathBuf,

        /// Output .smt2 file with CHC instruction definitions
        #[arg(short, long)]
        output: PathBuf,

        /// Instruction names to translate (e.g., "execute")
        #[arg(short, long)]
        functions: Vec<String>,
    },

    /// Emit CHC equivalence query from two RISC-V assembly functions
    CheckEquiv {
        /// Path to first .s file (unoptimized)
        #[arg(long)]
        before: PathBuf,

        /// Path to second .s file (optimized)
        #[arg(long)]
        after: PathBuf,

        /// Function name to look up in both files. The two sides are
        /// renamed to `<function>1` (before) and `<function>2` (after) in
        /// the emitted query so they don't collide. When `--before-fn` /
        /// `--after-fn` are set they override the lookup label per side
        /// (useful when both versions live under different labels in one file).
        #[arg(short, long)]
        function: String,

        /// Override the label looked up in the `--before` file.
        #[arg(long)]
        before_fn: Option<String>,

        /// Override the label looked up in the `--after` file.
        #[arg(long)]
        after_fn: Option<String>,

        /// Output .smt2 file with equivalence query
        #[arg(short, long)]
        output: PathBuf,

        /// Path to .ir file — IR-derived rules are used for covered opcodes,
        /// hand-written fallback rules are emitted (with a warning) for the rest.
        #[arg(long)]
        ir: PathBuf,
    },
}

fn main() -> Result<()> {
    let cli = Cli::parse();

    match cli {
        Cli::TranslateIR { ir_file, output, functions } => {
            let contents = ricover::isla_ir::read_ir_file(&ir_file)?;
            let model = ricover::isla_ir::parse_ir(&contents)?;
            let chc = ricover::chc_emit::emit_instruction_chc(&model, &functions)?;
            std::fs::write(&output, chc)?;
            println!("Wrote CHC instruction definitions to {}", output.display());
        }
        Cli::CheckEquiv { before, after, function, before_fn, after_fn, output, ir } => {
            let before_label = before_fn.as_deref().unwrap_or(&function);
            let after_label = after_fn.as_deref().unwrap_or(&function);
            let mut prog1 = ricover::asm_parse::parse_asm_file(&before, before_label)?;
            let mut prog2 = ricover::asm_parse::parse_asm_file(&after, after_label)?;
            prog1.name = format!("{function}1");
            prog2.name = format!("{function}2");
            let ir_contents = ricover::isla_ir::read_ir_file(&ir)?;
            let model = ricover::isla_ir::parse_ir(&ir_contents)?;
            let mem1 = ricover::asm_parse::count_mem_ops(&prog1);
            let mem2 = ricover::asm_parse::count_mem_ops(&prog2);
            let query = ricover::chc_emit::emit_equivalence_query(&prog1, &prog2, &function, Some(&model))?;
            std::fs::write(&output, query)?;
            println!("Wrote equivalence query to {}", output.display());
            println!(
                "  before: {} instrs ({} mem ops), after: {} instrs ({} mem ops)",
                prog1.instructions.len(), mem1, prog2.instructions.len(), mem2
            );
            if mem1 > 12 {
                eprintln!(
                    "warning: {} has {} memory ops — solver may timeout (practical limit ~12)",
                    before_label, mem1
                );
            }
        }
    }

    Ok(())
}
