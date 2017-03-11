Step1:    I used "readelf -h validate.out" to get the entry point, which is 0x4006d0
          Then set disassembly-flavor intel and type: x/20i 0x4006d0
          Got the first 20 instruction from where we got the start function at 0x4006ed

Step2:	  Set a break point to the address 0x4006ed we can see that we are passing one function 
	  as an agrument to the main function. Which is 0x4007bd. 
	  Here we check if the number of argument is three or not, if it is three we jmp to 
	  0x4007fc and if it is not  three we have a usage error. 
	  
Step3:    In 0x4007fc, we find the strlength of the username given pass three arguments to the 
	  function jmp_MD5 out of which one is the strinlength given to rsi, rdx -> not sure
	  rdi -> username 
