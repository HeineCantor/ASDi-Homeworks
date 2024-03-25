INPUT_BITS = 4

converter = ""

for i in range(2**INPUT_BITS):
    value = i
    sign = "0000"
    if(i >= 2**(INPUT_BITS-1)):
        value = 2**(INPUT_BITS-1) - (i - 2**(INPUT_BITS-1))
        sign = "1111"
    iString = str(value)
    bcdString = ""
    tmpBCD = ""
    for digit in iString:
        tmpBCD += str.rjust("{0:b}".format(int(digit)), 4, '0')
    
    tmpBCD = str.rjust(tmpBCD, 8, '0')
    tmpBCD = sign + tmpBCD
    bcdString += tmpBCD

    converter += f"\"{bcdString}\"" + " when \"" + str.rjust("{0:b}".format(i), INPUT_BITS, '0') + "\",\n"

print(converter)
file = open("./converterBCD.txt", mode='w')
file.write(converter)