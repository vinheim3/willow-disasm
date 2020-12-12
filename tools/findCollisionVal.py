with open('original/OR.bin', 'rb') as f:
    data = f.read()

start = 3*0x4000+0x3800
end = 3*0x4000+0x3fe8

offset = 0
i = -1
while start+offset < end:
    group = data[start+offset]
    roomIdx = data[start+offset+1]
    offset += 2
    i += 1

    if group != 3:
        continue

    roomByteStart = 2*0x4000+roomIdx*0x40
    roomByteEnd = 2*0x4000+(roomIdx+1)*0x40
    roomBytes = data[roomByteStart:roomByteEnd]

    if 0x8e in roomBytes:
        print(hex(i))
