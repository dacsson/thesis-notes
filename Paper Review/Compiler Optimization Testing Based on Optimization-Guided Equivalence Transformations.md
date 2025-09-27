[[COTBOGET.pdf]]
## Why is this interesing?

Making optimization a testable property. More about testing then verification? Based on semantically equivalent transformation before using the compiler.
# Paper
## Abstract 

- differential testing mechanism 
	- ==the same input is given to two or more similar systems or versions of a system==. The outputs are then compared, and any differences in behavior are flagged as potential bugs or inconsistencies
	- a technique where the same program is compiled using **different compilers** (e.g., GCC, Clang, MSVC), and their outputs are compared.

### What's the problem?

Because of differential testing, where we need to compare outputs of different compilers based on same input, we must rely on the proposition that the same functionallity implemented across e.g. **GCC** and **LLVM** *and* shared bugs remain undetected. 

(1) **"\[differential testing\]...which requires comparing outputs across multiple compilers."**  
- If two or more compilers produce different results when compiling the same source code, that difference is flagged as a potential bug — assuming the behavior should be the same.
(2) If multiple compilers have the same incorrect behavior (e.g., all miscompile a certain loop), then their outputs will be identical.  Since differential testing looks for _differences_, it will **not flag this as a problem** — even though the code is wrong.
## 1. Introduction 

Take a look at:
- YARPGen
- MopFuzzer

They suggest, instead of diff testing -> **meta-morphic** testing mechanism.

Their pipeline:
1. we first develop code construction strategies to generate input programs that meet opti- mization requirements
2. We then apply various compiler optimization transformations (e.g. loop optimization, data-flow optimization) to the generated programs in the previous step, creating semantically equivalent test programs
3. By comparing the outputs of pre- and post-transformation programs, our approach systematically identifies incorrect optimization bugs. 

![[Pasted image 20250927154940.png]]
# Do i get it?

As I understand it the main shtick of their approach is:
- they take a bunch of programs 
- take code segments from this programs that can be a good target for certain optimization 
	-  *"Based on predefined loop optimization configurations, we construct test programs that satisfy the conditions for loop optimizations, referred to as **original programs**. "*
- then they apply optimization (equivalence transformations) to **original programs** and get **transformed programs**
- run them both and if the output differs -> **bug**!

It is different from differential testing mainly because of semantically equivalent transformation of input program into optimized one, while still comparing results of execution, we compare the results of semantically equivalent programs.

==Important:  essentially turning optimization correctness into a testable property:==