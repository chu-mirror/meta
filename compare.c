#include <stdio.h>
#include <string.h>

void diffmsg(int, char* ,char*);

int
main(int argc, char *argv[])
{
	FILE *f1, *f2;
	char *line1 = NULL, *line2 = NULL;
	int n1 = 0, n2 = 0;
	int lineno = 0;
	int read1, read2;

	if (argc == 2) {
		f1 = stdin;
		f2 = fopen(argv[1], "r");
	} else {
		f1 = fopen(argv[1], "r");
		f2 = fopen(argv[2], "r");
	}

	do{
		read1 = getline(&line1, &n1, f1);
		read2 = getline(&line2, &n2, f2);
		lineno++;
		if (read1 != -1 && read2 != -1 && strcmp(line1, line2) != 0) {
			diffmsg(lineno, line1, line2);
		}
	} while (read1 != -1 && read2 != -1);

	if (read1 == -1 && read2 != -1) {
		printf("End of file on %s\n", argv[1]);
	} else if (read1 != -1 && read2 == -1) {
		printf("End of file on %s\n", argv[2]);
	}

	fclose(f1);
	fclose(f2);

	return 0;
}

void
diffmsg(int lineno, char* line1, char* line2)
{
	printf("Line %d:\n- %s+ %s", lineno, line1, line2);
}

