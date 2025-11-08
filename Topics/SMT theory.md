Reference:
- Handbook of Satisfiability

## Glossary and terms

1. **Signature** ($\sum$)  is a set of predicate and function symbols, where:
	- $\sum^F$ - set of funcs
	- $\sum^P$ - set of predicates
	- 0-arity symbols of $\sum^F$ - ***constant* symbols**, denoted by $a, b$ etc.
	- 0-arity symbols of $\sum^P$ - ***propositional* symbols**, denoted by $A, B$ etc.
2.   **Free variable** - variables that are not bound by a quantifier. Symbol that specifies places in an expression where *substitution* may take place and is not a parameter of this or any container expression
3.  **Bound variable** - Value of that variable symbol has been bound to a specific value or range of values in the [domain of discourse](https://en.wikipedia.org/wiki/Domain_of_discourse "Domain of discourse") or [universe](https://en.wikipedia.org/wiki/Universe_\(mathematics\) "Universe (mathematics)"). This may be achieved through the use of logical quantifiers, variable-binding operators, or an explicit statement of allowed values for the variable (such as, "...where n  is a positive integer".)
> [!NOTE]
> Consider the statement "a divides b" in first order logic: ∃x(a=b×x). The variable x is bound while a and b are free. In a sense the bound variable is really just a dummy variable, they are not key to the mathematical statement. The Mathematical statement a divides b is a statement about a and b as opposed to x.
4.  **Ground** *(i.**e**., variable-free)* formula - a formula containing no free-variables 
5. 