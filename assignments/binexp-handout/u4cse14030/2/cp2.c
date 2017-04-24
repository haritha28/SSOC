#include <stdio.h>

FILE *ifh, *ofh;

void g1() {
    asm(".intel_syntax noprefix");
    asm("push rsi");
    asm("pop rdi");
    asm("ret");
    asm("mov rsi, rsp");
    asm("add rsp, rdi");
}

int main(int argc, char **argv) {
    char buf[1024];
    if (argc == 3) {
        ifh = fopen(argv[1], "r");
        ofh = fopen(argv[2], "w");
        if (ifh) {
            while (1) {
                if (fscanf(ifh, "%[^\n]", buf) > 0)
                    fprintf(ofh, "%s\n", buf);
                else
                    break;
            }
            fclose(ifh);
            fclose(ofh);
        }
    }
    return 0;
}
