from utils import *

# getting chr banks
# find nearby room in roomAreaTransitionYXs
# get relevant same-idxed value from next table
# get chrPalMusData from above offset
# 1st val is chrBank1

roomY = 0x1a
roomX = 0x0e
chrBank0 = 0x1f
chrBank1 = 0x04

groupShapeOffset = address(3, 0x3800 + roomY * 0x40 + roomX * 2)
group = prgData[groupShapeOffset]
shape = prgData[groupShapeOffset+1]

if roomY >= 0x1d:
    bank = 3
else:
    bank = 2
metatileOffset = address(bank, shape * 0x40)
metatiles = prgData[metatileOffset:metatileOffset+0x40]

smallerMetatiles = []
for i in range(8):
    smallerMetatiles.append([])
    smallerMetatiles.append([])

smallerMetatileOffset = address(3, 0x1000+group*0x400)
for i in range(8):
    for j in range(8):
        metatile = metatiles[i*8+j]
        topLeft = prgData[smallerMetatileOffset+metatile*4]
        topRight = prgData[smallerMetatileOffset+metatile*4+1]
        bottomLeft = prgData[smallerMetatileOffset+metatile*4+2]
        bottomRight = prgData[smallerMetatileOffset+metatile*4+3]
        smallerMetatiles[i*2].append(topLeft)
        smallerMetatiles[i*2+1].append(bottomLeft)
        smallerMetatiles[i*2].append(topRight)
        smallerMetatiles[i*2+1].append(bottomRight)

# todo: replace with printing collision vals
for row in smallerMetatiles:
    print(joinB(row))

smallestMetatiles = []
for i in range(16):
    smallestMetatiles.append([])
    smallestMetatiles.append([])

for i in range(16):
    for j in range(16):
        metatile = smallerMetatiles[i][j] & 0x3f
        metatile *= 4
        smallestMetatiles[i*2].append(metatile)
        smallestMetatiles[i*2+1].append(metatile+1)
        smallestMetatiles[i*2].append(metatile+2)
        smallestMetatiles[i*2+1].append(metatile+3)

allTiles = []
for row in smallestMetatiles:
    allTiles.extend(row)

currChrData = chrData[chrBank0*0x1000:(chrBank0+1)*0x1000] + chrData[chrBank1*0x1000:(chrBank1+1)*0x1000]
allBytes = []
for tile in allTiles:
    offset = tile * 0x10 + 0x1000
    allBytes.extend(currChrData[offset:offset+0x10])
with open('gfx_layout.chr', 'wb') as f:
    f.write(bytearray(allBytes))

import gfx