#include <locale.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <wchar.h>

const wchar_t
    TL = L'\x250c',
    TR = L'\x2510',
    BL = L'\x2514',
    BR = L'\x2518',
    TD = L'\x252c',
    BD = L'\x2534',
    MD = L'\x253c',
    ML = L'\x251c',
    MR = L'\x2524',
    RR = L'\x2500',
    CC = L'\x2502';

void help() {
    printf("Usage: cTable [row] [col]\n");
    printf("Prints a ASCII table of row x col dimension.\n");
    printf("\t[row] no of rows\n");
    printf("\t[col] no of columns\n");
    printf("If one value is passed that will be used for both\n");
    printf("row and column. If no value is passed default 4 will be used.\n");
}

int main(int argc, char const *argv[]) {
    if (argc != 1 && argc != 2 && argc != 3) {
        help();
        return -1;
    }
    int row = 0, col = 0;
    if (argc == 1) {
        row = 4;
        col = 4;
    } else if (argc == 2) {
        row = atoi(argv[1]);
        col = row;
    } else {
        row = atoi(argv[1]);
        col = atoi(argv[2]);
    }

    setlocale(LC_ALL, "");

    wchar_t *top = (wchar_t *)malloc(sizeof(wchar_t) * (2 * col + 1 + 1));
    top[0] = TL;
    for (int i = 1; i < 2 * col + 1; i += 2) {
        top[i] = RR;
        top[i + 1] = TD;
    }
    top[2 * col] = TR;
    top[2 * col + 1] = L'\0';
    // wprintf(top);
    // wprintf(L"\n");

    wchar_t *middle = (wchar_t *)malloc(sizeof(wchar_t) * (2 * col + 1 + 1));
    middle[0] = CC;
    for (int i = 1; i < 2 * col + 1; i += 2) {
        middle[i] = L' ';
        middle[i + 1] = CC;
    }
    middle[2 * col] = CC;
    middle[2 * col + 1] = L'\0';
    // wprintf(middle);
    // wprintf(L"\n");

    wchar_t *middle2 = (wchar_t *)malloc(sizeof(wchar_t) * (2 * col + 1 + 1));
    middle2[0] = ML;
    for (int i = 1; i < 2 * col + 1; i += 2) {
        middle2[i] = RR;
        middle2[i + 1] = MD;
    }
    middle2[2 * col] = MR;
    middle2[2 * col + 1] = L'\0';
    // wprintf(middle2);
    // wprintf(L"\n");

    wchar_t *bottom = (wchar_t *)malloc(sizeof(wchar_t) * (2 * col + 1 + 1));
    bottom[0] = BL;
    for (int i = 1; i < 2 * col + 1; i += 2) {
        bottom[i] = RR;
        bottom[i + 1] = BD;
    }
    bottom[2 * col] = BR;
    bottom[2 * col + 1] = L'\0';
    // wprintf(bottom);

    /* real printing */
    wprintf(top);
    wprintf(L"\n");
    // wprintf(middle);
    // wprintf(L"\n");
    row--;
    while (row > 0) {
        wprintf(middle2);
        wprintf(L"\n");
        // wprintf(middle);
        // wprintf(L"\n");
        row--;
    }
    wprintf(bottom);
    wprintf(L"\n");
    return 0;
}
