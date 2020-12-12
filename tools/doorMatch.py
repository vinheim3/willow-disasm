import clipboard

with open('original/OR.bin', 'rb') as f:
    data = f.read()

indoorData = data[6*0x4000+0x2c07:]
outdoorData = data[6*0x4000+0x2cb8:]

comps = []
for i in range(88):
    indoorBytes = indoorData[i*2:i*2+2]
    outdoorBytes = outdoorData[i*2:i*2+2]
    comps.append(f'indoor: y{indoorBytes[0]:02x} x{indoorBytes[1]:02x}, outdoor: y{outdoorBytes[0]:02x} x{outdoorBytes[1]:02x}')

clipboard.copy('\n'.join(comps))

"""
indoor: y0f x0e, outdoor: y00 x00
indoor: y16 x05, outdoor: y03 x03
indoor: y0d x00, outdoor: y01 x04
indoor: y0d x00, outdoor: y00 x04
indoor: y14 x0a, outdoor: y00 x03
indoor: y0a x06, outdoor: y03 x13
indoor: y0b x05, outdoor: y01 x11
indoor: y09 x04, outdoor: y07 x16
indoor: y0c x00, outdoor: y01 x14
indoor: y09 x05, outdoor: y06 x16
indoor: y08 x05, outdoor: y05 x17
indoor: y0b x03, outdoor: y02 x1a
indoor: y0b x02, outdoor: y08 x1b
indoor: y0b x00, outdoor: y04 x15
indoor: y0d x0b, outdoor: y11 x10
indoor: y0d x0e, outdoor: y12 x16
indoor: y10 x12, outdoor: y00 x1d
indoor: y10 x17, outdoor: y06 x1e
indoor: y0a x1a, outdoor: y08 x1e
indoor: y0b x10, outdoor: y09 x1f
indoor: y08 x04, outdoor: y0c x1f
indoor: y08 x02, outdoor: y17 x00
indoor: y09 x19, outdoor: y15 x15
indoor: y00 x18, outdoor: y14 x1d
indoor: y07 x09, outdoor: y08 x0a
indoor: y0c x06, outdoor: y06 x0a
indoor: y10 x1d, outdoor: y07 x1e
indoor: y04 x03, outdoor: y03 x01
indoor: y09 x02, outdoor: y05 x08
indoor: y08 x06, outdoor: y0c x04
indoor: y06 x05, outdoor: y03 x02
indoor: y01 x06, outdoor: y02 x04
indoor: y00 x06, outdoor: y02 x04
indoor: y03 x04, outdoor: y05 x0e
indoor: y04 x09, outdoor: y04 x0d
indoor: y01 x0d, outdoor: y04 x0e
indoor: y03 x15, outdoor: y01 x17
indoor: y12 x11, outdoor: y02 x1a
indoor: y10 x1b, outdoor: y0a x1f
indoor: y14 x16, outdoor: y0b x1f
indoor: y06 x17, outdoor: y04 x1b
indoor: y0c x1e, outdoor: y1b x09
indoor: y1a x09, outdoor: y0e x1f
indoor: y0e x1e, outdoor: y1c x04
indoor: y1b x04, outdoor: y10 x1f
indoor: y10 x1e, outdoor: y1c x06
indoor: y1b x06, outdoor: y12 x1f
indoor: y12 x1e, outdoor: y1c x05
indoor: y1b x05, outdoor: y1a x0b
indoor: y1a x0a, outdoor: y19 x0f
indoor: y17 x01, outdoor: y12 x00
indoor: y11 x00, outdoor: y19 x00
indoor: y19 x01, outdoor: y14 x00
indoor: y13 x00, outdoor: y1b x00
indoor: y1b x01, outdoor: y14 x01
indoor: y13 x01, outdoor: y18 x02
indoor: y18 x03, outdoor: y16 x00
indoor: y15 x00, outdoor: y1a x02
indoor: y1a x03, outdoor: y16 x01
indoor: y15 x01, outdoor: y18 x04
indoor: y18 x05, outdoor: y12 x01
indoor: y17 x13, outdoor: y1c x12
indoor: y1b x12, outdoor: y1b x16
indoor: y17 x17, outdoor: y1c x13
indoor: y1b x13, outdoor: y1b x1a
indoor: y18 x11, outdoor: y1c x02
indoor: y1c x0b, outdoor: y19 x15
indoor: y17 x1d, outdoor: y1c x1d
indoor: y1b x1d, outdoor: y1b x1e
indoor: y1c x1e, outdoor: y17 x1e
indoor: y1b x1f, outdoor: y16 x1f
indoor: y19 x1f, outdoor: y0d x1d
indoor: y0c x1d, outdoor: y12 x1c
indoor: y13 x1c, outdoor: y1a x1e
indoor: y12 x1d, outdoor: y1a x1f
indoor: y11 x1d, outdoor: y01 x13
indoor: y00 x13, outdoor: y19 x1d
indoor: y14 x1a, outdoor: y19 x19
indoor: y15 x19, outdoor: y13 x19
indoor: y18 x19, outdoor: y13 x1b
indoor: y17 x19, outdoor: y12 x1b
indoor: y18 x1a, outdoor: y12 x19
indoor: y17 x1a, outdoor: y11 x1b
indoor: y16 x1b, outdoor: y1a x1d
indoor: y18 x1b, outdoor: y1a x13
indoor: y16 x1e, outdoor: y16 x1a
indoor: y0e x1d, outdoor: y14 x14
indoor: y1c x02, outdoor: y1a x07
"""
