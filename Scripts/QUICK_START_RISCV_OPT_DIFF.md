# Quick Start Guide

## What You Get

A Python script that:
1. ✅ Compiles C programs with optimization levels O0, O1, O2, O3, Os, Oz
2. ✅ Generates RISC-V assembly for each optimization level
3. ✅ Creates diffs comparing O0 to all other optimization levels
4. ✅ Shows changed instruction sequences with clear delimiters:
   - `# WITH O0: {sequence of asm instructions before opt}`
   - `# WITH O3: {sequence of changed instructions after opt}`
5. ✅ Includes traditional side-by-side diff (`diff -y`) in each diff file
6. ✅ Optional ricover format (with `--ricover`) with src/tgt assembly functions

## Files Created

```
riscv_opt_diff.py      # Main Python script
simple_example.c        # Example C program (no stdlib deps)
example_program.c       # Example with stdlib (for reference)
README.md               # Full documentation
test_script.sh          # Test script
QUICK_START.md          # This file
```

## Try It Now

```bash
# Basic example (O0 vs O3 only)
python3 riscv_opt_diff.py simple_example.c

# Compare multiple optimization levels
python3 riscv_opt_diff.py simple_example.c --opt-levels 0,1,3

# Keep assembly files for inspection
python3 riscv_opt_diff.py simple_example.c --keep-files

# Generate ricover format files (new!)
python3 riscv_opt_diff.py simple_example.c --ricover

# Full analysis with optimization diff + ricover
python3 riscv_opt_diff.py simple_example.c --opt-levels 0,1,3 --keep-files --ricover

# Check output
ls riscv_analysis_output/
ls simple_example_ricover/  # if --ricover was used
cat riscv_analysis_output/simple_example_O0_vs_O3.diff
```

## Example Output

```
# Function: recursive_factorial
============================================================
############################################################
# DIFF BLOCK (REPLACE)
############################################################

# WITH O0:
# {sequence of asm instructions before opt}
    addi sp, sp, -32
    sd ra, 24(sp)
    sd s0, 16(sp)
    addi s0, sp, 32
    sw a0, -24(s0)
    lw a1, -24(s0)

# WITH O3:
# {sequence of changed instructions after opt}
    li a2, 2
    bge a0, a2, .LBB0_2
```

## Key Features

- **Per-function analysis**: Diffs organized by function name
- **Multiple optimizations**: Compare O0, O1, O2, O3, Os, Oz
- **Automatic toolchain verification**: Checks clang supports RISC-V
- **Clean output**: Organized directory structure
- **Customizable**: Choose specific optimization levels to compare

## System Requirements

- Python 3.x
- clang with RISC-V support (check with `clang --version`)

## What This Helps You Analyze

- Register allocation strategies
- Loop optimizations (unrolling, rotation)
- Tail recursion elimination
- Instruction selection
- Dead code elimination
- Size vs performance trade-offs (Os/Oz versions)

## Next Steps

- See `README.md` for detailed documentation
- Customize `simple_example.c` with your own code
- Experiment with different optimization level combinations
- Use `--ricover` to get isolated code blocks
- Check the traditional diff section for detailed line-by-line comparison
- Analyze how optimizations affect specific functions
