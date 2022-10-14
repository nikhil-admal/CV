#**************************************************************************
#**************************************************************************

CIT:=$(shell kpsewhich citations.bib)
JOR:=$(shell kpsewhich journals.full.bib)
CVP:=$(shell kpsewhich cv.sty)
CVC:=$(shell kpsewhich cv.cls)
CVB:=$(shell kpsewhich cv.bst)
TECH:=$(shell kpsewhich techpresents.bib)

all:	sample.ps

%.ps:	$(basename %).tex $(CVP) $(CVC) $(CVB) $(TECH) $(CIT) $(JOR) Makefile
			latex $(basename $@).tex
			if [ -e bu1.aux ]; then bibtex bu1; fi
			if [ -e bu2.aux ]; then bibtex bu2; fi
			if [ -e bu3.aux ]; then bibtex bu3; fi
			if [ -e bu4.aux ]; then bibtex bu4; fi
			if [ -e bu5.aux ]; then bibtex bu5; fi
			if [ -e bu6.aux ]; then bibtex bu6; fi
			if [ -e bu7.aux ]; then bibtex bu7; fi
			latex $(basename $@).tex
			latex $(basename $@).tex
			dvips -K -t letter $(basename $@).dvi
			ps2pdf $@
			%rm -f *.aux *.bbl *.blg *.dvi *.log

.PHONY:			clean

clean:
			rm -f *.~ *.aux *.dvi *.log *.bbl *.blg *.ps \
			sample.pdf
