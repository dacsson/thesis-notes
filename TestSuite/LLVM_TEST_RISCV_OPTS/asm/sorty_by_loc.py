#!/usr/bin/env python3
"""
Script to traverse a directory, collect all .s files, and sort them by line count.
"""

import os
import sys
import argparse
from pathlib import Path

def has_no_fail(file_path):
    """Return True if file does NOT contain 'FAIL', False otherwise."""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            return 'FAILED' not in f.read()
    except:
        return False

def count_lines(file_path):
    """
    Count the number of lines in a file.
    
    Args:
        file_path (str): Path to the file
        
    Returns:
        int: Number of lines in the file
    """
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            return sum(1 for _ in f)
    except Exception as e:
        print(f"Warning: Could not read {file_path}: {e}", file=sys.stderr)
        return 0

def find_s_files(directory):
    """
    Recursively find all .s files in the given directory.
    
    Args:
        directory (str): Root directory to search
        
    Returns:
        list: List of tuples (file_path, line_count)
    """
    s_files = []
    
    # Use pathlib for elegant path handling
    root_path = Path(directory)
    
    if not root_path.exists():
        print(f"Error: Directory '{directory}' does not exist.", file=sys.stderr)
        return []
    
    if not root_path.is_dir():
        print(f"Error: '{directory}' is not a directory.", file=sys.stderr)
        return []
    
    # Recursively traverse the directory
    for file_path in root_path.rglob('*.s'):
        if file_path.is_file():
            line_count = count_lines(file_path)
            if has_no_fail(file_path):
                s_files.append((str(file_path), line_count))
    
    return s_files

def print_results(s_files, show_lines=True, limit=None):
    """
    Print the sorted results.
    
    Args:
        s_files (list): List of tuples (file_path, line_count)
        show_lines (bool): Whether to show line counts
        limit (int): Limit the number of results shown
    """
    if not s_files:
        print("No .s files found.")
        return
    
    # Sort by line count (most to least)
    sorted_files = sorted(s_files, key=lambda x: x[1], reverse=True)
    
    # Apply limit if specified
    if limit and limit > 0:
        sorted_files = sorted_files[:limit]
    
    # Print results
    print(f"\nFound {len(s_files)} .s file(s)\n")
    print("-" * 80)
    
    if show_lines:
        print(f"{'Line Count':<12} {'File Path'}")
        print("-" * 80)
        for file_path, line_count in sorted_files:
            print(f"{line_count:<12} {file_path}")
    else:
        for file_path, _ in sorted_files:
            print(file_path)
    
    print("-" * 80)
    
    # Print summary
    if show_lines and sorted_files:
        total_lines = sum(count for _, count in s_files)
        print(f"\nSummary:")
        print(f"  Total files: {len(s_files)}")
        print(f"  Total lines: {total_lines}")
        print(f"  Average lines: {total_lines // len(s_files) if s_files else 0}")
        print(f"  Largest file: {sorted_files[0][1]} lines ({sorted_files[0][0]})")
        print(f"  Smallest file: {sorted_files[-1][1]} lines ({sorted_files[-1][0]})")

def main():
    parser = argparse.ArgumentParser(
        description='Traverse a directory, collect all .s files, and sort them by line count.'
    )
    parser.add_argument(
        'directory',
        nargs='?',
        default='.',
        help='Directory to traverse (default: current directory)'
    )
    parser.add_argument(
        '-l', '--limit',
        type=int,
        help='Limit the number of results shown'
    )
    parser.add_argument(
        '--no-lines',
        action='store_true',
        help='Do not show line counts (just file paths)'
    )
    parser.add_argument(
        '-o', '--output',
        help='Write results to a file instead of stdout'
    )
    
    args = parser.parse_args()
    
    # Find all .s files
    s_files = find_s_files(args.directory)
    
    # Sort and prepare output
    sorted_files = sorted(s_files, key=lambda x: x[1], reverse=True)
    
    if args.limit:
        sorted_files = sorted_files[:args.limit]
    
    # Redirect output if specified
    original_stdout = sys.stdout
    if args.output:
        try:
            sys.stdout = open(args.output, 'w', encoding='utf-8')
        except Exception as e:
            print(f"Error: Could not write to '{args.output}': {e}", file=sys.stderr)
            sys.exit(1)
    
    try:
        # Print results
        if not args.no_lines:
            print_results(s_files, show_lines=True, limit=args.limit)
        else:
            for file_path, _ in sorted_files:
                print(file_path)
    finally:
        if args.output:
            sys.stdout.close()
            sys.stdout = original_stdout
            print(f"Results written to '{args.output}'")

if __name__ == "__main__":
    main()
