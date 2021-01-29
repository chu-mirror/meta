#include <string.h>

#include "include/meta.h"
#include "include/errorf.h"

int finclude(FILE* in);

int
main(int argc, char *argv[])
{
	return finclude(stdin);
}

int
finclude(FILE* in)
{
	char *line = NULL;
	int n = 0, read;

	while ((read = getline(&line, &n, in)) != -1) {
		if (strstr(line, "#include") == line) {
			FILE *f;
			char *cp = line, c;
			int i;

			cp += 8;
			while(*cp == ' ' || *cp == '\t') cp++;
			cp++;

			i = 0;
			while(*(cp + i) != '"') i++;
			*(cp + i) = '\0';

			f = fopen(cp, "r");
			if (f == NULL) {
				err_sys("Failed at opening %s", cp);
			}
			if (finclude(f)) {
				return 1;
			}
			fclose(in);
		} else {
			fputs(line, stdout);
		}
	}
	return 0;
}

