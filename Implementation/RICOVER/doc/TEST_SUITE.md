## Sources

1. Alive2
2. [RVISmith](https://arxiv.org/abs/2507.03773?utm_source=chatgpt.com)
  - [Buglist](https://github.com/yibo2000/RVISmith#reported-bugs)
3. [RISCV specific instcombine tests](https://github.com/llvm/llvm-project/tree/main/llvm/test/Transforms/InstCombine/RISCV)
4. Self-written

## Currently supported

### Alive2
- 2 negative bug from Alive2 
  - [1](../benchmark/supported/bench1_BAD.s)
  - [2](../benchmark/supported/PR44306.s)

### Self-written
- [initial constant folding example](../benchmark/supported/constant_folding_simple.s)
