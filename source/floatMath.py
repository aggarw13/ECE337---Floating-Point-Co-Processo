#!/usr/bin/env python
#Python code for representing floating point arithmetic 
#Input: Arithmetic Mode (Addition, Subtraction, Multiplication, Sine)
#       Operand 1, Operand 2
#Output: Operand 1 Binary Form, Operand 2 Binary Form, Result Binary Form

import sys
import struct
import math

def conv_binary_to_dec(sign, exp, mantissa):
    if(sign == '0'):
        sgn = 1
    else:
        sgn = -1
    operand = 1
    for i in range(23):
        operand += pow(2,-(i+1)) * int(mantissa[i],2)
    operand *= sgn * pow(2,int(exp,2) - 127) 
    return operand

#Done all in main: No need to modulate for simple check
def main(argv):
    #Input Check
    if(len(argv) != 5 and len(argv) != 4 and len(argv) != 9 and len(argv) != 8):
        print("Usage: ./floatMath.py [input type] [mode] [operand1 (sub components)] [operand2 (sub components)]/n")
        print("[input type] : dec binary/n")
        print("[mode]: [add],[sub],[mul],[sine],[conv]/n")
        print("sine only takes one operand")
        sys.exit()
    #Mode Check
    mode = argv[2]
    if(mode != 'add' and mode != 'sub' and mode != 'mul' and mode != 'sine' and mode != 'conv'):
        print("Error: Wrong mode specified")
        print("[mode]: [add],[sub],[mul],[sine],[conv]")
        sys.exit()
    if(argv[1] == 'dec'):        
    #Operand Check
        try:
            if(mode == 'sine' or mode == 'conv'):
                op1 = int(argv[3])
            else:
                op1 = float(argv[3])
                op2 = float(argv[4])
        except:
            print("Error: Give proper operands")
            sys.exit()
    else:
        if(mode == 'sine' or mode == 'conv'):
            op1 = conv_binary_to_dec(argv[3], argv[4], argv[5])
        else:
            op1 = conv_binary_to_dec(argv[3], argv[4], argv[5])
            op2 = conv_binary_to_dec(argv[6], argv[7], argv[8])
    #Calculate
    if(mode == 'add'):
        res = op1 + op2
    elif(mode == 'sub'):
        res = op1 - op2
    elif(mode == 'mul'):
        res = op1 * op2
    elif(mode == 'sine'):
        res = op1 - pow(op1,3)/6 + pow(op1,5)/120 - pow(op1,7)/5040
    #Print
    if(mode == 'conv'):
        op1p = struct.pack('!f',op1)
        int1 = [ord(i) for i in op1p]
        bin1 = [bin(i).replace('0b','') for i in int1]
        pad1 = [i.rjust(8,'0') for i in bin1]
        print 'Operand 1:   ',op1
        print 'Binary Form: ',
        fin1 = ''.join(pad1)
        print fin1
        print 'Sign:',fin1[0],' Exponent:',fin1[1:9],' Mantissa:',fin1[9:33]
    elif(mode == 'sine'):
        if(res > 1 or res < -1):
            print("Sine operand should be in between -pi to pi")
        op1p = struct.pack('!f',op1)
        int1 = [ord(i) for i in op1p]
        bin1 = [bin(i).replace('0b','') for i in int1]
        pad1 = [i.rjust(8,'0') for i in bin1]
        print 'Operand 1:   ',op1
        print 'Binary Form: ',
        fin1 = ''.join(pad1)
        print fin1
        print 'Sign:',fin1[0],' Exponent:',fin1[1:9],' Mantissa:',fin1[9:33]
        resp = struct.pack('!f',res)
        intres = [ord(i) for i in resp]
        binres = [bin(i).replace('0b','') for i in intres]
        padres = [i.rjust(8,'0') for i in binres]
        print 'Sine Result: ',res
        print 'Binary Form: ',
        finres = ''.join(padres)
        print finres
        print 'Sign:',finres[0],' Exponent:',finres[1:9],' Mantissa:',finres[9:33]
    else:
        op1p = struct.pack('!f',op1)
        int1 = [ord(i) for i in op1p]
        bin1 = [bin(i).replace('0b','') for i in int1]
        pad1 = [i.rjust(8,'0') for i in bin1]
        print 'Operand 1:   ',op1
        print 'Binary Form: ',
        fin1 = ''.join(pad1)
        print fin1
        print 'Sign:',fin1[0],' Exponent:',fin1[1:9],' Mantissa:',fin1[9:33]
        op2p = struct.pack('!f',op2)
        int2 = [ord(i) for i in op2p]
        bin2 = [bin(i).replace('0b','') for i in int2]
        pad2 = [i.rjust(8,'0') for i in bin2]
        print 'Operand 2:   ',op2
        print 'Binary Form: ',
        fin2 = ''.join(pad2)
        print fin2
        print 'Sign:',fin2[0],' Exponent:',fin2[1:9],' Mantissa:',fin2[9:33]
        resp = struct.pack('!f',res)
        intres = [ord(i) for i in resp]
        binres = [bin(i).replace('0b','') for i in intres]
        padres = [i.rjust(8,'0') for i in binres]
        print mode,
        print 'Result:  ',res
        print 'Binary Form: ',
        finres = ''.join(padres)
        print finres
        print 'Sign:',finres[0],' Exponent:',finres[1:9],' Mantissa:',finres[9:33]
        

if __name__ == '__main__':
    main(sys.argv)
