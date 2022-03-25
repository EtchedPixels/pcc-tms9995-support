#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    unsigned i;
    char path[128];
    FILE *fp;
    for (i = 1; i <= 255; i++) {
        snprintf(path, 128, "support9995/lit%ub.s", i);
        fp = fopen(path, "w");
        if (fp == NULL) {
            perror(path);
            exit(1);
        }
        fprintf(fp, "\t\t.export __litb_%u\n\t.data\n\n", i);
        fprintf(fp, "__litb_%u:\n\t.byte %u\n", i, i);
        fclose(fp);
    }
    return 0;
}

        