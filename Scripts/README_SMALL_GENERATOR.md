# Random C Program Generator Scripts

This directory contains scripts to generate random C programs using `./randprog` and filter them for size.

## Available Scripts

### 1. `generate_small_programs.sh` (Basic Version)
Simple script that generates small random C programs with basic output.

**Usage:**
```bash
./generate_small_programs.sh
```

**Features:**
- Generates 20 small programs (≤100 lines)
- Saves to `small_programs/` directory
- Shows progress and statistics
- Deletes programs that are too big

**Customization:**
Edit the script directly to change:
- `MAX_PROGRAMS=20` - Number of programs to generate
- `MAX_SIZE=100` - Maximum lines allowed

### 2. `generate_small_programs_enhanced.sh` (Enhanced Version)
Advanced script with more features and better statistics.

**Usage:**
```bash
./generate_small_programs_enhanced.sh
```

**Customization via environment variables:**
```bash
# Generate 10 programs under 50 lines
MAX_PROGRAMS=10 MAX_SIZE=50 ./generate_small_programs_enhanced.sh
```

**Features:**
- Customizable parameters via environment variables
- Colored output for better readability
- Detailed statistics and analysis
- Progress tracking
- Automatic cleanup
- Size range analysis
- Success rate calculation

## Example Output Sample

When you run the script, it will:

1. Generate programs using `./randprog`
2. Check line count of each program
3. Keep small programs (≤MAX_SIZE lines)
4. Delete large programs with error message
5. Continue until 20 small programs are found
6. Show detailed statistics

**Sample Statistics:**
```
Generation complete!
Statistics:
  Total programs generated: 72
  Small programs saved: 20
  Large programs deleted: 52
  Success rate: ~27.7%
  Time taken: 15s
  Size range: 54-94 lines
```

## Generated Programs

Programs are saved as:
- `small_programs/program_01.c`
- `small_programs/program_02.c`
- ... up to 20 programs

Each program is a complete, compilable C program with:
- Random function declarations
- Variable declarations
- Control structures
- Recursive calls limited by MAX_DEPTH

## Size Statistics

Based on testing with MAX_SIZE=100:
- **Success rate**: ~25-35% (programs under 100 lines)
- **Common sizes**: 54-94 lines
- **Typical generation time**: 10-20 seconds for 20 programs
- **Storage**: ~80-90KB for 20 small programs

## Compiling Generated Programs

Each generated program can be compiled:
```bash
gcc small_programs/program_01.c -o small_programs/program_01
./small_programs/program_01
```

## Troubleshooting

**Problem**: Scripts generates too slowly
**Solution**: Increase MAX_SIZE to allow more programs to be kept

**Problem**: Too many large programs deleted
**Solution**: The generator naturally creates large programs; this is expected behavior

**Problem**: Permission denied
**Solution**: Make scripts executable: `chmod +x generate_small_programs*.sh`

## Notes

- The random program generator (`./randprog`) creates programs of widely varying sizes
- Small programs are relatively rare (success rate is often under 50%)
- Some generated programs can be 10,000+ lines
- All generated programs are syntactically valid C code