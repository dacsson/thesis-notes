use std::collections::HashMap;

use anyhow::{anyhow, Result};

use isla_lib::bitvector::BV;
use isla_lib::ir::{Exp, Name, Op, Ty};

use crate::isla_ir::IslaIRModel;
use super::format::format_exp;

// SMT variable name for an IR Name
fn smt_var(model: &IslaIRModel, name: Name) -> String {
    let decoded = model.resolve_name(name);
    // Sanitize: replace # and % with _
    decoded.replace('#', "_").replace('%', "_").replace(' ', "_")
}

/// Translate an expression to SMT-LIB2.
/// `bindings` maps IR variable names to their SMT expressions (for inlining copies).
///
/// Returns Err on unsupported expressions — a verification tool must never
/// silently emit placeholder comments instead of real semantics.
pub(crate) fn exp_to_smt(model: &IslaIRModel, exp: &Exp<Name>, bindings: &HashMap<Name, String>) -> Result<String> {
    match exp {
        Exp::Id(id) => {
            if let Some(bound) = bindings.get(id) {
                Ok(bound.clone())
            } else {
                Ok(smt_var(model, *id))
            }
        }
        Exp::Bits(bv) => {
            let len = bv.len();
            // BV literals wider than 64 bits cannot be represented via lower_u64().
            // Fail explicitly rather than silently truncating upper bits.
            if len > 64 {
                Err(anyhow!(
                    "bitvector literal wider than 64 bits (width {}): cannot represent with lower_u64()",
                    len
                ))
            } else {
                Ok(format!("(_ bv{} {})", bv.lower_u64(), len))
            }
        }
        Exp::I64(n) => Ok(format!("{}", n)),
        Exp::I128(n) => Ok(format!("{}", n)),
        Exp::Bool(b) => Ok(if *b { "true" } else { "false" }.to_string()),
        Exp::Unit => Ok("(_ unit)".to_string()),
        Exp::Call(op, args) => {
            let smt_args: Vec<String> = args.iter()
                .map(|a| exp_to_smt(model, a, bindings))
                .collect::<Result<_>>()?;
            match op {
                Op::Not => Ok(format!("(not {})", smt_args[0])),
                Op::And => Ok(format!("(and {})", smt_args.join(" "))),
                Op::Or => Ok(format!("(or {})", smt_args.join(" "))),
                Op::Eq => Ok(format!("(= {} {})", smt_args[0], smt_args[1])),
                Op::Neq => Ok(format!("(not (= {} {}))", smt_args[0], smt_args[1])),
                Op::Bvadd => Ok(format!("(bvadd {} {})", smt_args[0], smt_args[1])),
                Op::Bvsub => Ok(format!("(bvsub {} {})", smt_args[0], smt_args[1])),
                Op::Bvand => Ok(format!("(bvand {} {})", smt_args[0], smt_args[1])),
                Op::Bvor => Ok(format!("(bvor {} {})", smt_args[0], smt_args[1])),
                Op::Bvxor => Ok(format!("(bvxor {} {})", smt_args[0], smt_args[1])),
                Op::Bvnot => Ok(format!("(bvnot {})", smt_args[0])),
                Op::Concat => Ok(format!("(concat {} {})", smt_args[0], smt_args[1])),
                Op::Slice(n) => Ok(format!("((_ extract {} 0) {})", n - 1, smt_args[0])),
                Op::ZeroExtend(n) => Ok(format!("((_ zero_extend {}) {})", n, smt_args[0])),
                Op::Signed(n) => Ok(format!("((_ sign_extend {}) {})", n, smt_args[0])),
                Op::Unsigned(_) => Ok(format!("(bv2nat {})", smt_args[0])),
                Op::Lt => Ok(format!("(bvslt {} {})", smt_args[0], smt_args[1])),
                Op::Lteq => Ok(format!("(bvsle {} {})", smt_args[0], smt_args[1])),
                Op::Gt => Ok(format!("(bvsgt {} {})", smt_args[0], smt_args[1])),
                Op::Gteq => Ok(format!("(bvsge {} {})", smt_args[0], smt_args[1])),
                _ => Err(anyhow!("unsupported IR operator: {:?}", op)),
            }
        }
        Exp::Field(inner, field) => {
            // Struct field access — inline as variable reference
            let inner_smt = exp_to_smt(model, inner, bindings)?;
            let field_name = model.resolve_name(*field);
            Ok(format!("{}_{}", inner_smt, field_name))
        }
        Exp::Unwrap(_ctor, inner) => {
            // Union unwrap — for our purposes, same as the inner expression
            // since we've already dispatched on the variant via jump
            exp_to_smt(model, inner, bindings)
        }
        Exp::Kind(_ctor, inner) => {
            // Kind checks should be handled by jump dispatch in discover_variants,
            // not appear in expression context during translation.
            Err(anyhow!(
                "unexpected Kind check in expression context: {} is {}",
                format_exp(model, inner),
                model.resolve_name(*_ctor)
            ))
        }
        _ => Err(anyhow!("unsupported IR expression: {:?}", exp)),
    }
}

pub(crate) fn ty_to_smt(ty: &Ty<Name>) -> Result<String> {
    match ty {
        Ty::Bits(n) => Ok(format!("(_ BitVec {})", n)),
        Ty::AnyBits => Ok("(_ BitVec 64)".to_string()), // default width
        Ty::Bool => Ok("Bool".to_string()),
        Ty::I64 => Ok("Int".to_string()),
        Ty::I128 => Ok("Int".to_string()),
        Ty::Unit => Ok("Bool".to_string()), // dummy
        _ => Err(anyhow!("unsupported IR type in SMT translation: {:?}", ty)),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ty_to_smt_bitvec() {
        assert_eq!(ty_to_smt(&Ty::Bits(12)).unwrap(), "(_ BitVec 12)");
        assert_eq!(ty_to_smt(&Ty::Bits(64)).unwrap(), "(_ BitVec 64)");
        assert_eq!(ty_to_smt(&Ty::Bits(1)).unwrap(), "(_ BitVec 1)");
    }

    #[test]
    fn ty_to_smt_anybits() {
        assert_eq!(ty_to_smt(&Ty::AnyBits).unwrap(), "(_ BitVec 64)");
    }

    #[test]
    fn ty_to_smt_bool() {
        assert_eq!(ty_to_smt(&Ty::Bool).unwrap(), "Bool");
    }

    #[test]
    fn ty_to_smt_int_types() {
        assert_eq!(ty_to_smt(&Ty::I64).unwrap(), "Int");
        assert_eq!(ty_to_smt(&Ty::I128).unwrap(), "Int");
    }

    #[test]
    fn ty_to_smt_unit() {
        assert_eq!(ty_to_smt(&Ty::Unit).unwrap(), "Bool");
    }

    #[test]
    fn ty_to_smt_unsupported() {
        let result = ty_to_smt(&Ty::Enum(Name::from_u32(0)));
        assert!(result.is_err());
        assert!(result.unwrap_err().to_string().contains("unsupported IR type"));
    }
}
