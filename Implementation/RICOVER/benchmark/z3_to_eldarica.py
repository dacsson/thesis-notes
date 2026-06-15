#!/usr/bin/env python3
"""Convert Z3 fixedpoint (declare-rel/rule/query) to standard HORN (declare-fun/assert/check-sat).

Key differences:
  - Z3: declare-rel/rule/query bad → unsat = safe
  - Eldarica: declare-fun/assert/(=> ... false)/check-sat → sat = safe

Also strips IR-derived rules containing (_ unit) placeholders that Eldarica can't parse,
and removes duplicate declarations.
"""
import re, sys

text = open(sys.argv[1]).read()

# 0. Parse into top-level S-expression blocks.
lines = text.split('\n')
blocks = []
depth = 0
current_block = []
for line in lines:
    for ch in line:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
    current_block.append(line)
    if depth <= 0:
        depth = 0
        blocks.append('\n'.join(current_block))
        current_block = []
if current_block:
    blocks.append('\n'.join(current_block))

# 1. Filter out blocks containing (_ unit)
blocks = [b for b in blocks if '(_ unit)' not in b]

# 2. Deduplicate: remove duplicate declare-rel blocks by name
seen_decls = set()
deduped = []
for block_text in blocks:
    m = re.match(r'\(declare-(?:rel|fun)\s+(\S+)', block_text)
    if m:
        name = m.group(1)
        if name in seen_decls:
            continue
        seen_decls.add(name)
    deduped.append(block_text)

text = '\n'.join(deduped)

# 3. declare-rel → declare-fun ... Bool (multi-line aware)
def convert_declare_rel(m):
    name = m.group(1)
    types = m.group(2).strip()
    return f"(declare-fun {name} ({types}) Bool)"

text = re.sub(
    r'\(declare-rel\s+(\S+)\s*\n?\s*\(((?:[^()]*|\((?:[^()]*|\([^()]*\))*\))*)\)\)',
    convert_declare_rel,
    text
)

# Handle no-arg: (declare-rel bad ())
text = re.sub(
    r'\(declare-rel\s+(\S+)\s+\(\)\)',
    r'(declare-fun \1 () Bool)',
    text
)

# 4. (rule ...) → (assert ...)
text = re.sub(r'^\(rule\b', '(assert', text, flags=re.MULTILINE)

# 5. Convert "bad" pattern to Eldarica-compatible form.
#    Z3 uses: multiple rules with conclusion "bad", then (query bad).
#    Eldarica uses: inline => ... false (no separate bad predicate).
#
#    Strategy: replace conclusion "bad" with "false" in each rule,
#    remove the (declare-fun bad () Bool), and replace (query bad) with (check-sat).

# Remove declare-fun bad
text = re.sub(r'\(declare-fun bad \(\) Bool\)\n?', '', text)

# In rule conclusions, replace bare "bad" with "false"
# Pattern: "        bad)))" at end of a rule
text = re.sub(r'\n(\s+)bad\)\)\)', r'\n\1false)))', text)

# Remove (query bad) and add (check-sat)
text = re.sub(r'\(query\s+bad\)', '(check-sat)', text)

# Also handle any remaining (query X) for other names
text = re.sub(
    r'\(query\s+(\S+)\)',
    r'(assert (=> (\1) false))\n(check-sat)',
    text
)

# 6. Rename instruction relations that clash with SMT-LIB keywords.
#    Z3 fixedpoint mode allows declare-rel to shadow keywords, but in
#    standard HORN format, `and`/`or`/`xor` are reserved.
for kw in ['and', 'or', 'xor']:
    # Rename in declare-fun and assert bodies — only when used as a relation name
    # Pattern: (and regs0 mem0 ...) as a predicate call (not boolean AND)
    # We need to be careful: (and (= ...) (= ...)) is boolean AND
    # But (declare-fun and (...) Bool) is a relation declaration
    text = re.sub(r'\(declare-fun ' + kw + r' \(', f'(declare-fun rv_{kw} (', text)
    # In rule conclusions: (and regs0 mem0 pc0 ...) where and is a predicate
    # These always appear with state variable arguments, not boolean subformulas
    text = re.sub(r'\(' + kw + r' (regs\d)', rf'(rv_{kw} \1', text)

# 7. Verify no declare-rel remains
remaining = re.findall(r'\(declare-rel\s+\S+', text)
if remaining:
    print(f"WARNING: unconverted declare-rel: {remaining}", file=sys.stderr)

print(text)
