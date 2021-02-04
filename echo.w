@* The |echo| program.
Just print all arguments.

@c
#include "meta.h"
@#

int
main(int argc, char *argv[])
{
	@<loop to output@>;
}

@ @<loop to output@>=
int i;
for (i = 1; i < argc - 1; i++) {
	printf("%s ", argv[1]);
}
puts(argv[argc-1]);
