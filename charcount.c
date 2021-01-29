#include "include/meta.h"

int
main(int argc, char *argv[])
{
	int c, nc = 0;

	while ((c = getchar()) != EOF) {
		nc++;
	}

	printf("%d\n", nc);

	return 0;
}

