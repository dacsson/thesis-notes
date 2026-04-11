## Semantic equivalence

*Semantic equivalence* is a specific kind if program equivalence under chosen semantics. We can define semantics in different ways: operational, small-step, big-step etc. But, because we are in a domain of assembly language we can greatly benefit from architectural specifications of processors, when defining and using operational semantics of such low-level code.
### Defining semantics
- [Reference](https://arxiv.org/pdf/2108.00739)

An imperative program defines a relation $\langle s, \sigma_0 \rangle \implies \sigma_1$, which means that if statement $s$
is executed in initial state $\sigma_0$, then $\sigma_1$ is the state after execution of $s$, **assuming that**
**the execution halts**.  The relation $\implies$ can be specified by *Horn clauses*, using
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

A $halt$ is not a real statement/instruction, if, let's say, we are defined operational semantics for each instruction in RISC-V assembly language. Instead, we add this statement to our language to define program execution stop. For example, a *"halt instruction"* does not update the instruction pointer in operational semantics rules. As a result, the next instruction we will read upon ever encountering $halt$ is the same $halt$ instruction. This mechanism of representing normal program termination by trivially looping forever is standard in small-step operational semantics

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

> TODO: mention that we need to translate this to CHC to create a transition to CHC chapter

> PUT IN INTRODUCTION: In order to translate a relational program property into CHCs, first we need to specify the operational semantics of our imperative language by a set of CHCs. [3.2](https://www.sci.unich.it/~deangelis/papers/DeAngelisFPP_SAS-16.pdf)

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

We, however, define *partial equivalence* of programs, meaning we don't require proof of termination under the same input, nor do we uphold that *"Programs that terminates must not be equivalent to programs that don’t"*.

**Definition 3.** Two programs are said to be *semantically equivalent* iff they either both terminate and then the final states that they reach are similar, where final state is a final architectural configuration after executing $n$ statements and reaching a $halt$ statement.

$$
P \simeq Q \iff \forall \sigma_0.(Run(P) \land Run(Q)) \implies \langle pc_P, regs_P, mem_P \rangle = \langle pc_Q, regs_Q, mem_Q \rangle
$$
## Constrained Horn Clauses

Constrained Horn clauses are a class of first-order logic formulas where the Horn clause format is extended by the use of formulas of an arbitrary, possibly non-Horn, constraint theory [[TransformationOfCHC.pdf | posted verbatim]].  CHCs provide a suitable intermediate form for expressing the semantics of a variety
of programming languages (imperative, functional, concurrent, etc.) and computational
models (state machines, transition systems, big- and small-step operational semantics,
Petri nets, etc.). As a result it has been used as a target language for software verification [[Analysis and Transformation Tools for CHC.pdf|ref]].

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

*Constrained Horn Clauses*  provide a suitable basis for automatic program verification [[Horn Clause Solvers for Program Verification | ref]].  Horn clauses naturally encode the set of reachable states of sequential programs, so satisfiable Horn clauses are program properties that hold. In contrast, unsatisfiable Horn clauses correspond to violated program properties [[Horn Clause Solvers for Program Verification | verbatim]]. 

> TODO: maybe put a default "sum_up_to" example?
## Example

Here, let's try to prove partial equivalence of the following programs, generated from C source code, applying a *constant propagation* optimization in program (2) and disabling such optimization in program (1):
```c  
int foo() {  
    int x = 1;  
    int y = x + 2;  
    return y;  
}  
```

Programs:
```
   <foo1>:                                 <foo2>:
1  addi   sp,sp,-32                        addi    a0,zero,3
2  sd ra,24(sp)                            jalr    zero,0(ra)
3  sd s0,16(sp) 
4  addi   s0,sp,32 
5  addi   a0,zero,1 ; x = 1 
6  sw a0,-20(s0) ; x = 1 
7  lw a0,-20(s0) ; y = x + 2
8  addiw  a0,a0,2 ; y = x + 2 
9  sw a0,-24(s0) ; y = x + 2 
10 lw a0,-24(s0) ; return y 
11 ld ra,24(sp) ; return y 
12 ld s0,16(sp) ; return y 
13 addi   sp,sp,32 ; return y 
14 jalr   zero,0(ra) ; return y
```


For each function we need to translate `execute` functions from Sail to CHC/CLP and then the function itself is just a sequence of executing each instruction function:

Take `foo2()` since a tit bit easier, we have `addi` and `jalr`:

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

=>

addi(state(PC0,REGS0,MEMORY0), state(PC1,REGS1,MEMORY1), imm, rs1, rd) :-
	; X(rs1)
	get_reg_value(REGS0, Rs1, Rs1val),
	; X(rs1) + immext
	Res is Rs1val + Imm,
	; X(rd) = ...
	write_reg_value(REGS0, REGS1, Rd, Res),
	PC1 is PC + 4.
```

```

// Jump execution to a specified target address. This can fail
// due to the target not being 4-byte aligned, or due to extension checks.
// Callers must ensure that the target address is 2-byte aligned.
function jump_to(target : xlenbits) -> ExecutionResult = {
  // Extensions get the first checks on the prospective target address.
  match ext_control_check_pc(target) {
    Some(e) => return Ext_ControlAddr_Check_Failure(e),
    None()  => (),
  };

  // Perform standard alignment check.
  // Check target is at least 2-byte aligned (callers must ensure
  // this so it can be an assertion).
  assert(target[0] == 0b0);
  // If it is not 4-byte aligned and compressed instructions are
  // not enabled then raise an alignment exception.
  if bit_to_bool(target[1]) & not(currentlyEnabled(Ext_Zca))
  then return Memory_Exception(Virtaddr(target), E_Fetch_Addr_Align());

  set_next_pc(target);
  RETIRE_SUCCESS
}

function clause execute JALR(imm, rs1, rd) = {
  // For the sequential model, the memory-model definition doesn't work directly
  // if rs1 = rd. We would effectively have to keep a regfile for reads and another for
  // writes, and swap on instruction completion. This could perhaps be optimized in
  // some manner, but for now, we just keep a reordered definition to improve simulator
  // performance.

  update_elp_state(rs1);

  let link_address = get_next_pc();
  let target = X(rs1) + sign_extend(imm);
  match jump_to([target with 0 = 0b0]) {
    Retire_Success() => { X(rd) = link_address; Retire_Success() },
    failure => failure,
  }
}

=>

jalr(state(PC0,REGS0,MEMORY0), state(PC1,REGS1,MEMORY1), imm, rs1, rd) :-
	; X(rs1)
	get_reg_value(REGS0, Rs1, Rs1val),
	; link_address = get_next_pc()
	ReturnAddr is PC0 + 4,
	; X(rs1) + sign_extend(imm)
	Target is Rs1val + Imm,
	; jump_to()
	PC1 is Target,
	; X(rd) = link_address
	write_reg_value(REGS0, REGS1, Rd, ReturnAddr),
```

```
foo2(StateIn, StateOut) .
foo2(StateIn, StateOut) :-
	addi(StateIn, StateOut, 3, A0, 0),
	jalr(StateIn, StateOut, 0, Ra)
```

### Why one query is `unsat` and the other is `sat`

The important subtlety in this example is that the answer depends on what we mean by "equivalent".

If we encode equivalence as **observable function-boundary equivalence**, then `foo1` and `foo2` should be equivalent:

- both return `3` in `a0`
- both preserve the relevant boundary registers after return
- from the caller's perspective, they have the same result

In CHC form we can express a **bad state** saying:

> There exists an initial state such that both functions terminate, but their observable outcomes differ.

Schematically:

$$
bad_{obs} \leftarrow foo1(S_0, S_1), foo2(S_0, S_2), obs(S_1) \neq obs(S_2)
$$

If the solver answers:

$$
query(bad_{obs}) = unsat
$$

then no such counterexample exists, so the two functions are equivalent under the chosen observable semantics.

However, if we encode equivalence as **full final-state equality**, then the answer changes.  
The unoptimized `foo1` writes temporary values to stack memory:

- it stores `x = 1`
- it stores `y = 3`

The optimized `foo2` computes the same return value without performing those stack writes.

So if we ask for:

$$
\langle regs_1, mem_1 \rangle = \langle regs_2, mem_2 \rangle
$$

then the memory components may differ even though the returned result is the same.

The corresponding bad state is:

$$
bad_{full} \leftarrow foo1(S_0, S_1), foo2(S_0, S_2), S_1 \neq S_2
$$

and this query can be:

$$
query(bad_{full}) = sat
$$

because the solver can exhibit a model in which the final memories differ.

This is exactly why a formula that requires equality of the **entire final machine state** is too strong for optimization validation. It rejects optimizations that preserve externally visible behavior but change internal artifacts such as:

- stack layout
- temporary stores
- scratch-register usage
- precise control-flow shape

For this reason, the right notion for the thesis is not raw full-state equality, but equality of a carefully defined **observable projection** of the final state.

### Mapping the theory to CHC bad-state queries

The runnable examples in:

- `Implementation/RICOVER/examples/foo_constant_folding.smt2`
- `Implementation/RICOVER/examples/foo_equiv_notions.smt2`

use the standard CHC verification pattern:

> define a relation `bad` that becomes reachable exactly when the intended equivalence property is violated.

Then:

- `query(bad) = sat` means a counterexample exists
- `query(bad) = unsat` means no counterexample exists

For the three equivalence notions discussed above, the corresponding bad-state encodings are:

#### 1. Full machine-state equality

Theory:

$$
P \simeq_{\text{full}} Q
\iff
\forall \sigma_0,\sigma_1,\sigma_2.\,
(
ret\_exec(P,\sigma_0,\sigma_1)\land
ret\_exec(Q,\sigma_0,\sigma_2)
)
\rightarrow
\sigma_1=\sigma_2
$$

CHC bad state:

$$
bad_{\text{full}} \leftarrow exec_P(\sigma_0,\sigma_1), exec_Q(\sigma_0,\sigma_2), \sigma_1 \neq \sigma_2
$$

In the `foo1` / `foo2` example this query is `sat`, because the final memories differ.

#### 2. ABI-level equivalence

Theory:

$$
P \simeq_{\text{abi}} Q
\iff
\forall \sigma_0,\sigma_1,\sigma_2.\,
(
ret\_exec(P,\sigma_0,\sigma_1)\land
ret\_exec(Q,\sigma_0,\sigma_2)
)
\rightarrow
Obs_{\text{abi}}(\sigma_1)=Obs_{\text{abi}}(\sigma_2)
$$

where `Obs_abi` includes only caller-visible outputs such as:

- return PC
- return registers
- callee-saved registers

CHC bad state:

$$
bad_{\text{abi}} \leftarrow exec_P(\sigma_0,\sigma_1), exec_Q(\sigma_0,\sigma_2), Obs_{\text{abi}}(\sigma_1) \neq Obs_{\text{abi}}(\sigma_2)
$$

In the `foo1` / `foo2` example this query is `unsat`, because the functions agree on the caller-visible boundary state.

#### 3. Projected-memory equivalence

Theory:

$$
P \simeq_{\text{proj}} Q
\iff
\forall \sigma_0,\sigma_1,\sigma_2.\,
(
ret\_exec(P,\sigma_0,\sigma_1)\land
ret\_exec(Q,\sigma_0,\sigma_2)
)
\rightarrow
\Bigl(
Obs_{\text{abi}}(\sigma_1)=Obs_{\text{abi}}(\sigma_2)
\land
\forall a \in ObsMem(\sigma_0).\ mem_1[a]=mem_2[a]
\Bigr)
$$

Here `ObsMem(σ0)` is the set of addresses considered semantically observable.  
In the example file we exclude the callee's private stack frame `[sp_0 - 32, sp_0)`.

CHC bad state:

$$
bad_{\text{proj}} \leftarrow exec_P(\sigma_0,\sigma_1), exec_Q(\sigma_0,\sigma_2), a \in ObsMem(\sigma_0), mem_1[a] \neq mem_2[a]
$$

In the `foo1` / `foo2` example this query is `unsat`, because the memory differences are confined to the private frame that is intentionally projected away.
