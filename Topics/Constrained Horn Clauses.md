References:
- [Grigory Fedyukovich | youtube talk](https://www.youtube.com/watch?v=kbtnye_q3PA)
- [IC3](https://eceweb.uwaterloo.ca/~agurfink/ece750t29/)
	- [Specification Synthesis with Constrained Horn Clauses | Fedyukovich paper](https://kumarmadhukar.github.io/papers/pldi2021-specSynth.pdf)

# Theory
## CHC

Formula in first order logic:
$$
\phi \land p_1(V) \space \land \space ... \space \land \space p_k(V) \implies H
$$
Where:
- $A$ is a constraint language, i.e. our theory (arrays, bit-vectors, etc.)
- $\phi$ is a **constraint** in $A$
- $p_1...p_k$ are **uninterpreted relation symbols**
- each $p_i(V)$ is an **application of the predicate to variables** 
- $H$ is either some application $p_i(V)$ or $false$

**System of CHC**:
- Only one CHC with $H = false$
- *Has a solution* if there exists an interpretation for each $p_i$ making CHC valid

## References to look at

![[Pasted image 20251016162319.png]]

## Example

This c program:
```c
int j, M, N = nondetInt()
int *A = nondetArray()
int i = 0

while (i < N) {
	if (m < A[i]) m = A[i];
	i++;
}

// This is what we want to prove
assume(0 <= j < N) // that if we pick random j from this range
assert(m >= A[j]) // than this holds
```

Can be written in CHC *(logic representation of all possible behaviors of this programs)*  as:

1. Assignment block:

$$
i = 0 
$$

2. Loop:

$$
i \lt N \space \land \space  m' = ite(m \lt A[i], A[i], m) \space \land \space i' = i + 1 
$$

3. Verification condition

$$
i \geq N \space \land \space 0 \leq j \lt N \space \land \space \neg (m \geq A[j])
$$

> Note: we negate the assertion because we actually want to find if the the opposite can happen (prove by contradiction)

We need to bind this formulas (above), to do that we can introduce **uninterpreted predicate.**

$$
i = 0 \implies inv(A,i,m,N)
$$

$$
inv(A,i,m,N) \land \space i \lt N \land \space m' = ite(m \lt A[i],A[i],m) \land \space i'= i+1 \implies inv(A, i', m', N)
$$

$$
inv(A,i,m,N) \land \space i \geq N \land \space 0 \leq j \lt N \land \space \neg (m \geq A[j]) \implies \bot
$$


Then the solution is:

$$
inv \mapsto \forall j .0 \space \leq j \lt i \implies m \geq A[j]
$$

> [!Note]
> Intuitivly, for example, `i = 0 => inv(A,i,m,N)` means that if we begin in a state where `i=0`, then we go to the step where we can get into the loop. So `<if_in_state_where_this_true> => <go_to_the_step_with_this_prop>`

## CHC Solution

CHC's solution is an **inductive invariant** - a formula such that:
- Describes all initial states
- Closed under **transition relation**: if it describes a state from where a transition starts, then it describes a state where transition ends
- Describes no bad states

We can proof that we found a right invariant by **substituting** a formula that invariant maps to (what we think and invariant is) and get just a fully interpret-able SMT formula.

> [!Note]
> Whats important is that introduction of uninterpreted predicates, such as `inv` gives us a really good evaluation of loops. Instead of unrolling them (like in symbolic execution engines) when encoding in SMT directly, we can use the power of CHC solvers to take care of loops.


