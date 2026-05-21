#!/bin/bash

# Script to generate at least 20 small random C programs using ./randprog
# Programs are saved only if they are under a specified size (in lines of code)

# Configuration
MAX_PROGRAMS=20            # Number of small programs we want to generate
MAX_SIZE=100               # Maximum allowed lines of code (considered "small")
OUTPUT_DIR="small_programs" # Directory to save the small programs

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Initialize counters
counter=0          # Number of small programs generated successfully
generated=0        # Total programs generated (including those too big)
deleted=0          # Number of programs deleted for being too big

echo "Generating $MAX_PROGRAMS small random C programs (max $MAX_SIZE lines each)..."
echo "=============================================================================="

# Keep generating until we have enough small programs
while [ $counter -lt $MAX_PROGRAMS ]; do
    ((generated++))
    
    # Generate filename with leading zeros (01, 02, etc.)
    filename=$(printf "%s/program_%02d.c" "$OUTPUT_DIR" "$((counter + 1))")
    
    echo "Attempt #$generated: Generating program #((counter + 1))..."
    
    # Generate program and save to temp file first
    temp_file="temp_program_$generated.c"
    ./randprog > "$temp_file"
    
    # Count lines in the generated program
    line_count=$(wc -l < "$temp_file")
    
    # Check if program is small enough
    if [ "$line_count" -le "$MAX_SIZE" ]; then
        # Program is small enough - keep it
        mv "$temp_file" "$filename"
        ((counter++))
        echo "  ✓ Saved: $filename ($line_count lines)"
        echo "  Progress: $counter/$MAX_PROGRAMS small programs found"
    else
        # Program is too big - delete it
        rm "$temp_file"
        ((deleted++))
        echo "  ✗ Deleted: Too big ($line_count lines, max allowed: $MAX_SIZE)"
    fi
    
    echo ""
done

echo "=============================================================================="
echo "Generation complete!"
echo "Total programs generated: $generated"
echo "Small programs saved: $counter"
echo "Large programs deleted: $deleted"
echo "Small programs saved in: $OUTPUT_DIR/"
echo ""
echo "Listing saved programs:"
ls -lh "$OUTPUT_DIR"/*.c | awk '{print $9, "-", $5}'