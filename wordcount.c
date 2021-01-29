#include <stdio.h>

int
main(int argc, char *argv[])
{
	int c, nw = 0, inword = 0;
	while ((c = getchar()) != EOF) {
		if (c == '\t' || c == ' ' || c == '\n') {
			inword = 0;
		} else {
			if (!inword) {
				nw++;
			}
			inword = 1;
		}
	}
	printf("%d\n", nw);
	return 0;
}
