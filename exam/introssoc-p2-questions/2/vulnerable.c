#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define COOKIE 0x1337133713371337
#define BUF_SIZE 64


void print_flag() {
    system("cat flag.txt");
    _exit(0);
}


int main()
{
    uint64_t cookie = COOKIE;
    char buf[BUF_SIZE];
    printf("Welcome to l33t echo server!\n");
    printf("I print back inputs and also tell you if you are l33t\n");
    scanf("%[^\n]", buf);
    printf("%s\n", buf);
    if (cookie != COOKIE) {
        printf("You are not l33t! Exiting!\n");
        _exit(1);
    }
    else {
        printf("You are l33t! Awesome!\n");
    }
    return 0;
}
