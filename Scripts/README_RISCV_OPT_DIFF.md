# RISC-V Assembly Optimization Diff Tool

A Python script that compiles a C program under different optimization configurations (O0, O1, O2, O3, Os, Oz) and generates diffs showing how instruction sequences change.

## Features

- **Multiple optimization comparisons**: Compares O0 (no optimization) against O1, O2, O3, Os (size), Oz (aggressive size)
- **Clear diff formatting**: Shows changed instruction blocks with clear delimiters:
  ```
  # WITH O0: {sequence of asm instructions before opt}
  # WITH O3: {sequence of changed instructions after opt}
  ```
- **Traditional diff output**: Includes side-by-side diff (`diff -y`) section for detailed analysis
- **Ricover format files**: Optional generation of assembly files with src/tgt function wrappers for easy comparison
- **Output organization**: Creates a directory with:
  - Assembly files for each optimization level
  - Diff files comparing O0 to each optimized version
  - Ricover directory (if requested) with src/tgt formatted assembly
  - Summary of compilation results
- **Per-function analysis**: Diffs are organized by function for easy navigation

## Requirements

- **Python 3.x**: Required for running the script
- **LLVM/Clang**: Required for RISC-V compilation
  ```bash
  # Install on Ubuntu/Debian:
  sudo apt-get install clang llvm
  
  # On macOS (with Homebrew):
  brew install llvm
  
  # Verify installation:
  clang --version
  ```

## Usage

### Basic Usage

```bash
python3 riscv_opt_diff.py <c_file> [--opt-levels LEVELS] [OPTIONS]
```

### Examples

1. **Compare O0 and O3 only (default):**
   ```bash
   python3 riscv_opt_diff.py myprog.c
   ```

2. **Compare all optimization levels:**
   ```bash
   python3 riscv_opt_diff.py myprog.c --opt-levels 0,1,2,3,s,z
   ```

3. **Compare specific optimization levels:**
   ```bash
   python3 riscv_opt_diff.py myprog.c --opt-levels 0,1,3,z
   ```

4. **With custom output directory:**
   ```bash
   python3 riscv_opt_diff.py -o my_analysis_dir myprog.c
   ```

5. **Keep assembly files for inspection:**
   ```bash
   python3 riscv_opt_diff.py --keep-files myprog.c
   ```

6. **Using the example program:**
   ```bash
   python3 riscv_opt_diff.py simple_example.c --opt-levels 0,1,2,3
   ```

7. **Use different base optimization for comparison:**
   ```bash
   python3 riscv_opt_diff.py myprog.c --base-opt 1 --opt-levels 1,2,3
   ```

8. **Generate ricover format files:**
   ```bash
   python3 riscv_opt_diff.py simple_example.c --ricover
   ```

9. **Generate ricover files with custom directory:**
   ```bash
   python3 riscv_opt_diff.py simple_example.c --ricover --ricover-dir my_ricover_analysis
   ```

10. **Everything combined - full analysis:**
    ```bash
    python3 riscv_opt_diff.py simple_example.c \
      --opt-levels 0,1,3 \
      --keep-files \
      --ricover \
      --ricover-format label_syntax
    ```

## Command-Line Options

| Option | Description | Default |
|--------|-------------|---------|
| `c_file` | C source file to compile (required) | - |
| `-o, --output-dir` | Output directory for generated files | `riscv_analysis_output` |
| `--opt-levels` | Comma-separated opt levels to compare | `0,1,2,3,s,z` |
| `--base-opt` | Base optimization level to compare against | `0` |
| `--arch` | Target architecture | `riscv64` |
| `--cc` | C compiler to use | `clang` |
| `--keep-files` | Keep intermediate assembly files | False |
| `--ricover` | Generate ricover format files with src/tgt wrappers | False |
| `--ricover-dir` | Custom ricover output directory | `{filename}_ricover` |
| `--ricover-format` | Format for ricover functions (`label_syntax`, `simple_prefix`, `assembleable`) | `label_syntax` |

## Optimization Levels Explained

| Level | Description |
|-------|-------------|
| `O0` | No optimization - keeps code straightforward |
| `O1` | Basic optimization with minimal compile time |
| `O2` | Balanced optimization (common default) |
| `O3` | Aggressive optimization for performance |
| `Os` | Optimize for code size |
| `Oz` | Aggressive code size optimization |

## Output Structure

The script creates directories with the following structure:

```
riscv_analysis_output/
├── myprog_O0.s                 # O0 assembly (reference)
├── myprog_O1.s                 # O1 assembly
├── myprog_O2.s                 # O2 assembly
├── myprog_O3.s                 # O3 assembly
├── myprog_Os.s                 # Os assembly
├── myprog_Oz.s                 # Oz assembly
├── myprog_O0_vs_O1.diff        # Diff: O0 → O1 (includes traditional diff)
├── myprog_O0_vs_O2.diff        # Diff: O0 → O2 (includes traditional diff)
├── myprog_O0_vs_O3.diff        # Diff: O0 → O3 (includes traditional diff)
├── myprog_O0_vs_Os.diff        # Diff: O0 → Os (includes traditional diff)
└── myprog_O0_vs_Oz.diff        # Diff: O0 → Oz (includes traditional diff)

myprog_ricover/                # Only if --ricover is used
├── fibonacci_O0_vs_O3.ricover
├── recursive_factorial_O0_vs_O3.ricover
├── main_O0_vs_O3.ricover
└── ...
```

### Diff File Structure
Each `.diff` file contains:
1. Header with metadata
2. Per-function instruction block diffs
3. Traditional side-by-side diff (diff -y) section

### Ricover Directory Structure
When `--ricover` is enabled:
- One `.ricover` file per changed function block
- Named as `{function}_O{base}_vs_{comparison}.ricover`
- Contains formatted `src:` and `tgt:` functions

If `--keep-files` is not used, only the base optimization assembly is kept for reference.

## Understanding the Diff Output

Each diff file contains two main sections:

### 1. Instruction Block Diff
Organized by function and shows changed instruction blocks:

```
# Diff between O0 and O3
# Base assembly: myprog_O0.s
# Compared assembly: myprog_O3.s

# Function: fibonacci
============================================================
############################################################
# DIFF BLOCK (REPLACE)
############################################################

# WITH O0: 
# {sequence of asm instructions before opt}
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    addi s0, sp, 48
    sw a0, -24(s0)
    lw a1, -24(s0)
    blt a0, a1, .LBB3_2
    ...

# WITH O3:
# {sequence of changed instructions after opt}
    li a1, 2
    blt a0, a1, .LBB3_3
    li a2, 0
    addi a1, a0, -1
    mv a3, a0
    ...
```

### Diff Block Types

- **REPLACE**: Instructions changed between versions
- **DELETE**: Instructions removed in optimized version
- **INSERT**: New instructions added in optimized version
- **[NO CHANGES]**: Function is identical in both versions

### 2. Traditional Side-by-Side Diff
Added to each diff file, this section shows a traditional `diff -y` comparison:
```
============================================================
# Traditional Side-by-Side Diff
#===========================================================
# diff -y myprog_O0.s myprog_O3.s
#===========================================================

addi sp, sp, -48                      |    li a1, 2
sd ra, 40(sp)                         |    blt a0, a1, .LBB3_3
...
```

The traditional diff shows:\- `<` : Lines only in the left (O0) file
- `>` : Lines only in the right (optimized) file
- `|` : Changed lines
- No symbol: Identical lines

## Ricover Format Files

When using the `--ricover` flag, the script generates additional files with formatted assembly that's easy to compare and potentially assemble.

### Ricover Directory Structure
```
{filename}_ricover/
├── fibonacci_O0_vs_O3.ricover          # fibonacci function changes
├── recursive_factorial_O0_vs_O3.ricover
├── main_O0_vs_O3.ricover
└── ...
```

### Ricover File Format
Each ricover file contains:

```assembly
# ==================================================
# Ricover Format File
# ==================================================
# Source file: simple_example.c
# Function: simple_swapping
# Comparison: O0 vs O3
# Instructions in src (O0): 19
# Instructions in tgt (O3): 4
# ==================================================

# Function: src (O0 version)
.globl src
src:
    addi sp, sp, -48
    sd ra, 40(sp)
    ...


# Function: tgt (O3 version)
.globl tgt
tgt:
    lw a2, 0(a1)
    lw a3, 0(a0)
    ...
```

### Ricover Features
- **Metadata**: Includes source file path, function name, and comparison info
- **Instruction counts**: Shows number of instructions in each version
- **Assembleable**: Functions can be assembled and called/tested independently
- **Clean format**: Only contains changed instruction blocks, not entire functions
- **Consistent naming**: Uses `src` for base (O0) and `tgt` for optimized version

### Ricover File Naming
Files are named as: `{function_name}_O{base}_vs_{comparison}.ricover`

If a function has multiple changed blocks, they're numbered:
- `fibonacci_O0_vs_O3.ricover`
- `fibonacci_block1_O0_vs_O3.ricover`
- `fibonacci_block2_O0_vs_O3.ricover`

### Ricover Format Options

#### label_syntax (default)
```assembly
.globl src
src:
    addi sp, sp, -16
    ...

.globl tgt
tgt:
    lw a0, 0(a0)
    ...
```

#### simple_prefix
```assembly
# src:
    addi sp, sp, -16
    ...

# tgt:
    lw a0, 0(a0)
    ...
```

#### assembleable
Full assembly wrappers suitable for calling/linking.

### Use Cases for Ricover Files

1. **Performance testing**: Compile and benchmark individual code blocks
2. **Analysis**: Study specific instruction sequences in isolation
3. **Education**: Compare optimization effects on specific code segments
4. **Debugging**: Isolate issues with specific optimized blocks
5. **Research**: Collect datasets of optimized vs unoptimized code

## Example Workflow

1. **Compile and analyze a program:**
   ```bash
   python3 riscv_opt_diff.py simple_example.c --opt-levels 0,1,3
   ```

2. **Check compilation summary:**
   ```
   Compilation Summary:
   ============================================================
     O0 : riscv_analysis_output/simple_example_O0.s (207 lines)
     O1 : riscv_analysis_output/simple_example_O1.s (132 lines)
     O3 : riscv_analysis_output/simple_example_O3.s (97 lines)
   ```

3. **View the diff output:**
   ```bash
   cat riscv_analysis_output/simple_example_O0_vs_O3.diff
   ```

4. **Analyze specific functions:**
   ```
   # Function: recursive_factorial
   ============================================================
   [shows instruction changes for this specific function]
   ```

5. **View traditional diff section (at end of each diff file):**
   ```bash
   # Show traditional diff for O0 vs O3 comparison
   tail -100 riscv_analysis_output/simple_example_O0_vs_O3.diff
   ```

6. **Examine ricover files:**
   ```bash
   # List all ricover files
   ls simple_example_ricover/
   
   # View a specific ricover file
   cat simple_example_ricover/simple_swapping_O0_vs_O3.ricover
   
   # See optimization impact (instruction count)
   head -15 simple_example_ricover/main_O0_vs_O3.ricover
   ```

7. **Work with ricover format files:**
   ```bash
   # Ricover files can be assembled
   riscv64-unknown-elf-as -o src.o simple_example_ricover/main_O0_vs_O3.ricover
   
   # Or examine specific optimized blocks
   cat simple_example_ricover/fibonacci_block1_O0_vs_O3.ricover
   ```

## Tips

- **Start with O0 vs O3** to see the full span of optimizations
- **Compare adjacent levels** (O0→O1, O1→O2) to see incremental changes
- **Use --keep-files** to examine assembly directly
- **Size-optimized versions** (Os, Oz) are interesting for embedded systems
- **Use --ricover** to get isolated code blocks for testing/analysis
- **Traditional diff** section is perfect for detailed line-by-line comparison
- **Ricover files** show instruction counts - good for optimization effectiveness metrics
- Use simple C programs without standard library dependencies for clean analysis

## Example Programs

### simple_example.c
A self-contained C program with:
- Recursive factorial
- Iterative array summation
- Pointer swapping
- Fibonacci sequence
- Multiple function patterns

This program has no standard library dependencies and is suitable for cross-compilation testing.

### example_program.c (for reference)
Shows common C programming patterns, but requires standard library (`stdio.h`). Use with:
```bash
clang --target=riscv64 --sysroot=/path/to/sysroot -S example_program.c
```

## Troubleshooting

### "Toolchain does not support target architecture"
Ensure LLVM/Clang is properly installed:
```bash
clang --version
```

### "C file not found"
Check the file path is correct and the file exists.

### Compilation fails (stdio.h not found)
For cross-compilation, use programs without standard library headers, or ensure proper sysroot is configured.

### No changes in some diff functions
If functions show `[NO CHANGES]`, it means that optimization didn't affect those particular functions - they were already optimal or don't benefit from that level of optimization.

### Python not found
Use `python3` instead of `python`:
```bash
python3 riscv_opt_diff.py myprog.c
```

## Advanced Usage

### Different Base Optimization
Compare different levels against O1 instead of O0:
```bash
python3 riscv_opt_diff.py --base-opt 1 --opt-levels 1,2,3 myprog.c
```

### Keep All Assembly Files
Useful for manual inspection:
```bash
python3 riscv_opt_diff.py --keep-files myprog.c
ls riscv_analysis_output/*.s
cat riscv_analysis_output/myprog_O3.s
```

### Cross-Architecture Analysis
Compare different architectures (if toolchain supports):
```bash
python3 riscv_opt_diff.py --arch riscv32 myprog.c
python3 riscv_opt_diff.py --arch x86_64 myprog.c
```

## What Can You Learn?

Using this tool, you can analyze:

1. **Register allocation**: How compilers use registers differently
2. **Loop optimizations**: Unrolling, rotation, elimination
3. **Tail recursion**: Transformation of recursive calls
4. **Code motion**: Loop-invariant code movement
5. **Instruction selection**: Better instruction choices
6. **Dead code elimination**: Removal of unused operations
7. **Value propagation**: Constant folding and propagation
8. **Inlining**: Function call expansion at different optimization levels

## License

This script is provided as-is for educational and research purposes.
