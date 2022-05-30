TEX = pdflatex -interaction nonstopmode
BIB = bibtex
DOCKERIMAGE = antiemes/latex:latest


MAINDOCUMENT = hajnal-sisy2022-bolus
BIBFILE = references.bib
FIGURES = $(shell find *.eps *.png *.jpg)

#all: $(MAINDOCUMENT).tex $(FIGURES)
all: $(MAINDOCUMENT).tex $(MAINDOCUMENT).bbl $(FIGURES)
	$(TEX) $(MAINDOCUMENT)
	$(TEX) $(MAINDOCUMENT)

spell::
	ispell *.tex

clean::
	rm -fv *.aux *.log *.bbl *.blg *.toc *.out *.lot *.lof *.loa $(MAINDOCUMENT).pdf *-converted-to.pdf

$(MAINDOCUMENT).bbl: $(MAINDOCUMENT).tex $(BIBFILE)
	$(TEX) $(MAINDOCUMENT)
	$(BIB) $(MAINDOCUMENT)

docker-all::
	docker run --rm -v ${PWD}:/project -w /project $(DOCKERIMAGE)  make all
