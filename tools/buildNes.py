with open('original/OR', 'rb') as f:
    header = f.read()[:0x10]

with open('willow.bin', 'rb') as f:
    prgData = f.read()

with open('original/OR.chr', 'rb') as f:
    chrData = f.read()

with open('willowBuild.nes', 'wb') as f:
    f.write(header + prgData + chrData)
