@* The |makecopy| program.
@ |makecopy| copies the file old
to a new instance of the file 
if new already exists
it is truncated and rewriten,
otherwise it is made to exist.
The new file is an exact replication
of the old.

@c
@<refs@>@;

int
main(int argc, char *argv[])
{
	@<handle arguments, get |fi| and |fo|@>;
	@<copy |fi| to |fo|@>;
}

@ @<handle arguments...@>=
if (argc != 3) {
	err_quit("usage: makecopy old new");
}

FILE *fi, *fo;
fi = fopen(argv[1], "r");
fo = fopen(argv[2], "w");

if (fi == NULL || fo == NULL) {
	err_sys("fopen:");
}
@ @<refs@>=
#include "errorf.h"@;

@ Use |copy| defined in cpy.w
@<refs@>=
#include "copy.h"

@ @<copy |fi|...@>=
copy(fi, fo);

