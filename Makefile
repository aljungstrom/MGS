.PHONY: all latexmk pdflatex arxiv quick clean

# .tex files generated from .lagda files
generated = \
  # agda/latex/Section2.tex \
  # agda/latex/Section3.tex \
  # agda/latex/Section4.tex \
  # agda/latex/Section5.tex \

all: main.tex $(generated) papers.bib
	latexmk -pdflatex=lualatex -pdf main.tex

latexmk: main.tex $(generated) papers.bib
	latexmk -pdfxe main.tex

pdflatex: main.tex $(generated) papers.bib
	latexmk -pdf main.tex

quick: main.tex $(generated)
	lualatex $<

$(generated) : agda/latex/%.tex : agda/%.lagda
	cd agda; agda --latex $(notdir $<)

clean:
	rubber --clean main.tex
	rm *bcf-* *.fdb* *.tex~ Makefile~ *.log *.aux *.fls  main.pdf main.ptb main.vtc main.toc 2> /dev/null || true
	find . -type f -name '*.agdai' -delete
	rm -rf agda/latex/
