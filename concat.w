@* The |concat| program.
|concat| writes contents of each of its file arguments to output.
If no file argument, copy from input to output.

@c
#include "meta.h"@;
@<refs@>@;

int
main(int argc, char *argv[])
{
	@<main: locals@>;
	@<parse the command line@>;
	@<output each files@>;
}

@ There are two cases, depend on whether file arguments have been given.
@<parse the command line@>=
if (argc == 1) {
	@<collect |stdin|@>;
} else {
	@<collect each files@>;
}

@ Use a list to collect files.
@<refs@>=
typedef struct Node{
	FILE *f;
	struct Node *next;
} Node;
typedef struct List{
	Node *head;
	Node *tail;
} List;

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

@ @<main: locals@>=
List fl; init(&fl);

@ Complete parsing.
@<collect |stdin|@>=
push(stdin, &fl);

@ Use a loop to collect file arguments, some errors might happen,
it's better to deal with them. Use \.{errorf} lib.
@<refs@>=
#include "errorf.h"@;

@ @<collect each files@>=
int i;
for (i = 1; i < argc; ++i) {
	FILE* f;

	f = fopen(argv[i], "r");
	if (f == NULL) {
		err_sys("Failed at opening %s", argv[i]);
	}

	push(f, &fl);
}

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

