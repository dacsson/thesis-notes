use anyhow::{anyhow, Result};

use std::fs;
use std::path::Path;

use isla_lib::bitvector::b129::B129;
use isla_lib::ir::{Def, Instr, Name, Symtab};
use isla_lib::ir_lexer::new_ir_lexer;
use isla_lib::ir_parser::IrParser;
use isla_lib::zencode;

pub struct IslaIRModel<'ir> {
    pub defs: Vec<Def<Name, B129>>,
    pub symtab: Symtab<'ir>,
}

pub struct IrFunction<'a> {
    pub name: String,
    pub params: Vec<Name>,
    pub body: &'a [Instr<Name, B129>],
}

impl<'ir> IslaIRModel<'ir> {
    pub fn get_function(&self, name: &str) -> Option<IrFunction<'_>> {
        let encoded = zencode::encode(name);
        let id = self.symtab.get(&encoded)?;

        for def in &self.defs {
            if let Def::Fn(fn_id, params, body) = def {
                if *fn_id == id {
                    return Some(IrFunction {
                        name: name.to_string(),
                        params: params.clone(),
                        body,
                    });
                }
            }
        }
        None
    }

    pub fn function_names(&self) -> Vec<String> {
        self.defs
            .iter()
            .filter_map(|def| {
                if let Def::Fn(id, _, _) = def {
                    Some(zencode::decode(self.symtab.to_str(*id)).to_string())
                } else {
                    None
                }
            })
            .collect()
    }

    pub fn resolve_name(&self, name: Name) -> String {
        zencode::decode(self.symtab.to_str(name)).to_string()
    }
}

pub fn parse_ir(contents: &str) -> Result<IslaIRModel<'_>> {
    let mut symtab = Symtab::new();
    let defs = IrParser::new()
        .parse(&mut symtab, new_ir_lexer(contents))
        .map_err(|e| anyhow!("IR parse error: {}", e))?;

    Ok(IslaIRModel { defs, symtab })
}

pub fn read_ir_file(path: &Path) -> Result<String> {
    fs::read_to_string(path).map_err(|e| anyhow!("Failed to read {}: {}", path.display(), e))
}

#[cfg(test)]
mod tests {
    use super::*;

    const RISCV_IR: &str = include_str!("../../../Tools/Sail/Data/riscv.ir");

    #[test]
    fn parse_riscv_ir() {
        let model = parse_ir(RISCV_IR).expect("failed to parse riscv.ir");
        let names = model.function_names();
        assert!(names.contains(&"execute".to_string()), "execute not found in: {:?}", names);
    }

    #[test]
    fn get_execute_function() {
        let model = parse_ir(RISCV_IR).expect("failed to parse riscv.ir");
        let func = model.get_function("execute").expect("execute not found");
        assert!(!func.body.is_empty());
        println!("execute has {} instructions", func.body.len());
    }
}
