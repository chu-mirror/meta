#include "include/meta.h"
#include "include/errorf.h"

#define MARGIN1 2
#define MARGIN2 2
#define BOTTOM 64
#define PAGELEN 66

void print(char* name, FILE* in);
void skip(int n);
void print_head(char *name, int pageno);

int
main(int argc, char *argv[])
{
	int i;

	if (argc == 1) {
		print("STDIN", stdin);
		return 0;
	}

	for (i = 1; i < argc; ++i) {
		FILE* f;

		f = fopen(argv[i], "r");
		if (f == NULL) {
			err_sys("Failed at opening %s", argv[i]);
		}
		print(argv[i], f);
		fclose(f);
	}
}

void 
print(char* name, FILE* in)
{
	int lineno, pageno;
	char *line = NULL;
	int n = 0, read;

	pageno = 1;

	print_head(name, pageno);
	lineno = MARGIN1 + MARGIN2 + 1;

	while ((read = getline(&line, &n, in)) != -1) {
		if (lineno == 0) {
			pageno++;
			print_head(name, pageno);
			lineno = MARGIN1 + MARGIN2 + 1;
		}
		fputs(line, stdout);
		lineno++;
		if (lineno >= BOTTOM) {
			skip(PAGELEN-lineno);
			lineno = 0;
		}
	}
	if (lineno > 0) {
		skip(PAGELEN-lineno);
	}
}

void 
print_head(char *name, int pageno)
{
	skip(MARGIN1);
	printf("%s Page %d\n", name, pageno);
	skip(MARGIN2);
}

void 
skip(int n)
{
	while(n--) {
		printf("\n");
	}
}

