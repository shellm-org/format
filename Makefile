.PHONY: rmdoc

BINDIR := bin
LIBDIR := lib
MANDIR := man
WIKIDIR := wiki

MANPAGES := $(addprefix $(MANDIR)/,format.sh.3)
WIKIPAGES := $(addprefix $(WIKIDIR)/,Library/format.sh.md)

ifeq ($(PREFIX), )
PREFIX := /usr/local
endif

all: doc

install:
	@./install.sh $(PREFIX)

$(MANDIR)/%.1: $(BINDIR)/%
	@shellman -tmanpage $< -o $@

$(MANDIR)/%.sh.3: $(LIBDIR)/%.sh
	@shellman -tmanpage $< -o $@

$(WIKIDIR)/Scripts/%.md: $(BINDIR)/%
	@shellman -twikipage $< -o $@

$(WIKIDIR)/Library/%.sh.md: $(LIBDIR)/%.sh
	@shellman -twikipage $< -o $@

man: $(MANPAGES)

wiki: $(WIKIPAGES)

doc: man wiki

rmdoc:
	@rm man/* wiki/Scripts/* wiki/Library/*
