SHELL := bash

ENGINE ?= pdflatex
LATEXMK := latexmk
OUTROOT := build
ROOTDIR := .

# Поиск резюме и писем (резюме в корне, письма в директории letters/)
CV_TEX := $(wildcard cv-*.tex)
LETTER_TEX := $(wildcard letters/*.tex)
ALL_TEX := $(CV_TEX) $(LETTER_TEX)

# Имена целей (cv-cve, letters/ozon-ml-ds и т.д.)
TARGETS := $(ALL_TEX:.tex=)

# Add local directories to TEXINPUTS (supports root and letters/ compilation)
export TEXINPUTS := .:images:preamble:../preamble:../images:

.DEFAULT_GOAL := all

.PHONY: all clean cleandist distclean all_dirs letters cv $(TARGETS)

all: $(TARGETS)

letters: $(LETTER_TEX:.tex=)

cv: $(CV_TEX:.tex=)

all_dirs:
	@for target in $(TARGETS); do \
		mkdir -p $(OUTROOT)/$$(dirname $$target) ; \
	done

# Универсальное правило для сборки любого .tex файла
$(TARGETS): %: all_dirs
	@mkdir -p $(OUTROOT)/$@
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=$$(basename $@) -outdir=$(OUTROOT)/$@ $@.tex
	@mkdir -p $$(dirname $@.pdf)
	@cp $(OUTROOT)/$@/$$(basename $@).pdf $@.pdf

clean:
	@for target in $(TARGETS); do \
		$(LATEXMK) -C -outdir=$(OUTROOT)/$$target || true ; \
	done
	@find $(OUTROOT) -type f ! -name '*.pdf' -delete 2>/dev/null || true

cleandist: clean
	@rm -rf $(OUTROOT)
	@rm -f $(ALL_TEX:.tex=.pdf)

distclean: cleandist
