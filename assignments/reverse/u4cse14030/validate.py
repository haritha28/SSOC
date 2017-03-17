#!/usr/bin/python
import md5
import hashlib
import struct
import numpy

#array = ['0x5daac65f720be8c9',' 0x8c92b50d1c2d1e4f','0xa6fd433408510ea4','0x0e9296eddd450b03','0x84db12124b70fbd9','0x091d7b508606ffac','0xfd41e1b9fd423b8f','0x56bd6aca483c8c74','0x037c7f5864b34642','0xb488202e8ea9111b','0x88af43a6fe478cda','0xaa4fc294b8b380b6','0x5b1c0d7ed87b9535','0x4a9b68be4888bc63',' 0x0b1a4657555b0964','0xf0e4afaab7a436c1','0x3b031b0100000408']

input = raw_input()
list =  input.split( " ")
count_check = len(input)

# def loop1(xorval):
#     temp = xorval
#     counter = 0
#     while ( counter != 64 ):
#         shiftright_value = hex(temp >> counter)
#         print shiftright_value
#         counter+=16
def pair_reverse(hashval):
    n = len(hashval)/2
    fmt = '%dh' % n
    return struct.pack(fmt, *reversed(struct.unpack(fmt, hashval)))

def check_key(list):
    user_name = list[0]
    user_len = len(user_name)
    flag = 1
    hashval =  hashlib.md5(user_name).hexdigest()
    value = pair_reverse(hashval)
    result_128 = ((int(value,16) >> 64 ) ^ int(value,16)) & 0xffffffffffffffff
    xorval = hex(result_128)

if count_check < 1:
    print "USAGE: USERNAME KEY"
else:
    check_key(list)
