import sys
import re

fname, start, end = sys.argv[1:]
start = int(start)
end = int(end)

if fname.isdigit():
    full_fname = f'code/bank0{fname}.s'
else:
    full_fname = f'code/{fname}.s'

with open(full_fname) as f:
    code = f.read()

with open('temp.s', 'w') as f:
    f.write(code)

lines = code.split('\n')

relevantLines = lines[start-1:end]

comps = lines[:start-1]
for line in relevantLines:
    _line = re.sub(r'^B[^\n	]+:	', '', line)
    _line = re.sub(r'	+;.*', '', _line)
    comps.append(_line)
comps.extend(lines[end:])
with open(full_fname, 'w') as f:
    f.write('\n'.join(comps))
