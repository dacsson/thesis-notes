#### 1. **Signature** 
**Signature** ($\sum$)  is a set of predicate and function symbols, where:
	- $\sum^F$ - set of funcs
	- $\sum^P$ - set of predicates
	- 0-arity symbols of $\sum^F$ - ***constant* symbols**, denoted by $a, b$ etc.
	- 0-arity symbols of $\sum^P$ - ***propositional* symbols**, denoted by $A, B$ etc.
#### 2.  **Free variable** 
**Free variable -** variables that are not bound by a quantifier. Symbol that specifies places in an expression where *substitution* may take place and is not a parameter of this or any container expression

Two examples of *well formed formulas* are $\forall v2, v2 \in v1$ and $(\not \forall v1(\not \forall v2, v2\in1))$. **But** there is an important difference between the two examples. The *second*
might be translated back into English as:
***There is a set such that every set is a member of it.***
The *first* example, however, can be translated only as an incomplete
sentence, such as
***Every set is a member of \_\.***
We are unable to complete the sentence without knowing what to do
with $v1$ . In cases of this sort, we will say that **$v1$ occurs free** in the wff
$\forall v2(v2\in1)$ . In contrast, no variable occurs free in seconds formula.
#### 3. **Bound variable** 
**Bound variables** - Value of that variable symbol has been bound to a specific value or range of values in the [domain of discourse](https://en.wikipedia.org/wiki/Domain_of_discourse "Domain of discourse") or [universe](https://en.wikipedia.org/wiki/Universe_\(mathematics\) "Universe (mathematics)"). This may be achieved through the use of logical quantifiers, variable-binding operators, or an explicit statement of allowed values for the variable (such as, "...where n  is a positive integer".)
> [!NOTE]
> Consider the statement "a divides b" in first order logic: $\exists x(a=b\times x)$. The variable x is bound while a and b are free. In a sense the bound variable is really just a dummy variable, they are not key to the mathematical statement. The Mathematical statement a divides b is a statement about a and b as opposed to x.
#### 4. Ground formula
**Ground** *(i.e., variable-free)* formula - a formula containing no free-variables 
#### 5. Sentence
If no variable occurs free in the wff $\alpha$ (i.e., if $\overline{h}(\alpha) = \emptyset$), then $\alpha$ is a
sentence. (The sentences are intuitively the wffs translatable into English
without blanks, once we are told how to interpret the parameters.)
#### 6. **Existential positive Least Fixed-point Logic (E+LFP)** 
**E+LFP** - a fragment of second- order logic. It differs from first-
order logic in two respects, the absence of the universal quantifier ($\forall$) and the
presence of the fixed-point operator. 
==TBD: [read this paper](https://web.eecs.umich.edu/~gurevich/Opera/73.pdf)==
#### 7. First-order logic
**First-order logic** is predicate calculus where *quantification* is restricted to individual variables (variables ranging over "objects") and quantification over predicate variables (i.e. variables ranging over "properties") is not allowed.

**The Logical Operators of Propositional (0th-Order Predicate) Logic:**

- Negation: $\neg$
- Conjunction: $\land$
- Inclusive disjunction: $\lor$
- Material implication (/conditional): $\implies$
- Material equivalence (/biconditional): $\iff$

**First-Order Logic (FOL)** includes all the operators of propositional logic, and adds to them the following 3 operators:

- $\exists$: existential quantifier: ∃x: there exist(s) some x (such that)
- $\forall$: universal quantifier: ∀x: all x's (i.e., every x).
- $=$: identity

**Identity (=) helps us symbolize**

1. At least statements: ex., There are at least 2 numbers
2. At most statements: ex., There are at most 2 numbers
3. Exactly statements: ex., There are eactly 2 numbers.
4. Definite descriptions: "The king of France is bald".
#### 8. Second order logic
==TBD: [read this](https://plato.stanford.edu/entries/logic-higher-order/)==

#### 9. Constraint Logic Programming
**CLP** - Typical objective in constraint logic programming is to use logic as a declarative program- ming language. It relies on an execution engine that finds *a set of answers*, that is a set of substitutions that are *solutions to a query*. In an top-down evaluation engine, each such substitution is extracted from a *refutation proof*.

#### 10. Horn Clause Fact 
body -> head
#### 11. Horn Clause Query
> 1 штука на всю систему

body -> false

#### 12. Convex Theory
A formula $F$ is **non-convex** if there exist variables $x_1, y_1,. . . , x_n, y_n$, , such
that $F \implies x1 = y1 \lor ... \lor x_n = y_n$, but for no $i$ between 1 and $y_1$ does $F \implies x_i = y_i$.
Otherwise, $F$ is **convex**. That is, a formula is **non-convex** if it entails a disjunction of
equalities between variables without entailing any of the equalities alone; otherwise
it is **convex**. For instance, the formula $1 \leq x \leq 2 \land y = 1 \land z = 2$ is **non-convex** over the
integers because it entails the disjunction $x = y \land x = z$ without entailing either
equality alone.

#### 13. Universal Horn Clauses
Universal Horn clauses extend Horn clauses by admit- ting universally quantifiers in bodies. Thus, the body of a universal Horn clause is given by: 
$$
body ::= \top | body \land  body | pred | \forall var . body | \exists var . body
$$
*Universal Horn clauses are convex.*

#### 14. Existential Horn Clauses
Existential Horn clauses extend Horn clauses by admit- ting existential quantifications in the head:
$$
head ::= \exists var . head | pred
$$
#### 15. Formal proof or derivation
Given some rules, i.e. 
*To prove an “and” statement, it suffices to prove both sides individually.*
starting with a complex formula $\phi$ and repeatedly applying these derivation rules until no goals remain we get a sequence. This sequence (or really, this tree) of rule applications is a **formal proof**. [from](https://robertylewis.com/files/mathhorizons.pdf)

#### 16. SLD Proof
TBD: [read here](https://cs.uwaterloo.ca/~david/cl/sld-gallier.pdf)

#### 17. Operational semantics
A concrete **operational semantics** is given to a language by mapping language constructs to operations on a virtual machine, a machine whose operation is “obvious.” [from](https://cs.lmu.edu/~ray/notes/opsem/)

#### 18. Regression verification
During software development it is often the case that one
may want to modify the program text and then prove that its semantics has not
been changed - this kind of proofs is sometimes called *regression verification*.

#### 19. Semantic equivalence
It is a specific kind if program equivalence under chosen semantics (operational, denotational, big-step, small-step, etc.)

#### 20. Partial equivalence
Equivalence relation where we don't care about termination proof of programs. 
