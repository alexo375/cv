SHELL := /bin/bash

ENGINE ?= pdflatex
LATEXMK := latexmk
OUTROOT := build
ROOTDIR := .

CV_CVE_MAIN := cv-cve.tex
CV_MLE_MAIN := cv-mle.tex
CV_MLOPS_MAIN := cv-mlops.tex
CV_RECSYS_MAIN := cv-recsys.tex
LETTER_MAIN := letter.tex

CV_CVE_PDF := cv-cve.pdf
CV_MLE_PDF := cv-mle.pdf
CV_MLOPS_PDF := cv-mlops.pdf
CV_RECSYS_PDF := cv-recsys.pdf
LETTER_PDF := letter.pdf

# Add the local images folder to TEXINPUTS.
# The trailing colon ensures the default LaTeX search paths are appended.
export TEXINPUTS := .:images:

.DEFAULT_GOAL := all

.PHONY: all cv-cve cv-mle cv-mlops cv-recsys letter clean cleandist distclean all_dirs

all: cv-cve cv-mle cv-mlops cv-recsys letter

all_dirs:
	@mkdir -p $(OUTROOT)/cv-cve $(OUTROOT)/cv-mle $(OUTROOT)/cv-mlops $(OUTROOT)/cv-recsys $(OUTROOT)/letter

cv-cve: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=cv-cve -outdir=$(OUTROOT)/cv-cve $(CV_CVE_MAIN)
	@cp $(OUTROOT)/cv-cve/cv-cve.pdf $(ROOTDIR)/$(CV_CVE_PDF)

cv-mle: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=cv-mle -outdir=$(OUTROOT)/cv-mle $(CV_MLE_MAIN)
	@cp $(OUTROOT)/cv-mle/cv-mle.pdf $(ROOTDIR)/$(CV_MLE_PDF)

cv-mlops: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=cv-mlops -outdir=$(OUTROOT)/cv-mlops $(CV_MLOPS_MAIN)
	@cp $(OUTROOT)/cv-mlops/cv-mlops.pdf $(ROOTDIR)/$(CV_MLOPS_PDF)

cv-recsys: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=cv-recsys -outdir=$(OUTROOT)/cv-recsys $(CV_RECSYS_MAIN)
	@cp $(OUTROOT)/cv-recsys/cv-recsys.pdf $(ROOTDIR)/$(CV_RECSYS_PDF)

letter: all_dirs
	ENGINE=$(ENGINE) $(LATEXMK) -r latexmkrc -jobname=letter -outdir=$(OUTROOT)/letter $(LETTER_MAIN)
	@cp $(OUTROOT)/letter/letter.pdf $(ROOTDIR)/$(LETTER_PDF)

clean:
	$(LATEXMK) -C -outdir=$(OUTROOT)/cv-cve || true
	$(LATEXMK) -C -outdir=$(OUTROOT)/cv-mle || true
	$(LATEXMK) -C -outdir=$(OUTROOT)/cv-mlops || true
	$(LATEXMK) -C -outdir=$(OUTROOT)/cv-recsys || true
	$(LATEXMK) -C -outdir=$(OUTROOT)/letter || true
	@find $(OUTROOT) -type f ! -name '*.pdf' -delete 2>/devnull || true

cleandist: clean
	@rm -rf $(OUTROOT)
	@rm -f $(CV_CVE_PDF) $(CV_MLE_PDF) $(CV_MLOPS_PDF) $(CV_RECSYS_PDF) $(LETTER_PDF)

distclean: cleandist
