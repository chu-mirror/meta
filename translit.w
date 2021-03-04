@** The |translit| program.
One class of filters {\it transliterates} certain characters
on their way through,
passing all other characters unmodfied.
Here is a program |translit|, so that we can write 
{\tt
\par
translit x y
\par}
and have all occurrences of {\tt x} in the standard input
be replaced by {\tt y} on the standard output.
Multiple translations are also handy:
{\tt
\par
translit xyz XYZ
\par}
would change all lower case x, y and z to the corresponding upper case letter.
It would be nice to have shorthand for alphabets, so
{\tt
\par
translit a-z A-Z
\par}
would translate all lower case letters to upper case.
`{\tt -}' can be used as usual characters by preceding a backslash.
{\tt
\par
translit \char`\\- \char`\~
\par}
would change all `{\tt -}' to `{\tt \char`\~}'.
If two sets' length are not equal,
the after is extended by repeating its last character.
{\tt
\par
translit a-z X
\par}
would translate all lower case letters to {\tt X}.

@c
@<refs in global@>@;

int
main(int argc, char *argv[])
{
	@<refs in main@>@;
	@<process arguments@>@;
	@<handle input@>@;
}

@* Tranliterating one of the characters.
This is the core function of |translit|, 
its implementation indicate the rest of program.
I use a hash table here, named |toset|.
@<translate character |c| to |cc|@>=
char cc;
cc = toset[c];

@ The hash table are constructed in |@<process arguments@>|.
@<refs in main@>=
char *toset;

@* The remaining part.
@<handle input@>=
char c;
while ((c = getchar()) != EOF) {
	@<translate character...@>;
	putchar(cc);
}

@ @<refs in global@>=
#include <stdio.h> 

@ @<process arguments@>=
@<check errors in arguments@>@;
@<construct |toset|@>

@ @<check errors...@>=
if (argc != 3) {
	err_quit("usage: translit from to");
}
@ @<refs in global@>=
#include "errorf.h"

@ @<construct |toset|@>=
@<initialize |toset|@>@;
@<analyze arguments@>@;

@ @<initialize |toset|@>=
toset = malloc(UCHAR_MAX + 1);
int i;
for (i = 0; i <= UCHAR_MAX; i++) {
	toset[i] = i;
}

@ @<refs in global@>=
#include <limits.h>
#include <stdlib.h> 

@ @<analyze arguments@>=
char *pcf, *pct; 
pcf = argv[1];
pct = argv[2];
while (*pcf) {
	@<parse |pcf|@>@;
	@<parse |pct|@>@;
	toset[*pcf++] = *pct++;
}

@ @<parse |pcf|@>=
switch (*pcf) {
case '-':
	if (*(pcf-1) < *(pcf+1)) {
		pcf--;
		(*pcf)++;
	} else {
		pcf++;
	}
	break;
case '\\':
	pcf++;
	break;
}

@ @<parse |pct|@>=
switch (*pct) {
case '-':
	if (*(pct-1) < *(pct+1)) {
		pct--;
		(*pct)++;
	} else {
		pct++;
	}
	break;
case '\\':
	pct++;
	break;
case '\0':
	pct--;
	break;
}


