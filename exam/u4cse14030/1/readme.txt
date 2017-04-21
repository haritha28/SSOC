Entry point address: 0x4004d0
Main: 0x4005f3
Checks if there are three arguments
After checking it finds the string length of the first argument and calls an atoi function
for the second argument, which is then converted to quadword using cdqe.It then checks if
the value of each character in the first string is valid or not. 
