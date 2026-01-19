- Reference: [[nbjorner-HornClausesForSystemVerification.pdf]]

## Introduction

We make the overall claim that Constrained Horn Clauses provide a suitable ba-
sis for automatic program verification, that is, symbolic model checking

## Program Logics and Horn Clauses

Blass and Gurevich [15] made the case that *Existential positive* *Least Fixed-point Logic* (E+LFP) [[Glossary#6. **Existential positive Least Fixed-point Logic (E+LFP)**]] provides a logical match for Hoare logic: ==Partial correctness of simple procedural imperative programs correspond to satisfiability in E+LFP.==

Еhe negation of an E+LFP formula can be written as set of Horn clauses, such that the negation of an E+LFP formula is false if and only if the corresponding Horn clauses are satisfiable.

![[Pasted image 20251224105644.png]]
> [!NOTE]
> Putting our own spin on this flow we have:
> Program = RISC-V Asm + Specification = RISCV- Sail

## Horn Clause Basics

**Constrained Horn Clauses** correspond to a fragment of first-order formulas modulo background theories. 

We will assume that the *constraints* in constrained Horn Clauses are for-mulated in an **assertion language** that we refer to as $A$. In the terminology of CLP [[Glossary#9. Constraint Logic Programming]], an assertion language is a constraint theory. In the terminology of SMT, an assertion language is a logic. Typically, we let $A$ be quantifier-free (integer) linear arithmetic. Other examples of A include quantifier-free bit-vector formulas and quantifier- free formulas over a combination of arrays, bit-vectors and linear arithmetic.

Schematic examples of constrained Horn clauses are:
$$
\forall x,y,z . q(y) \land r(z) \land \phi(x,y,z) \rightarrow p(x,y)
$$
and
$$
\forall x,y,z . q(y) \land r(z) \land \phi(x,y,z) \rightarrow \omega(x,y)
$$
Where $p,q,r$ are predicate symbols of various arities applied to variables $x,y,z$ and $\phi, \omega$ are formulas over and assertion language $A$. 

Grammar:
![[Pasted image 20251224110904.png]]

*Example 1*. Partial correctness for McCarthy 91
$$
mc(x, r) \leftarrow x \gt 100, r=x - 10
$$
$$
mc(x, r) \leftarrow x \leq 100, y=x+11,mc(y,z),mc(z,r)
$$
$$
r=91 \leftarrow mc(x,r),x \leq 101
$$
The first two clauses encode McCarthy 91 as a constraint logic program. The last clause encodes the *integrity constraint* stipulating that whenever the McCarthy 91 function is passed an argument no greater than 101, then the result is 91. 

> [!QUESTION]
> In the above formula - $mc$ is an unintrepreted predicate, then what is $r=91$? Is it a formula over and assertion language (linear arithmetic)?

Some formulas that are not directly Horn can be transformed into Horn clauses using a satisfiability preserving **Tseitin transformation**:
$$
p(x) \leftarrow (q(y) \lor r(z)), \phi(x,y,z)
$$
into
$$
s(y,z) \leftarrow q(y)
$$
$$
s(y,z) \leftarrow r(z)
$$
$$
p(x) \leftarrow s(y,z),\phi(x,y,z)
$$
by introducing uninterpreted predicate $s(y,z)$

> [!QUESTION]
> Where did the $\lor$ go?

**NNF Form of CHC**:
![[Pasted image 20251224113117.png]]
**Proposition 1.** *NNF Horn clauses with n sub-formulas and m variables can be converted into O(n) new Horn clauses each using O(m) variables.*

**Proposition 2.** *Suppose $A$ has a canonical model $I(A)$, then Horn clauses over $A$, where each head is an uninterpreted predicate, are convex [[Glossary#12. Convex Theory]].*

**Proposition 3.** *Constrained Horn clauses over assertion languages $A$ that have canonical models have unique least models.*

## E+FLP in CHC

TBD

## Derivations and interpretations
==Horn clauses naturally encode the set of reachable states of sequential programs, so satisfiable Horn clauses are program properties that hold. In contrast, unsat- isfiable Horn clauses correspond to violated program properties.==

The finite trace is justified by a sequence of resolution steps, and in par- ticular for Horn clauses, it is sufficient to search for SLD [[Glossary#16. SLD Proof]] style proofs.

> [!TODO]
ADD DEFINITIONS p.9-10

## From Programs to Clauses

The conceptually simplest way to establish a link between checking a *partial correctness* property in a programming language and a formulation as Horn clauses is to formulate an *operational semantics* [[Glossary#17. Operational semantics]] as an interpreter in a constraint logic program and then specialize the interpreter when given a program. 

Methods surveyed here bypass the interpreter and produce Horn clauses directly.

### State machine
A state machine starts with an initial configuration of state variables $v$ and transform these by a sequence of steps. When the initial states and steps are expressed as formulas $init(v)$ and $step(v, v′)$, respectively, then we can check safety of a state machine relatively to a formula $safe(v)$ by finding an inductive invariant $inv(v)$ such that:
$$
inv(u) \leftarrow init(v)
\qquad
inv(v') \leftarrow inv(v) \land step(v,v')
\qquad 
safe(v) \leftarrow inv(v) 
$$
### Procedural languages
