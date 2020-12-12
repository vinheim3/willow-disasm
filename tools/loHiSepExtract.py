import sys
import clipboard

with open('original/OR.bin', 'rb') as f:
    data = f.read()

low, high, base, numBytes = sys.argv[1:]

def conv(hexstr):
    return int(f"0x{hexstr}", 16)

if ':' in low:
    bank, addr = low.split(':')
    bank = conv(bank)
    addr = conv(addr)
    low = bank*0x4000+addr
else:
    bank = 0
    low = conv(low)

if ':' in high:
    bank, addr = high.split(':')
    bank = conv(bank)
    addr = conv(addr)
    if bank == 0:
        high = addr
    else:
        high = bank*0x4000+addr
else:
    end = conv(high)

numBytes = conv(numBytes)
base = conv(base)

words = []
for i in range(numBytes):
    lo = data[low+i]
    hi = data[high+i]
    words.append((hi<<8)|lo)

comps = []
for word in words:
    # comps.append(f"\t.db <func_{bank:02x}_{word-base:04x}")
    comps.append(f"\t.db <${word:04x}")
comps.append("")
for word in words:
    # comps.append(f"\t.db >func_{bank:02x}_{word-base:04x}")
    comps.append(f"\t.db >${word:04x}")

final_str = "\n".join(comps)
print(final_str)
clipboard.copy(final_str)
