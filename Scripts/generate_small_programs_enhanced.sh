#!/bin/bash

# Enhanced script to generate small random C programs using ./randprog
# Programs are saved only if they are under a specified size (in lines of code)

# Configuration - Edit these values as needed
MAX_PROGRAMS=${MAX_PROGRAMS:-20}            # Number of small programs to generate (default: 20)
MAX_SIZE=${MAX_SIZE:-100}                  # Maximum allowed lines (default: 100)
OUTPUT_DIR=${OUTPUT_DIR:-"small_programs"}  # Output directory (default: small_programs)
TEMP_DIR=${TEMP_DIR:-"temp_generated"}      # Temporary directory for generated programs

# Colors for output (optional)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Create output and temp directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$TEMP_DIR"

# Initialize counters
counter=0          # Number of small programs generated successfully
generated=0        # Total programs generated (including those too big)
deleted=0          # Number of programs deleted for being too big
start_time=$(date +%s)

echo "=============================================================================="
echo "Random C Program Generator - Small Programs Only"
echo "=============================================================================="
echo "Configuration:"
echo "  Programs to generate: $MAX_PROGRAMS"
echo "  Maximum size: $MAX_SIZE lines"
echo "  Output directory: $OUTPUT_DIR/"
echo "=============================================================================="
echo "Starting generation..."
echo ""

# Keep generating until we have enough small programs
while [ $counter -lt $MAX_PROGRAMS ]; do
    ((generated++))
    
    # Generate filename with leading zeros (01, 02, etc.)
    filename=$(printf "%s/program_%02d.c" "$OUTPUT_DIR" "$counter")
    
    # Generate program and save to temp file first
    temp_file="$TEMP_DIR/temp_program_$generated.c"
    
    # Generate the program
    if ./randprog > "$temp_file" 2>/dev/null; then
        # Count lines in the generated program
        line_count=$(wc -l < "$temp_file")
        
        # Check if program is small enough
        if [ "$line_count" -le "$MAX_SIZE" ]; then
            # Program is small enough - keep it
            cp "$temp_file" "$filename"
            ((counter++))
            print_success "Saved: $(basename "$filename") ($line_count lines)"
            print_info "Progress: $counter/$MAX_PROGRAMS small programs found"
        else
            # Program is too big - delete it
            ((deleted++))
            print_error "Deleted: Too big ($line_count lines, max: $MAX_SIZE)"
        fi
    else
        ((deleted++))
        print_error "Error generating program #$generated"
    fi
    
    # Clean up temp file
    rm -f "$temp_file"
    
    # Progress bar (simple version)
    if [ $((generated % 5)) -eq 0 ]; then
        echo ""
    fi
done

# Calculate statistics
end_time=$(date +%s)
duration=$((end_time - start_time))
success_rate=$(echo "scale=1; ($counter * 100) / $generated" | bc)

echo ""
echo "=============================================================================="
echo "Generation complete!"
echo "=============================================================================="
echo "Statistics:"
echo "  Total programs generated: $generated"
echo "  Small programs saved: $counter"
echo "  Large programs deleted: $deleted"
echo "  Success rate: ~$success_rate%"
echo "  Time taken: ${duration}s"
echo "  Size range: Checking..."
echo ""
echo "Files saved in: $OUTPUT_DIR/"

# Analyze line counts of saved programs
echo ""
echo "Analysis of saved programs:"
echo "---------------------------"
total_lines=0
min_lines=999999
max_lines=0

for file in "$OUTPUT_DIR"/program_*.c; do
    if [ -f "$file" ]; then
        lines=$(wc -l < "$file")
        total_lines=$((total_lines + lines))
        
        if [ "$lines" -lt "$min_lines" ]; then
            min_lines=$lines
        fi
        
        if [ "$lines" -gt "$max_lines" ]; then
            max_lines=$lines
        fi
    fi
done

avg_lines=$((total_lines / MAX_PROGRAMS))

echo "  Total lines: $total_lines"
echo "  Average lines per program: $avg_lines"
echo "  Smallest program: $min_lines lines"
echo "  Largest program: $max_lines lines"
echo "  Total disk space: $(du -sh "$OUTPUT_DIR" | cut -f1)"

# Clean up temp directory
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
    print_info "Cleaned up temporary files"
fi

echo ""
echo "All done! Your small random C programs are ready in: $OUTPUT_DIR/"