## Semantic equivalence

*Semantic equivalence* is a specific kind if program equivalence under chosen semantics. We can define semantics in different ways: operational, small-step, big-step etc. But, because we are in a domain of assembly language we can greatly benefit from architectural specifications of processors, when defining and using operational semantics of such low-level code.
### Defining semantics
- [Reference](https://arxiv.org/pdf/2108.00739)

An imperative program defines a relation $\langle s, \sigma_0 \rangle \implies \sigma_1$, which means that if statement $s$
is executed in initial state $\sigma_0$, then $\sigma_1$ is the state after execution of $s$, assuming that
the execution halts.  The relation $\implies$ can be specified by *Horn clauses*, using
the operational semantics of the language of $s$, in two main styles: *small-step* (structural
operational semantics) or *big-step* (natural semantics). Let the predicate $exec(S,St_0,St_1)$ represent the relation, where $S$, $St_0$ and $St_1$ are first-order terms representing $s$, $\sigma_0$ and $\sigma_1$, respectively.

In the small-step style the exec relation is specified as a chain of steps. In a single step
$\langle s_0, \sigma_0 \rangle \implies \langle s_1,\sigma_1 \rangle$, $s_0$ is executed in state $\sigma_0$, leaving the remaining statement $s_1$ to be
executed in state $\sigma_1$; this is represented by the relation $step(S0,St0,S1,St1)$ in which
$S0, St0, S1, St1 \equiv s_0, \sigma_0, s_1, \sigma_1$. 

**Definition 1.** The chain of steps, or *run*, is defined by the recursively defined relation $run(S0,St0,S1,St1)$, which specifies the reflexive, transitive closure $\Rightarrow^\star$, encompassing many transitions specified by $\Rightarrow$. 

$$
Run(P, \sigma_0): \langle s_o, \sigma_0 \rangle \Rightarrow^* \langle halt, \sigma_n \rangle
$$

A complete execution is therefore:  $\langle s, \sigma_0 \rangle \implies \sigma_1 \iff \langle s, \sigma_0 \rangle \Rightarrow^\star \langle halt, \sigma_n \rangle$, meaning that after $n$ transition we reach $halt$ statement.

$$
exec(S,St0,St1) \leftarrow run(S,St0,halt,St1) 
$$
$$
run(S,St,S,St) \leftarrow \top 
$$
$$
run(S0,St0,S2,St2) \leftarrow step(S0,St0,S1,St1), run(S1,St1,S2,St2).
$$
Instead of defining $step$ for each construct in RISC-V assembly, we can instead take it from architectural specification.

### Architectural specification

*Sail* is a language for expressing the instruction-set architecture (ISA) semantics of processors and RISC-V Sail is a formal specification of the RISC-V architecture, written in Sail, adopted by RISC-V International. 

Indeed, it defines a $try\_step$ function in it's model source code:
```
// A "step" is a full execution of an instruction, resulting either
// in its retirement or a trap.
...
function try_step(step_no : nat, exit_wait : bool) -> bool = {
```
As well as $execute$ function for each instruction:
```

scattered union instruction

union ExecutionResult = {
  // Successfully retired.
  Retire_Success                 : unit,
  ...
}

val execute : instruction -> ExecutionResult
```
For example, here is the $execute$ function for integer arithemtic basic instructions:
```
function clause execute ITYPE(imm, rs1, rd, op) = {
  let immext : xlenbits = sign_extend(imm);
  X(rd) = match op {
    ADDI  => X(rs1) + immext,
    SLTI  => zero_extend(bool_to_bit(X(rs1) <_s immext)),
    SLTIU => zero_extend(bool_to_bit(X(rs1) <_u immext)),
    ANDI  => X(rs1) & immext,
    ORI   => X(rs1) | immext,
    XORI  => X(rs1) ^ immext
  };
  RETIRE_SUCCESS
}
```

This RISC-V model description gives us information on registers, program counter, memory state, etc. during execution of each statement. 

**Definition 2.**  A final state of execution is expressed as a tuple of program counter, current register assignments (a mapping from register name to value) and a memory state (a mapping from address to value).
$$
\langle pc, regs, memory \rangle
$$
### Equivalence relation
- [Reference](http://profs.sci.univr.it/~merro/files/equality.pdf)

A semantic equivalence relation should have the following properties:
1. Programs that results in observably-different values (starting from some initial store) must not be equivalent
2. Programs that terminates must not be equivalent to programs that don’t
3. $\simeq$ must be an equivalence relation:
	- $e \simeq e$, $e_1 \simeq e_2 \implies e_2 \simeq e_1$, $e_1 \simeq e_2 \simeq e_3 \implies e_1 \simeq e_3$, meaning the relation is reflexive, symmetric and transitive
4. $\simeq$ must be a **congruence**, i.e. preserved by program contexts:
	- if $e_1 \simeq e_2$ then for any context $C [·]$ we must have $C [e_1] \simeq C [e_2]$
	- if the equality $\simeq$ is a congruence then it suffices to prove that the two sub-programs are equivalent., the equality of the whole systems, follows for free!
5. $\simeq$ should relate as many programs as possible

**Definition 3.** Two programs are said to be *semantically equivalent* iff they either both diverge or they both terminate and then the final states that they reach are similar, where final state is a final architectural configuration after executing $n$ statements and reaching a $halt$ statement.
$$
P \simeq Q \iff \forall \sigma_0.(Run(P) \land Run(Q)) \implies \langle pc_P, regs_P, mem_P \rangle = \langle pc_Q, regs_Q, mem_Q \rangle
$$
## Constrained Horn Clauses

*Constrained Horn Clauses* (CHC) provide a suitable basis for automatic program verification [[Horn Clause Solvers for Program Verification | ref]].  

A CHC is a formula in first order logic in the form:
$$
\phi \land p_1(V) \space \land \space ... \space \land \space p_k(V) \implies H
$$
Where:
- $A$ is a constraint language, i.e. our theory (arrays, bit-vectors, etc.)
- $\phi$ is a **constraint** in $A$
- $p_1...p_k$ are **uninterpreted relation symbols**
- each $p_i(V)$ is an **application of the predicate to variables** 
- $H$ is either some application $p_i(V)$ or $false$
## Example

We want to prove that the following property holds:
$$
SemEq: 
$$
For the following programs, generated from C source file, applying a *constant propagation* optimization in program (2) and disabling such optimization in program (1):
```c  
int foo() {  
    int x = 1;  
    int y = x + 2;  
    return y;  
}  
```

Programs:
```
<foo>:                                  <foo>:
addi   sp,sp,-32                        addi    a0,zero,3
sd ra,24(sp)                            jalr    zero,0(ra)
sd s0,16(sp) 
addi   s0,sp,32 
addi   a0,zero,1 ; x = 1 
sw a0,-20(s0) ; x = 1 
lw a0,-20(s0) ; y = x + 2
addiw  a0,a0,2 ; y = x + 2 
sw a0,-24(s0) ; y = x + 2 
lw a0,-24(s0) ; return y 
ld ra,24(sp) ; return y 
ld s0,16(sp) ; return y 
addi   sp,sp,32 ; return y 
jalr   zero,0(ra) ; return y
```

==IN PROGRESS==