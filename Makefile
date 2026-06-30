SHELL := /bin/bash

ENGINE ?= pdflatex
LATEXMK := latexmk
OUTROOT := build
ROOTDIR := .

CV_MAIN := cv.tex
LETTER_MAIN := letter.tex

CV_PDF := cv.pdf
LETTER_PDF := letter.pdf

# Add the local images folder to TEXINPUTS.
# The trailing colon ensures the default LaTeX search paths are appended.
export TEXINPUTS := .:images:

.DEFAULT_GOAL := all

.PHONY: all cv letter clean cleandist distclean all_dirs

all: cv letter

all_dirs:
	@mkdir -p $(OUTROOT)/cv $(OUTROOT)/letter

cv: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=cv -outdir=$(OUTROOT)/cv $(CV_MAIN)
	@cp $(OUTROOT)/cv/cv.pdf $(ROOTDIR)/$(CV_PDF)

letter: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=letter -outdir=$(OUTROOT)/letter $(LETTER_MAIN)
	@cp $(OUTROOT)/letter/letter.pdf $(ROOTDIR)/$(LETTER_PDF)

clean:
	$(LATEXMK) -C -outdir=$(OUTROOT)/cv || true
	$(LATEXMK) -C -outdir=$(OUTROOT)/letter || true
	@find $(OUTROOT) -type f ! -name '*.pdf' -delete 2>/dev/null || true

cleandist: clean
	@rm -rf $(OUTROOT)
	@rm -f $(CV_PDF) $(LETTER_PDF)

distclean: cleandist
