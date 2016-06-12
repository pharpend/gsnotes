all: build

build:
	mkdir -p .build
	rsync -acv gsnotes*.tex gsnotes.bib chapters images .build
	cd .build && \
	  cat gsnotes-ebook.tex gsnotes.tex > ebook.tex && \
	  latexmk -f -pdf ebook.tex && \
	  cp ebook.pdf ../gsnotes-ebook.pdf && \
	  cat gsnotes-print.tex gsnotes.tex > print.tex && \
	  latexmk -f -pdf print.tex && \
	  cp print.pdf ../gsnotes-print.pdf

clean:
	rm -rf .build
