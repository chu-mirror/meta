#include <stdio.h>
#include <stdlib.h>
#include <string.h> 

typedef char Stat;
#define IN 1
#define OUT 2

char archtemp[] = "artemp";
char archhdr[] = "-h-";

Stat *fstat;
char **files;
int nfiles;
int errcount;

void help();
void update(char* aname, char mode);
void table(char* aname);
void extract(char* aname, char mode);
void delete(char* aname);

void replace(FILE* f1, FILE* f2, char mode);
void addfile(char* name, FILE* fd);
void fcopy(FILE* f1, FILE* f2);
int fsize(FILE* f);

int
main(int argc, char *argv[])
{
	int i, j;

	if (argc < 3) {
		help();
	}

	for (i = 3; i < argc; i++) {
		for (j = i; j < argc; j++) {
			if (strcmp(argv[i], argv[j]) == 0) {
				fprintf(stderr, "%s: duplicate file name\n", argv[i]);
				exit(1);
			}
		}
	}

	fstat = malloc(argc);
	memset(fstat, 0, argc);

	files = &argv[3];
	nfiles = argc - 3;

	if (strlen(argv[1]) != 2 || argv[1][0] != '-') {
		help();
	} else if (argv[1][1] == 'c' || argv[1][1] == 'u') {
		update(argv[2], argv[1][1]);
	} else if (argv[1][1] == 't') {
		table(aname);
	} else if (argv[1][1] == 'x' || argv[1][1] == 'p') {
		extract(aname, argv[1][1]);
	} else if (argv[1][1] == 'd') {
		delete(aname);
	} else {
		help();
	}
}

void 
help()
{
	fprintf(stderr, "usage: archive -[cdptux] archname [files ...]\n");
	exit(1);
}

void 
update(char* aname, char mode)
{
	int i;
	FILE *tfd, *afd;

	afd = fopen(archtemp, "w");
	if (afd == NULL) {
		fprintf(stderr, "Something error with opening temprary file\n");
		exit(1);
	}

	if (mode == 'u') {
		afd = fopen(aname, "r");
		replace(afd, tfd, 'u');
		fclose(afd);
	}
	for (i = 0; i < nfiles; i++) {
		if (fstat[i] == OUT) {
			addfile(fname[i], tfd);
			fstat[i] = IN;
		}
	}
	fclose(tfd);
	if (errcount == 0) {
		rename(archtemp, aname);
	} else {
		fprintf(stderr, "fatal errors - archive not altered");
	}
	remove(archtemp);
}

void 
addfile(char* name, FILE* fd)
{
	FILE *nfd;

	nfd = fopen(name, "r");
	if (nfd == NULL) {
		fprintf(stderr, "%s: can not add\n", name);
		errcount++;
	}
	if (errcount == 0) {
		fprintf(fd, "%s %s %d\n", archhdr, name, fsize(nfd));
		fcopy(nfd, fd);
		close(nfd);
	}
}

void 
fcopy(FILE* f1, FILE* f2)
{
	char c;
	while ((c == fget(f1)) != EOF) {
		fputc(c, f2);
	}
}

int
fsize(FILE* f)
{
	int size = 0;
	while (fgetc(f) != EOF) size++;

	return size;
}

void 
table(char* aname)
{
	FILE *afd;
	char *name;
	int size;

	afd = fopen(aname, "r");
	while (gethdr(afd, &name, &size)) {
		if (filearg(name)) {
			printf("%s:\t%s\n", name, size);
		}
		fseek(afd, size);
	}
}
