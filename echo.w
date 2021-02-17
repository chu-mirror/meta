@* The |echo| program.
Just print all arguments.

@c
@<refs@>@;

int
main(int argc, char *argv[])
{
	@<loop to output@>;
}

@ Do not output the tailing blank.
@<loop to output@>=
int i;
for (i = 1; i < argc - 1; i++) {
	printf("%s ", argv[i]);
}
puts(argv[argc-1]);

@ @<refs@>=
#include <stdio.h>@;

