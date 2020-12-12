import clipboard

with open('original/OR.bin', 'rb') as f:
    data = f.read()

comps = []
addresses = []

offset = 6*0x4000+0x2483
for i in range(86):
    word = data[offset+i*2] + (data[offset+1+i*2]<<8)
    addresses.append(word-0x8000)
    comps.append(f"\t.dw scriptsData_{i:02x}")

addresses.append(0x2647)
comps.append("")

for i, address in enumerate(addresses[:-1]):
    nextAddress = addresses[i+1]
    scriptBytes = data[6*0x4000+address:6*0x4000+nextAddress]
    comps.append(f"scriptsData_{i:02x}:")
    if not scriptBytes:
        continue

    countByte = scriptBytes[0]
    comps.append(f"\t.db ${countByte:02x}")
    for i in range(countByte):
        comps.append(f"\t.db ${scriptBytes[i*2+1]:02x} ${scriptBytes[i*2+2]:02x}")
    comps.append(f"\t.db ${scriptBytes[-1]:02x}")
    comps.append(f"")

final_str = "\n".join(comps)
print(final_str)
clipboard.copy(final_str)