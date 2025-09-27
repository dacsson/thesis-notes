[[Verifying Optimizations using SMT Solvers.pdf]]
## Why is this interesting?

Works good as an introduction to using SMT solvers to prove optimization equivalence and in general how they can be applied to LLVM-IR and ASM
## SAT/SMT solvers 

### SAT
SAT - takes a boolean formula input :
$(a \lor b \lor c) \land (\lnot b \lor c)$ 

And returns:
- **SAT** if the formula is satisfiable (if you can find such an assignment)
- **UNSAT** if not 

if **SAT** we get the model:
$a = true, b = false, c= false$

### SMT
Generalization of SAT solver
Variables can be not boolean but can take diff domains:
- Bit-vec tors
- Reals
- Integers
- ...

### BitVector T
They care about it really, because it supports everything from LLVM-IR:
- add/sub/...
- shift and rotate
- zero/sign extended
- bitwise logic op
- comparison 
- concat, extract

- Variables should be of fixed width

#### Example:

Prove that:
	$(x - 1) \&x = 0$ 
	and 
	$x\&(-x)=x$
	are **equivalent**

> (this is instcombine 101) ? 

**Thinking SMT:**
- Both formulas five the same result $\forall x$
or
- There isnt a value for x such that the result of the formulas differs

(this two statements are equivalent, SMT solvers prefers second options (they dont like quantifiers)

Prove:
```z3
(declare-fun x () (_ BitVec 32)) ; declare x of 32bits, everything in SMT is a function
(assert (not (=
	; x&(x-1) == 0
	(= (bvand x (bvsub x #x00000001)) #x00000000)
	
	; x&(-x) == x
	(= (bvand x (bvneg x)) x))
)))

(check-sat) 
	=> unsat => they are equivalent, there is not a value for x that they are not equal
```

But then we ask ourselfs: does it compute x as a power of 2? 
Lets find out:
```z3
(declare-fun x () (_ BitVec 4))
	(assert (not (=
	; x&(x-1) == 0
	(= (bvand x (bvsub x #x1)) #x0)
	
	; x == 1 or x == 2 or x == 4 or x == 8
	(or (= x #x1) (= x #x2) (= x #x4) (= x #x8))
)))

(check-sat) => sat => its not!
(get-model) => #x0
```

## InstCombine

Optimizes sequence of instructions (no loops)

# Do i get this?

Main idea shown is that we can directly encode LLVM-IR and asm in Z3 and prove certain behaviors or that so me invariants appear when they shouldn't. Author gave an example  when they were in disagreement which version of assembly code is the right translation from LLVM-IR and then they run their versions through Z3 asking whether llvm-ir-function is equivalent to asm-function (first and second options). 