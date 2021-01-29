#include <stdio.h>
#include <stdlib.h> 
#include <sys/queue.h>

#define DEBUG

/*
The queue interface
*/
void init_queue();
void push_back(char *line);
void pop_front();
char* front();
int empty();

int
main(int argc, char *argv[])
{
	char *line = NULL;
	int n = 0, n_print, size_queue = 0;

	n_print = atoi(argv[1]);

	init_queue();

	while (getline(&line, &n, stdin) > 0) {
		if (n_print == size_queue) {
			pop_front();
			size_queue--;
		}
		push_back(line);
		line = NULL;
		n = 0;
		size_queue++;
	}

	while (!empty()) {
		printf("%s", front());
		pop_front();
	}
	return 0;
}

STAILQ_HEAD(stailhead, entry) head = 
	STAILQ_HEAD_INITIALIZER(head);
struct stailhead *headp;

struct entry {
	STAILQ_ENTRY(entry) entries;
	char *line;
} *e;

void
init_queue()
{
	STAILQ_INIT(&head);
}
int
empty()
{
	return STAILQ_EMPTY(&head);
}

void
push_back(char *line)
{
	e = malloc(sizeof(struct entry));
	e->line = line;
	STAILQ_INSERT_TAIL(&head, e, entries);
}

void
pop_front()
{
	e = STAILQ_FIRST(&head);
	STAILQ_REMOVE_HEAD(&head, entries);
	free(e->line);
	free(e);
}

char*
front()
{
	e = STAILQ_FIRST(&head);
	return e->line;
}

