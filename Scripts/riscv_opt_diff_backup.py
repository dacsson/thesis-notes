#!/usr/bin/env python3
"""
RISC-V Assembly Optimization Diff Tool

Compiles a C program under different optimization configurations and
generates diffs showing instruction sequence changes.

Usage:
    python riscv_opt_diff.py <c_file> [-o OUTPUT_DIR] [--keep-files]
                                     [--opt-levels LEVELS]

Example:
    python riscv_opt_diff.py myprog.c --opt-levels 0 1 2 3 s z
"""

import argparse
import os
import subprocess
import sys
import re
from pathlib import Path
from typing import List, Dict, Tuple
import difflib


def parse_args():
    parser = argparse.ArgumentParser(
        description="Generate RISC-V assembly diffs for different optimization levels"
    )
    parser.add_argument("c_file", help="Path to the C source file to compile")
    parser.add_argument(
        "-o", "--output-dir",
        default="riscv_analysis_output",
        help="Output directory for generated files (default: riscv_analysis_output)"
    )
    parser.add_argument(
        "--opt-levels",
        default="0,1,2,3,s,z",
        help="Comma-separated optimization levels to compare (default: 0,1,2,3,s,z)"
    )
    parser.add_argument(
        "--arch",
        default="riscv64",
        help="Target architecture (default: riscv64)"
    )
    parser.add_argument(
        "--cc",
        default="clang",
        help="C compiler to use (default: clang)"
    )
    parser.add_argument(
        "--keep-files",
        action="store_true",
        help="Keep intermediate assembly files"
    )
    parser.add_argument(
        "--base-opt",
        default="0",
        help="Base optimization level to compare others against (default: 0)"
    )
    return parser.parse_args()


def verify_toolchain(cc: str, arch: str) -> bool:
    """Check if the specified compiler supports the target architecture."""
    try:
        result = subprocess.run(
            [cc, f"--target={arch}", "-c", "-x", "c", "-o", "/dev/null", "-"],
            input="int main(){return 0;}",
            capture_output=True,
            text=True,
            timeout=10
        )
        return result.returncode == 0
    except (subprocess.TimeoutExpired, FileNotFoundError):
        return False


def compile_to_assembly(
    c_file: str,
    cc: str,
    arch: str,
    output_file: str,
    opt_level: str
) -> bool:
    """
    Compile a C program to RISC-V assembly.
    
    Args:
        c_file: Path to C source file
        cc: Compiler executable
        arch: Target architecture
        output_file: Output assembly file path
        opt_level: Optimization level (0, 1, 2, 3, s, z)
    
    Returns:
        True if compilation succeeded, False otherwise
    """
    try:
        cmd = [
            cc,
            f"--target={arch}",
            f"-O{opt_level}",
            "-S",  # Generate assembly
            "-o", output_file,
            c_file
        ]
        
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=30
        )
        
        if result.returncode != 0:
            print(f"Compilation error for {output_file}:")
            print(result.stderr)
            return False
        
        return True
    except subprocess.TimeoutExpired:
        print(f"Compilation timeout for {output_file}")
        return False
    except Exception as e:
        print(f"Compilation error for {output_file}: {e}")
        return False


def read_assembly_file(filepath: str) -> List[str]:
    """Read an assembly file and return lines as a list."""
    try:
        with open(filepath, 'r') as f:
            return f.readlines()
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        return []


def normalize_instruction(line: str) -> str:
    """
    Normalize an assembly instruction for comparison.
    Removes comments and normalizes whitespace.
    """
    # Remove comments
    if '#' in line:
        line = line[:line.index('#')]
    # Normalize whitespace
    line = ' '.join(line.split())
    return line.strip()


def split_into_functions(lines: List[str]) -> Dict[str, List[str]]:
    """
    Split assembly into functions.
    Returns a dict mapping function names to their instruction lines.
    """
    functions = {}
    current_func = None
    current_lines = []
    
    # Filter out directives and empty lines
    filtered_lines = []
    for line in lines:
        stripped = line.strip()
        if not stripped or stripped.startswith('.'):
            continue
        filtered_lines.append(line)
    
    for line in filtered_lines:
        # Check for function label
        if re.match(r'^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*:', line):
            # Save previous function
            if current_func is not None:
                functions[current_func] = current_lines
            # Start new function
            current_func = line.strip().rstrip(':')
            current_lines = []
        else:
            normalized = normalize_instruction(line)
            if normalized:
                current_lines.append(normalized)
    
    # Save last function
    if current_func is not None:
        functions[current_func] = current_lines
    
    return functions


def find_instruction_blocks(
    seq1: List[str],
    seq2: List[str]
) -> List[Dict[str, any]]:
    """
    Compare two instruction sequences and find differing blocks.
    Returns list of blocks, where each block contains:
    - start_idx: start index in seq1
    - end_idx: end index in seq1
    - seq1_block: instructions from seq1
    - seq2_block: corresponding instructions from seq2
    """
    # Use difflib to find differences
    matcher = difflib.SequenceMatcher(None, seq1, seq2)
    blocks = []
    
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag in ('replace', 'delete', 'insert'):
            block = {
                'type': tag,
                'start_idx': i1,
                'end_idx': i2,
                'seq1_block': seq1[i1:i2] if i2 > i1 else [],
                'seq2_block': seq2[j1:j2] if j2 > j1 else [],
            }
            blocks.append(block)
    
    return blocks


def format_diff_block(
    block: Dict[str, any],
    version_name: str
) -> str:
    """
    Format a diff block with clear delimiters.
    """
    output = []
    
    # Header delimiter
    output.append("#" * 60)
    output.append(f"# DIFF BLOCK ({block['type'].upper()})")
    output.append("#" * 60)
    
    # Base version (before optimization)
    if block['seq1_block']:
        output.append("")
        output.append("# WITH O0:")
        output.append("# {sequence of asm instructions before opt}")
        for line in block['seq1_block']:
            output.append(f"    {line}")
    else:
        output.append("")
        output.append("# WITH O0: {empty}")
    
    # Optimized version
    if block['seq2_block']:
        output.append("")
        output.append(f"# WITH {version_name}:")
        output.append("# {sequence of changed instructions after opt}")
        for line in block['seq2_block']:
            output.append(f"    {line}")
    else:
        output.append("")
        output.append(f"# WITH {version_name}: {{empty}}")
    
    output.append("")
    output.append("#" * 60)
    output.append("")
    
    return "\n".join(output)


def generate_diff(
    asm_file1: str,
    asm_file2: str,
    version_name: str,
    output_file: str,
    base_opt: str = "0"
) -> None:
    """
    Generate diff between two assembly files.
    """
    # Read both files
    lines1 = read_assembly_file(asm_file1)
    lines2 = read_assembly_file(asm_file2)
    
    # Split into functions for better comparison
    funcs1 = split_into_functions(lines1)
    funcs2 = split_into_functions(lines2)
    
    output_lines = []
    output_lines.append(f"# Diff between O{base_opt} and {version_name}")
    output_lines.append(f"# Base assembly: {asm_file1}")
    output_lines.append(f"# Compared assembly: {asm_file2}")
    output_lines.append("")
    
    # Get all unique function names
    all_funcs = set(funcs1.keys()) | set(funcs2.keys())
    
    for func_name in sorted(all_funcs):
        seq1 = funcs1.get(func_name, [])
        seq2 = funcs2.get(func_name, [])
        
        output_lines.append(f"# Function: {func_name}")
        output_lines.append(f"{'=' * 60}")
        
        if not seq1 and not seq2:
            output_lines.append("# (empty function)")
            output_lines.append("")
            continue
        
        # Find differing blocks
        blocks = find_instruction_blocks(seq1, seq2)
        
        if not blocks:
            output_lines.append("# [NO CHANGES]")
            output_lines.append("")
            continue
        
        # Format each differing block
        for block in blocks:
            formatted = format_diff_block(block, version_name)
            output_lines.append(formatted)
    
    # Write output
    with open(output_file, 'w') as f:
        f.write("\n".join(output_lines))
    
    print(f"  Generated diff: {output_file}")


def main():
    args = parse_args()
    
    # Verify C file exists
    c_file_path = Path(args.c_file)
    if not c_file_path.exists():
        print(f"Error: C file '{args.c_file}' not found")
        sys.exit(1)
    
    # Parse optimization levels
    opt_levels = [level.strip().lstrip('O') for level in args.opt_levels.split(',')]
    
    # Create output directory
    output_dir = Path(args.output_dir)
    output_dir.mkdir(exist_ok=True)
    print(f"Output directory: {output_dir}")
    
    # Verify toolchain
    if not verify_toolchain(args.cc, args.arch):
        print(f"Error: Toolchain '{args.cc}' does not support '{args.arch}' target")
        print("Please ensure clang/LLVM is properly installed.")
        sys.exit(1)
    print(f"Toolchain OK: {args.cc} with {args.arch}")
    
    # Compile all versions
    base_asm = None
    asm_files = {}
    
    for opt_level in opt_levels:
        asm_filename = output_dir / f"{c_file_path.stem}_O{opt_level}.s"
        asm_files[opt_level] = str(asm_filename)
        
        print(f"\nCompiling O{opt_level}...")
        success = compile_to_assembly(
            str(c_file_path),
            args.cc,
            args.arch,
            str(asm_filename),
            opt_level
        )
        
        if success:
            print(f"  Success: {asm_filename}")
            if opt_level == args.base_opt:
                base_asm = str(asm_filename)
        else:
            print(f"  Failed: O{opt_level}")
            sys.exit(1)
    
    # Report summary
    print(f"\n{'='*60}")
    print("Compilation Summary:")
    print(f"{'='*60}")
    for opt_level, asm_path in asm_files.items():
        lines = len(read_assembly_file(asm_path))
        print(f"  O{opt_level:2s}: {asm_path} ({lines} lines)")
    
    # Generate diffs
    print(f"\n{'='*60}")
    print(f"Generating Diffs (base: O{args.base_opt}):")
    print(f"{'='*60}")
    
    for opt_level, asm_path in asm_files.items():
        if opt_level == args.base_opt:
            continue
        
        diff_filename = output_dir / f"{c_file_path.stem}_O{args.base_opt}_vs_O{opt_level}.diff"
        print(f"\nComparing O{args.base_opt} -> O{opt_level}...")
        
        generate_diff(
            base_asm,
            asm_path,
            f"O{opt_level}",
            str(diff_filename),
            args.base_opt
        )
    
    # Clean up intermediate files if requested
    if not args.keep_files:
        print(f"\nCleaning up intermediate assembly files...")
        for opt_level, asm_path in asm_files.items():
            if opt_level != args.base_opt:  # Keep base as reference
                os.remove(asm_path)
                print(f"  Removed: {asm_path}")
    
    print(f"\n{'='*60}")
    print("Done!")
    print(f"Output directory: {output_dir}")
    print(f"Base assembly (O{args.base_opt}): {base_asm}")
    print(f"{'='*60}")


if __name__ == "__main__":
    main()
