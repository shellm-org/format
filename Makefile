.PHONY := help
.DEFAULT_GOAL := help

BINDIR := bin
LIBDIR := lib
MANDIR := man
WIKIDIR := wiki

LIBRARIES := $(sort $(shell cd $(LIBDIR) && ls))

MANPAGES := $(addprefix $(MANDIR)/,$(addsuffix .1,$(SCRIPTS)) $(addsuffix .3,$(LIBRARIES)))
WIKIPAGES := $(addprefix $(WIKIDIR)/,$(addsuffix .md,$(SCRIPTS)) $(addsuffix .md,$(LIBRARIES)))

all: check-quality test ## Run quality and unit tests.

$(MANDIR)/%.sh.3: $(LIBDIR)/%.sh
	shellman -tmanpage $< -o $@

$(WIKIDIR)/home.md: templates/wiki_home.md $(LIBDIR)
	shellman -tpath:$< -o $@ \
	  --context libraries="$(LIBRARIES)"

$(WIKIDIR)/_sidebar.md: templates/wiki_sidebar.md $(LIBDIR)
	shellman -tpath:$< -o $@ \
	  --context libraries="$(LIBRARIES)"

$(WIKIDIR)/%.sh.md: $(LIBDIR)/%.sh
	shellman -twikipage $< -o $@

man: $(MANPAGES) ## Generate man pages.

wiki: $(WIKIPAGES) $(WIKIDIR)/home.md $(WIKIDIR)/_sidebar.md ## Generate wiki pages.

doc: man wiki ## Generate man pages and wiki pages.

readme: templates/readme* .shellman.json ## Generate the README.
	shellman -tpath:templates/readme.md -o README.md

check-style: ## Run the style tests.
	bats tests/quality/test_shellcheck.bats

check-documentation: ## Run the documentation tests.
	bats tests/quality/test_shellman.bats

check-compatibility: ## Run the compatibility tests.
	bats tests/quality/test_compatibility.bats

check-quality: ## Run the quality tests.
	bats tests/quality/*.bats

test: ## Run the unit tests.
	bats tests/*.bats

help: ## Print this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
