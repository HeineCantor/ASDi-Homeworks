INPUT_BITS = 6

converter = ""

for i in range(2**INPUT_BITS):
    iString = str(i)
    bcdString = ""
    tmpBCD = ""
    for digit in iString:
        tmpBCD += str.rjust("{0:b}".format(int(digit)), 4, '0')
    
    tmpBCD = str.rjust(tmpBCD, 8, '0')
    bcdString += tmpBCD

    converter += f"\"{bcdString}\"" + " when \"" + str.rjust("{0:b}".format(i), INPUT_BITS, '0') + "\",\n"

print(converter)
file = open("./converterBCD.txt", mode='w')
file.write(converter)