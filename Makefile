
ALL = compare \
incld print \
tail translit wordcount 

LITE = makecopy echo hello find cpy concat count
SUB = copy errorf

HDR = $(SUB:=.h)
OBJ = $(ALL:=.o) $(SUB:=.o) $(LITE:=.o)

WEAVE = cweave
TANGLE = ctangle

CFLAGS = -g

.SUFFIXES: 
.SUFFIXES: .c .o .w .tex .pdf
.o: ; $(CC) $(CFLAGS) -o $@ $<
.tex.pdf: ; pdftex $<
.w.tex: ; $(WEAVE) $<
.w.c: ; $(TANGLE) $<

all: $(ALL) $(LITE)

$(OBJ): meta.h

clean: clean-lite
	@rm -f $(ALL) $(OBJ)

clean-lite:
	@rm -f $(LITE:=.tex) $(LITE:=.c)\
		$(LITE:=.log) $(LITE:=.idx)\
		$(LITE:=.toc) $(LITE:=.scn)\
		$(LITE:=.pdf) $(LITE)


concat: concat.o errorf.o copy.o
	$(CC) $(CFLAGS) -o $@ concat.o errorf.o copy.o

concat.o: copy.h

incld: incld.o errorf.o
	$(CC) -o $@ incld.o errorf.o

makecopy: makecopy.o errorf.o copy.o
	$(CC) -o $@ makecopy.o errorf.o copy.o

makecopy.o: copy.h errorf.h

print: print.o errorf.o
	$(CC) -o $@ print.o errorf.o

translit: translit.o errorf.o
	$(CC) -o $@ translit.o errorf.o

copy.c copy.h: cpy.w
	$(TANGLE) cpy.w 

