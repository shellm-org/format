.PHONY: rmdoc

BINDIR := bin
LIBDIR := lib
MANDIR := man
WIKIDIR := wiki

MANPAGES := $(addprefix $(MANDIR)/,format.sh.3)
WIKIPAGES := $(addprefix $(WIKIDIR)/,lib/format.sh.md)

ifeq ($(PREFIX), )
PREFIX := /usr/local
endif

all : doc

install :
	@./install.sh $(PREFIX)

$(MANDIR)/%.1 : $(BINDIR)/%
	@shellman --format man $< > $@

$(MANDIR)/%.sh.3 : $(LIBDIR)/%.sh
	@shellman --format man $< > $@

$(WIKIDIR)/bin/%.md : $(BINDIR)/%
	@shellman --format markdown $< > $@

$(WIKIDIR)/lib/%.sh.md : $(LIBDIR)/%.sh
	@shellman --format markdown $< > $@

man : $(MANPAGES)

wiki : $(WIKIPAGES)

doc : man wiki

rmdoc:
	@rm man/* wiki/bin/* wiki/lib/*
