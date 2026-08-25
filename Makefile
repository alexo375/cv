SHELL := /bin/bash

ENGINE ?= pdflatex
LATEXMK := latexmk
OUTROOT := build
ROOTDIR := .

# Автоматический поиск всех файлов cv-*.tex и letter*.tex
TEX_FILES := $(wildcard cv-*.tex letter*.tex)
PDF_FILES := $(TEX_FILES:.tex=.pdf)
TARGETS   := $(TEX_FILES:.tex=)

# Add the local images folder to TEXINPUTS.
export TEXINPUTS := .:images:

.DEFAULT_GOAL := all

.PHONY: all clean cleandist distclean all_dirs $(TARGETS)

all: $(TARGETS)

all_dirs:
	@for target in $(TARGETS); do \
		mkdir -p $(OUTROOT)/$$target ; \
	done

# Универсальное правило для сборки любого теха по имени таргета
$(TARGETS): %: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=$@ -outdir=$(OUTROOT)/$@ $@.tex
	@cp $(OUTROOT)/$@/$@.pdf $(ROOTDIR)/$@.pdf

clean:
	@for target in $(TARGETS); do \
		$(LATEXMK) -C -outdir=$(OUTROOT)/$$target || true ; \
	done
	@find $(OUTROOT) -type f ! -name '*.pdf' -delete 2>/devnull || true

cleandist: clean
	@rm -rf $(OUTROOT)
	@rm -f $(PDF_FILES)

distclean: cleandist
