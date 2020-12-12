from utils import *
import clipboard

start = bankConv('7:208e')
offset = 0
comps = []

while prgData[start+offset] != 0xff:
    hb = prgData[start+offset]
    offset += 1
    lb = prgData[start+offset]
    offset += 1
    comps.append(f'\tdwbe ${hb:02x}{lb:02x}')

    ctrlB = prgData[start+offset]
    offset += 1
    comps.append(f'\t.db ${ctrlB:02x}')

    count = ctrlB & 0x3f
    if not count:
        count = 0x40
    if ctrlB & 0x40:
        copyByte = prgData[start+offset]
        offset += 1
        comps.append(f'\t.db ${copyByte:02x}')
    else:
        copyBytes = prgData[start+offset:start+offset+count]
        joined = ' '.join(f'${b:02x}' for b in copyBytes)
        comps.append(f'\t.db {joined}')
        offset += count
    comps.append('')

comps.append(f'\t.db $ff\n')
final_str = '\n'.join(comps)
print(final_str)
clipboard.copy(final_str)
print(hex(start+offset))
