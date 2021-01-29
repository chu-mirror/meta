#include "include/meta.h"
#include "include/errorf.h"

void copy(FILE* in, FILE* out);

int
main(int argc, char *argv[])
{
	FILE *fi, *fo;

	if (argc != 3) {
		err_quit("usege: makecopy old new");
	}

	fi = fopen(argv[1], "r");
	fo = fopen(argv[2], "w");

	copy(fi, fo);

	fclose(fi);
	fclose(fo);

}

void
copy(FILE* in, FILE *out)
{
	char c;

	while((c = fgetc(in)) != EOF) {
		putc(c, out);
	}
}

