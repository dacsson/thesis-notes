[Wiki](https://github.com/rems-project/sail/wiki/Sail-Internals)

## SMT 

We can dump initial SMTLIB:
```
~ => sail -o myoutput --dsmt-verbose isla-sail/riscv.sail
~/Uni/Thesis/isla  =>  sail -o myoutput --dsmt-verbose isla-sail/riscv.sail
Prove (src/lib/type_check.ml/1131)  |- (('n == 'm | 'n != 'm) & (not('n != 'm) | not('n == 'm)))
SMTLIB2 constraints are:
(push)
(declare-const v0 Int)
(declare-const v1 Int)

(assert (not (and (or (= v1 v0) (not (= v1 v0))) (or (not (not (= v1 v0))) (not (= v1 v0))))))
(check-sat)
(pop)

SMTLIB2 constraints are:
(push)
(declare-const v1 Int)
(declare-const v0 Int)

(assert (= v1 v0))
(check-sat)
(pop)

Prove (src/lib/type_check.ml/1059) '_#m == 'ex28# |- true
SMTLIB2 constraints are:
(push)
(declare-const v1 Int)
(declare-const v0 Int)

(assert (= v1 v0))
(check-sat)
(pop)
...
```

## JIB IR 

From old manual (is this relevant?)

Starting with some Sail such as:
```
default order dec

$include <prelude.sail>

register r : bits(32)

$property
function property(xs: bits(32)) -> bool = {
  ys : bits(32) = 0x1234_5678;
  if (r[0] == bitzero) then {
    ys = 0xffff_ffff
  } else {
    ys = 0x0000_0000
  };
  (ys == sail_zeros(32) | ys == sail_ones(32))
}
```

We first compile to Jib, then inline all functions and flatten the
resulting code into a list of instructions as below. The Sail->Jib
step can be parameterised in a few ways so it differs slightly to when
we compile Sail to C. First, a specialisation pass specialises
integer-polymorphic functions and builtins, which is reflected in the
name mangling scheme so, e.g.
```
zz7mzJzK0zCz0z7nzJzK32#bitvector_access
```
is a specialised version of bitvector access for 'n => 32 & 'm => 0.
This lets us generate optimal SMT operations for monomorphic code, as
the SMTLIB operations like ZeroExtend and Extract are only defined for
natural number constants and bitvectors of known lengths. We also have
to treat zero-length bitvectors differently to C, as SMT does not
allow zero-length bitvectors, and unlike when we compile to C, we can
have fixed-precision bitvectors of greater that 64-bits in the
generated Jib.

```
var ys#u12_l#9 : fbits(32, dec)
ys#u12_l#9 : fbits(32, dec) = UINT64_C(0x12345678)
var gs#2#u12_l#15 : bool
var gs#1#u12_l#17 : bit
gs#1#u12_l#17 : bit = zz7mzJzK0zCz0z7nzJzK32#bitvector_access(R, 0l)
gs#2#u12_l#15 : bool = eq_bit(gs#1#u12_l#17, UINT64_C(0))
kill gs#1#u12_l#17 : bit
var gs#6#u12_l#16 : unit
jump gs#2#u12_l#15 then_13
ys#u12_l#9 : fbits(32, dec) = UINT64_C(0x00000000)
gs#6#u12_l#16 : unit = UNIT
goto endif_14
then_13:
ys#u12_l#9 : fbits(32, dec) = UINT64_C(0xFFFFFFFF)
gs#6#u12_l#16 : unit = UNIT
endif_14:
kill gs#2#u12_l#15 : bool
var gs#5#u12_l#10 : bool
var gs#3#u12_l#14 : fbits(32, dec)
gs#3#u12_l#14 : fbits(32, dec) = zz7nzJzK32#sail_zeros(32l)
gs#5#u12_l#10 : bool = zz7nzJzK32#eq_bits(ys#u12_l#9, gs#3#u12_l#14)
kill gs#3#u12_l#14 : fbits(32, dec)
var gs#7#u12_l#11 : bool
jump gs#5#u12_l#10 then_11
var gs#4#u12_l#12 : fbits(32, dec)
var gs#0#u9_l#13 : fbits(32, dec)
gs#0#u9_l#13 : fbits(32, dec) = zz7nzJzK32#sail_zeros(32l)
gs#4#u12_l#12 : fbits(32, dec) = zz7nzJzK32#not_vec(gs#0#u9_l#13)
kill gs#0#u9_l#13 : fbits(32, dec)
goto end_inline_10
end_inline_10:
gs#7#u12_l#11 : bool = zz7nzJzK32#eq_bits(ys#u12_l#9, gs#4#u12_l#12)
kill gs#4#u12_l#12 : fbits(32, dec)
goto endif_12
then_11:
gs#7#u12_l#11 : bool = true
endif_12:
return : bool = gs#7#u12_l#11
kill gs#5#u12_l#10 : bool
kill ys#u12_l#9 : fbits(32, dec)
end
undefined bool
```