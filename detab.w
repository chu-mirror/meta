@* The |detab| program.
|detab| copies its input to output, expand tabs to spaces.

@c
#include "meta.h"

int
main(int argc, char *argv[])
{
	@<handle input@>;
}

@ Tab stops are assumed to be every four collums.
@d
TABSIZE 4

@ Use a loop for each charaters.
Two variebles, |c|, and |n|, to record status.

@<handle...@>=
char c;
int n;

@<loop for each characters@>;

@ @<loop for...@>=
while ((c = getchar()) != EOF) {
	switch(c) {
	case '\t': @;
		@<expand tab@>;
		break;
	case '\n': @;
		putchar(c);
		n = 0;
		break;
	default: @;
		putchar(c);
		n++;
		break;
	}
}

@ @<expand tab@>=
do {
	putchar(' ');
	n++;
} while (n % TABSIZE);

