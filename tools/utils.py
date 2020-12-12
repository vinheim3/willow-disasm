import sys

with open('original/OR.bin', 'rb') as f:
    prgData = f.read()

with open('original/OR.chr', 'rb') as f:
    chrData = f.read()

def word(idx):
    return (prgData[idx+1]<<8)|prgData[idx]

def conv(hexstr):
    return int(f"0x{hexstr}", 16)

def bankConv(hexstr):
    if ':' in hexstr:
        bank, addr = hexstr.split(':')
    else:
        bank = 0
        addr = hexstr
    bank = conv(bank)
    addr = conv(addr)
    return bank * 0x4000 + addr

def address(_bank, _addr):
    return _bank*0x4000+_addr

def joinB(_bytes):
    return ' '.join(f'${b:02x}' for b in _bytes)

def getOutstandingLines():
    import os
    fnames = os.listdir('code')
    total = 0
    for fname in fnames:
        if 'bank' not in fname and '1' not in sys.argv:
            continue
        with open(f'code/{fname}') as f:
            data = f.read().split('\n')
    
        for line in data:
            if line.startswith('B'):
                total += 1
    print(total)

if __name__ == '__main__':
    getOutstandingLines()