@* The |count| program.
|count| print byte and newline counts for input.

@c
#include "meta.h"
@#
int
main(int argc, char *argv[])
{
	@<handle input@>;
	@<output counts@>;
}

@ Need two variables to store counts. 
@<handle input@>=
int nc, nl;
nc = nl = 0;
@<loop for each characters@>;

@ @<loop for each characters@>=
char c;
while ((c = getchar()) != EOF) {
	nc++;
	if (c == '\n') {
		nl++;
	}
}

@ @<output counts@>=
printf("%d %d\n", nc, nl);

