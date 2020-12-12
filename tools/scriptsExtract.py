import clipboard
import json

with open('original/OR.bin', 'rb') as f:
    data = f.read()
with open('json/globalFlags.json') as f:
    flags = json.loads(f.read())

offset = 0x4000
# offset = 7*0x4000+0x2e00

comps = []
addresses = []
address_map = {}
numTexts = 115
# numTexts = 183
prefix = "script"
# prefix = "scriptPreset"
for i in range(numTexts):
    word = data[offset+i*2] + (data[offset+1+i*2]<<8)
    addresses.append(word-0x8000)
    comps.append(f"\t.dw {prefix}_{i:02x}")
    address_map.setdefault(word-0x8000, []).append(i)

finalAddress = 0x3874
# finalAddress = 0x3f3f
addresses.append(finalAddress)
comps.append("")

s_addresses = sorted(set(addresses))

for i, address in enumerate(s_addresses[:-1]):
    nextAddress = s_addresses[i+1]
    scriptBytes = data[0x4000+address:0x4000+nextAddress]

    for val in sorted(address_map[address]):
        comps.append(f"{prefix}_{val:02x}:")

    def is_ascii(byte):
        if byte <= 9:
            return str(byte), True

        if byte in [0x20, 0x21, 0x27, 0x2c, 0x2e]:
            return chr(byte), True

        if 0x41 <= byte <= 0x5a:
            return chr(byte), True

        if byte == 0x28:
            return '<', True

        if byte == 0x29:
            return '>', True

        return False, False

    print(hex(address))
    _, currAscii = is_ascii(scriptBytes[0])
    ascString = ""
    nonAscBytes = []

    def print_non_asc():
        joined = " ".join(f"${_b:02x}" for _b in nonAscBytes)
        comps.append(f"\t.db {joined}")

    def print_asc():
        comps.append(f'\t.asc "{ascString}"')

    i = 0
    while i < len(scriptBytes):
        byte = scriptBytes[i]
        char, byte_is_ascii = is_ascii(scriptBytes[i])
        i += 1
        if byte in [0xf4, 0xf5, 0xfa]:
            if currAscii and ascString:
                print_asc()
            if not currAscii and nonAscBytes:
                print_non_asc()
            
            if byte == 0xf4:
                param = str(scriptBytes[i])
                i += 1
                comps.append(f"\tscr_unsetGlobalFlag {flags[param]}")
            elif byte == 0xf5:
                param1 = scriptBytes[i]
                i += 1
                param2 = scriptBytes[i]
                i += 1
                comps.append(f"\tscr_setRoomYX ${param1:02x} ${param2:02x}")
            elif byte == 0xfa:
                param = str(scriptBytes[i])
                i += 1
                comps.append(f"\tscr_setGlobalFlag {flags[param]}")
            
            _, currAscii = is_ascii(scriptBytes[i])
            ascString = ""
            nonAscBytes = []
        elif byte_is_ascii:
            if currAscii:
                ascString += char
            else:
                print_non_asc()
                currAscii = True
                ascString = char
        else:
            if currAscii:
                print_asc()
                currAscii = False
                nonAscBytes = [byte]
            else:
                nonAscBytes.append(byte)
    if currAscii and ascString:
        print_asc()
    if not currAscii and nonAscBytes:
        print_non_asc()

    comps.append("")

final_str = "\n".join(comps)
print(final_str)
clipboard.copy(final_str)