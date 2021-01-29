#include <stdio.h>

#define TABSIZE 4

int
main(int argc, char *argv[])
{
	int c, n = 0;

	while ((c = getchar()) != EOF) {
		if (c == '\t') {
			do {
				putchar(' ');
			} while ((++n) % TABSIZE != 0);
		} else {
			putchar(c);
			++n;
			if (c == '\n') {
				n = 0;
			}
		}
	}

	return 0;
}

