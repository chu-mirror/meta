@* The |concat| program.
|concat| writes contents of each of its file arguments to output.
If no file argument, copy from input to output.

@c
@<refs@>@;
int
main(int argc, char *argv[])
{
	@<parse the command line@>;
	@<output each files@>;
}

@ There are two cases, depend on whether file arguments have been given.
Should initialize a list at first.
@<parse the command line@>=
List fl; init(&fl);
if (argc == 1) {
	@<collect |stdin|@>;
} else {
	@<collect each files@>;
}

@ Use a list to collect files.
@<refs@>=
#include <stdio.h>@;
typedef struct Node{
	FILE *f;
	struct Node *next;
} Node;
typedef struct List{
	Node *head;
	Node *tail;
} List;
void push(FILE *f, List *fl);
void init(List *fl);

@ @c
void
push(FILE *f, List *fl)
{
	fl->tail->next = (Node*)malloc(sizeof(Node));
	fl->tail = fl->tail->next;
	fl->tail->f = f;
}

void init(List *fl)
{
	fl->head = (Node *)malloc(sizeof(Node));
	fl->tail = fl->head;
}

@ @<refs@>=
#include <stdlib.h>@;

@ Complete parsing.
@<collect |stdin|@>=
push(stdin, &fl);

@ Use a loop to collect file arguments, some errors might happen,
it's better to deal with them. Use \.{errorf} lib.
@<refs@>=
#include "errorf.h"@;

@ When file is specified by |-|, use standard input instead.
@<collect each files@>=
int i;
for (i = 1; i < argc; ++i) {
	FILE* f;

	if (strcmp(argv[i], "-"))
		f = fopen(argv[i], "r");
	else
		f = stdin;
	
	if (f == NULL) {
		err_sys("Failed at opening %s", argv[i]);
	}

	push(f, &fl);
}
@ @<refs@>=
#include <string.h>@;

@ It's time to output them.
@<output each files@>=
Node *np = fl.head;
while (np != fl.tail) {
	@<output file@>;

	np = np->next;
}

@ Procedure |copy|, which defined in \.{cpy.w} may help a lot.
@<refs@>=
#include "copy.h"@;

@ @<output file@>=
copy(np->next->f, stdout);

