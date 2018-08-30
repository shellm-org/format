BINDIR := bin
LIBDIR := lib
MANDIR := man
WIKIDIR := wiki

SCRIPTS := $(sort $(shell cd $(BINDIR) && ls))
LIBRARIES := $(sort $(shell cd $(LIBDIR) && ls))

MANPAGES := $(addprefix $(MANDIR)/,$(addsuffix .1,$(SCRIPTS)) $(addsuffix .3,$(LIBRARIES)))
WIKIPAGES := $(addprefix $(WIKIDIR)/,$(addsuffix .md,$(SCRIPTS)) $(addsuffix .md,$(LIBRARIES)))

ifeq ($(PREFIX), )
PREFIX := /usr/local
endif

all: doc

install:
	./install.sh $(PREFIX)

$(MANDIR)/%.1: $(BINDIR)/%
	shellman -tmanpage $< -o $@

$(MANDIR)/%.sh.3: $(LIBDIR)/%.sh
	shellman -tmanpage $< -o $@

$(WIKIDIR)/home.md: templates/wiki_home.md $(BINDIR) $(LIBDIR)
	shellman -tpath:$< -o $@ \
	  --context project=format \
	            scripts="$(SCRIPTS)" \
	            libraries="$(LIBRARIES)"

$(WIKIDIR)/_sidebar.md: templates/wiki_sidebar.md $(BINDIR) $(LIBDIR)
	shellman -tpath:$< -o $@ \
	  --context project=format \
	            scripts="$(SCRIPTS)" \
	            libraries="$(LIBRARIES)"

$(WIKIDIR)/%.md: $(BINDIR)/%
	shellman -twikipage $< -o $@

$(WIKIDIR)/%.sh.md: $(LIBDIR)/%.sh
	shellman -twikipage $< -o $@

man: $(MANPAGES)

wiki: $(WIKIPAGES) $(WIKIDIR)/home.md $(WIKIDIR)/_sidebar.md

doc: man wiki
