#!/usr/bin/env python3
"""Build minimal Eldarica file: only blocks reachable from check-sat / safety rules."""
import re, sys

text = open(sys.argv[1]).read()
lines = text.split('\n')

# Parse into top-level S-expression blocks
blocks = []
depth = 0
current = []
for line in lines:
    for ch in line:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
    current.append(line)
    if depth <= 0:
        depth = 0
        blocks.append('\n'.join(current))
        current = []
if current:
    blocks.append('\n'.join(current))

# Classify each block
stdlib = []       # set-logic, define-fun, define-const
decl_map = {}     # name -> block (declare-fun)
rule_map = {}     # name -> [blocks] (assert rules concluding with name)
safety = []       # assert rules concluding with false
checksats = []    # check-sat

# Collect all declared relation names
all_names = set()
for block in blocks:
    s = block.strip()
    m = re.match(r'\(declare-fun\s+(\S+)', s)
    if m:
        all_names.add(m.group(1))

for block in blocks:
    s = block.strip()
    if not s:
        continue

    if s.startswith('(set-logic') or s.startswith('(define-fun') or s.startswith('(define-const'):
        stdlib.append(block)
        continue

    m = re.match(r'\(declare-fun\s+(\S+)', s)
    if m:
        decl_map[m.group(1)] = block
        continue

    if s.startswith('(check-sat'):
        checksats.append(block)
        continue

    if s.startswith('(assert'):
        # Find conclusion: the last relation-name application
        # Safety rules conclude with "false"
        if re.search(r'\bfalse\)\)\)\s*$', s):
            safety.append(block)
            continue

        # Find all declared names that appear in this block as conclusions
        # A conclusion is typically the last predicate call in the implication
        # We look for (name arg1 arg2...) pattern at the end
        found_conclusion = None
        for name in all_names:
            # Check if this name appears as a conclusion (at the end of the rule)
            if re.search(r'\(' + re.escape(name) + r'\s+[^)]*\)\)\)\)?\s*$', s):
                found_conclusion = name
                break
        if found_conclusion:
            rule_map.setdefault(found_conclusion, []).append(block)
        else:
            safety.append(block)  # Can't classify, treat as safety
        continue

    # Comments and whitespace
    stdlib.append(block)

# Find all names transitively needed by safety rules
needed = set()

def find_refs(text):
    """Find all declared relation names referenced in a block."""
    refs = set()
    for name in all_names:
        if re.search(r'\b' + re.escape(name) + r'\b', text):
            refs.add(name)
    return refs

# Seed from safety rules
for block in safety:
    needed |= find_refs(block)

# Transitive closure
changed = True
while changed:
    changed = False
    for name in list(needed):
        for rule_block in rule_map.get(name, []):
            new_refs = find_refs(rule_block) - needed
            if new_refs:
                needed |= new_refs
                changed = True

# Output
out = []
for b in stdlib:
    out.append(b)

# Declarations for needed names (in original order)
for block in blocks:
    s = block.strip()
    m = re.match(r'\(declare-fun\s+(\S+)', s)
    if m and m.group(1) in needed:
        out.append(block)

# Rules for needed names (in original order)
for block in blocks:
    s = block.strip()
    if s.startswith('(assert'):
        # Include if it's a safety rule or a rule for a needed name
        if block in safety:
            out.append(block)
            continue
        for name in needed:
            if block in rule_map.get(name, []):
                out.append(block)
                break

for b in checksats:
    out.append(b)

print('\n'.join(out))
