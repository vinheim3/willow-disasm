from utils import *
import clipboard

lowAddr = bankConv('7:1064')
hiAddr = bankConv('7:1104')

addresses = []
address_map = {}
for i in range(0x1104-0x1064):
    low = prgData[lowAddr+i]
    high = prgData[hiAddr+i]
    _word = ((high<<8)|low)-0xc000
    addresses.append(_word)
    address_map.setdefault(_word, []).append(i)

comps = []
s_addresses = sorted(set(addresses))
for i, addr in enumerate(s_addresses[:-1]):
    for num in sorted(address_map[addr]):
        comps.append(f'internalPaletteSpec_{num:02x}:')
    nextAddress = s_addresses[i+1]
    allBytes = prgData[address(7, addr):address(7, nextAddress)]

    joined = joinB(allBytes)
    comps.append(f'\t.db {joined}\n')

final_str = '\n'.join(comps)
print(final_str)
clipboard.copy(final_str)
