paper = gpleiss_thesis

# Grab all possible source
source := $(shell ls **/*.tex *.sty figures/*pdf figures/*png figures/*jpg 2>/dev/null)
sourcebib := $(shell ls *.bib)

all:
	pdflatex -shell-escape ${paper}.tex
	bibtex ${paper}.aux
	pdflatex -shell-escape ${paper}.tex
	pdflatex -shell-escape ${paper}.tex

${paper}.bbl: ${sourcebib}
	pdflatex -shell-escape ${paper}.tex
	bibtex ${paper}.aux
	pdflatex -shell-escape ${paper}.tex

${paper}.pdf: ${paper}.bbl ${source}
	pdflatex -shell-escape ${paper}.tex

quick:
	pdflatex -shell-escape ${paper}.tex

watch:
	while true; do if [ sections -nt ${paper}.pdf ] || [ ${paper}.tex -nt ${paper}.pdf ] || [ figures -nt ${paper}.pdf ]; then make quick; fi; sleep 1; done

clean:
	rm -rf *.aux *.blg *.bbl *.log *.out ${paper}.pdf
