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
