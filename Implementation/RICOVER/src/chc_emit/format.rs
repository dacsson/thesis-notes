// --- Formatting helpers (kept for IR dump / debugging) ---

use isla_lib::bitvector::b129::B129;
use isla_lib::ir::{Exp, Instr, Loc, Name, Op};

use crate::isla_ir::IslaIRModel;

pub(crate) fn format_instr(model: &IslaIRModel, instr: &Instr<Name, B129>) -> String {
    match instr {
        Instr::Decl(id, ty, _) => format!("decl {} : {:?}", model.resolve_name(*id), ty),
        Instr::Init(id, ty, exp, _) => {
            format!("init {} : {:?} = {}", model.resolve_name(*id), ty, format_exp(model, exp))
        }
        Instr::Copy(loc, exp, _) => format!("{} = {}", format_loc(model, loc), format_exp(model, exp)),
        Instr::Call(loc, _, func_id, args, _) => {
            let args_str: Vec<String> = args.iter().map(|a| format_exp(model, a)).collect();
            format!("{} = {}({})", format_loc(model, loc), model.resolve_name(*func_id), args_str.join(", "))
        }
        Instr::Jump(exp, target, _) => format!("jump {} goto {}", format_exp(model, exp), target),
        Instr::Goto(target) => format!("goto {}", target),
        Instr::End => "end".to_string(),
        Instr::Exit(cause, _) => format!("exit {:?}", cause),
        Instr::Arbitrary => "arbitrary".to_string(),
        _ => format!("{:?}", instr),
    }
}

pub(crate) fn format_loc(model: &IslaIRModel, loc: &Loc<Name>) -> String {
    match loc {
        Loc::Id(id) => model.resolve_name(*id),
        Loc::Field(inner, field) => format!("{}.{}", format_loc(model, inner), model.resolve_name(*field)),
        Loc::Addr(inner) => format!("*{}", format_loc(model, inner)),
    }
}

pub(crate) fn format_exp(model: &IslaIRModel, exp: &Exp<Name>) -> String {
    match exp {
        Exp::Id(id) => model.resolve_name(*id),
        Exp::Ref(id) => format!("&{}", model.resolve_name(*id)),
        Exp::Bool(b) => b.to_string(),
        Exp::Bits(bv) => format!("{}", bv),
        Exp::String(s) => format!("\"{}\"", s),
        Exp::Unit => "()".to_string(),
        Exp::I64(n) => n.to_string(),
        Exp::I128(n) => n.to_string(),
        Exp::Undefined(ty) => format!("undefined:{:?}", ty),
        Exp::Struct(name, fields) => {
            let fs: Vec<String> = fields
                .iter()
                .map(|(f, e)| format!("{} = {}", model.resolve_name(*f), format_exp(model, e)))
                .collect();
            format!("struct {} {{{}}}", model.resolve_name(*name), fs.join(", "))
        }
        Exp::Kind(ctor, inner) => format!("{} is {}", format_exp(model, inner), model.resolve_name(*ctor)),
        Exp::Unwrap(ctor, inner) => format!("{} as {}", format_exp(model, inner), model.resolve_name(*ctor)),
        Exp::Field(inner, field) => format!("{}.{}", format_exp(model, inner), model.resolve_name(*field)),
        Exp::Call(op, args) => {
            let args_str: Vec<String> = args.iter().map(|a| format_exp(model, a)).collect();
            format!("{}({})", format_op(op), args_str.join(", "))
        }
    }
}

pub(crate) fn format_op(op: &Op) -> &'static str {
    match op {
        Op::Not => "@not",
        Op::Or => "@or",
        Op::And => "@and",
        Op::Eq => "@eq",
        Op::Neq => "@neq",
        Op::Lteq => "@lteq",
        Op::Lt => "@lt",
        Op::Gteq => "@gteq",
        Op::Gt => "@gt",
        Op::Add => "@iadd",
        Op::Sub => "@isub",
        Op::Bvnot => "@bvnot",
        Op::Bvor => "@bvor",
        Op::Bvxor => "@bvxor",
        Op::Bvand => "@bvand",
        Op::Bvadd => "@bvadd",
        Op::Bvsub => "@bvsub",
        Op::Bvaccess => "@bvaccess",
        Op::Concat => "@concat",
        Op::Head => "@hd",
        Op::Tail => "@tl",
        Op::Slice(_) => "@slice",
        Op::SetSlice => "@set_slice",
        Op::Signed(_) => "@signed",
        Op::Unsigned(_) => "@unsigned",
        Op::ZeroExtend(_) => "@zero_extend",
        _ => "@unknown",
    }
}
