\centerline{\bf Hello world!}
\smallskip

@ 
This document is wrote for
a brief introduction of
Donald~E. Knuth's literate programming.
Choose the classic {\it Hello world\/}
as example.
@c
@<Hello World!@>
@ The basic skeleton of a C program consists of
two parts, {\it reference}, and {\it definition}.
The {\it reference\/} contains all the links
to the definition of the words,
the words used by following {\it definition\/} part.
The {\it definition} contains all the definition
of the words that defined in this file.

@<Hello World!@>=
	@<reference@>@;
	@<definition@>@;

@ The ultimate goal of writing a C program is
basicly the definition of new words.
And in this example, which is a executable program,
as you would guess,
the new word is |main|.

@<defi...@>=
@<def main@>

@ Now turn to the definition of |main| function.
All need to do is merely printing a line of text
to show my gratitude to this beautiful world.

@<def main@>=
int
main()
{
	@<say hello@>;
	
	return 0;
}

@ So, how do I print the words out?
Maybe confirming what I want to say is the first.
I should confess that the meaning of
reference and definition is mixed up here,
but this is the natural way of building a C program.

@<reference@>=
const char* hello = "Hello, world!";

@ Finally, I need to find a function given by
operating system, or standard library,
or even other people's clever idea(meaning private library).
I use standard library here.

@<reference@>=
#include <stdio.h>

@ Pick up the correct function used by here.

@<say hello@>=
{
	puts(hello);
}
@ So, all the words have been difined, now, run it.

\indent{\tt 
Hello, world!
}

The text just displayed is copied from
output of the program compiled directly from this document.

@ {\bf Ending}
The sequence of all these considerations actually
happened when we be writing even such a simple program.
But the source code we have met from others usually can
not convey all these information. 
We read others' source code using our experience 
abtained from classroom, textbooks, others' advices, etc.
But not everyone has a chance of being well educated, 
so here the point.

It's not the best solution for all programming activities,
but one should be conscious of,
for your own benefit.

