#include <string.h>
#include <sys/types.h>

#include "include/meta.h"
#include "include/errorf.h"

int expand_set(char** chrsetp);

int
main(int argc, char *argv[])
{
	int c, allbut = 0;
	char *fromset, *toset;
	size_t size_from, size_to;

	if (argc != 3) {
		err_quit("usage: translit from to");
	}

	fromset = argv[1];
	toset = argv[2];

	if (fromset[0] == '^') {
		fromset++;
		allbut = !allbut;
	}

	size_from = expand_set(&fromset);
	size_to = expand_set(&toset);
	if (size_from == -1 || size_to == -1) {
		err_quit("There's something wrong with arguments");
	}

	while ((c = getchar()) != EOF) {
		char* pc_t;

		pc_t = strchr(fromset, c);
		if (allbut) {
			pc_t = pc_t ? NULL : fromset + size_from;
		}
		if (pc_t != NULL) {
			int index = pc_t - fromset >= size_to? size_to - 1 : pc_t -fromset;
			if (toset[index] != '\b')
				putchar(toset[index]);

		} else {
			putchar(c);
		}
	}
}

int
expand_set(char** chrsetp)
{
	char *dash_pos, *newset;
	char *chrset = *chrsetp;
	char *pc_i, *pc_j;
	int newsize;

	newsize = strlen(chrset);
	newset = malloc(newsize);
	if (newset == NULL) {
		return -1;
	}

	pc_i = chrset;
	pc_j = newset;
	while (*pc_i != '\0') {
		if (*pc_i == '\\') {
			switch (*++pc_i) {
				case 'n' :
					*pc_j++ = '\n';
					break;
				case 'd' :
					*pc_j++ = '\b';
					break;
				case 't' :
					*pc_j++ = '\t';
					break;
				default:
					*pc_j++ = *pc_i;
			}
		} else if (*pc_i == '-') {
			char tc = pc_i[-1];
			int j = pc_j - newset;

			newset = realloc(newset, newsize += pc_i[1] - pc_i[-1]);
			if (newset == NULL) {
				return -1;
			}
			pc_j = newset + j;
			while (++tc != pc_i[1]) {
				*pc_j++ = tc;
			}
		} else {
			*pc_j++ = *pc_i;
		}
		pc_i++;
	}
	*pc_j = '\0';

	*chrsetp = newset;
	return strlen(newset);
}

