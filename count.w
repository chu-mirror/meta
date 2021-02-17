@* The |count| program.
|count| print byte , word, and newline counts for input.

@c
@<refs@>@;
int
main(int argc, char *argv[])
{
	@<handle input@>;
	@<output counts@>;
}

@ Need three variables to store counts, 
and one more to record current status to count words.
@<handle input@>=
int nc, nw, nl, inword;
nc = nl = nw = 0;
inword = 0;
@<loop for each characters@>;

@ @<loop for each characters@>=
char c;
while ((c = getchar()) != EOF) {
	@<whether to increase |nc|@>;
	@<whether to increase |nw|@>;
	@<whether to increase |nl|@>;
}
@ @<refs@>=
#include <stdio.h>@;

@ @<whether to increase |nc|@>=
nc++;

@ Assume that all words are delimited by blanks,
tabs, newlines.
@<whether to increase |nw|@>=
if (c == ' ' || c == '\t' || c == '\n') {
	inword = 0;
} else {
	if (inword == 0) {
		nw++;
	}
	inword = 1;
}
@ @<whether to increase |nl|@>=
if (c == '\n') {
	nl++;
}

@ @<output counts@>=
printf("%d %d %d\n", nl, nw, nc);

