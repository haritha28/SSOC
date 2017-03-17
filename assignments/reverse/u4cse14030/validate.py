#!/usr/bin/python
import md5
import hashlib
import struct
import numpy

input = raw_input()
list =  input.split( " ")
count_check = len(input)

def xorfun(value):
    return hex(( (number >> 64 ) ^ number) & 0xffffffffffffffff)

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
    xorval = xorfun(value)
    print xorval

if count_check < 1:
    print "USAGE: USERNAME KEY"
else:
    check_key(list)
