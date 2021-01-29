#include <stdio.h>

#define TABSIZE 4

int
main(int argc, char *argv[])
{
	int col = 1, c;

	do {
		int n_blank = 0;
		while ((c = getchar()) == ' ') {
			n_blank++, col++;
			if (col % TABSIZE == 0) {
				n_blank = 0;
				putchar('\t');
			}
		}
		while(n_blank--) putchar(' ');
	
		if (c != EOF) {
			putchar(c);
			if (c == '\n') {
				col = 0;
			} else {
				col++;
			}
		}
	} while (c != EOF);

	return 0;
}
