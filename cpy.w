@* The |cpy| program.
It does nothing but copying from its input to output.

@c
@<refs@>@;
@<defs@>@;

int
main(int argc, char *argv[])
{
	@<copy from |stdin| to |stdout|@>;
	return 0;
}

@ I want to write a procedure |copy| to perform this task.
It's a simple procedure, the only difficulty is definition of
input and output.
Are they something defined in global scope? 
So that we do not have to specify them in the interface of |copy|.
Or something localized to scope of procedure?
A functional programming approach!
I adopt the second, it doesn't make any sense in such a short program though.

@ So that |@<copy from |std...@>| can be defined.
@<copy from |std...@>=
copy(stdin, stdout);

@ It would be convenient if procedure |copy| could be viewed from other programs.
@<refs@>=
#include "copy.h"@;

@ @<defs@>=
@<object@>@;

@ Specify input and output in procedure |copy|,
I use |FILE *| type for them.
@<object@>=
int
copy(FILE *input, FILE *output)
{
	@<copy from |input| to |output|@>;

	return 0;
}
@ @<header@>=
#include <stdio.h>@;
int copy(FILE *input, FILE *output);

@ The major part performming the copying can be done
by a loop together with |getc| and |putc|.
@<copy from |in...@>=
char c;
while((c = getc(input)) != EOF) {
	putc(c, output);
}

@ Extract useful imformations for others.
@(copy.h@>=
#ifndef __CHU_COPY__
#define __CHU_COPY__
@<header@>
#endif

@ @(copy.c@>=
@<refs@>@;
@<object@>@;

