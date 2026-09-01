DOCS = as-we-may-think-software-es as-we-may-think-software-en

all: $(addsuffix .pdf,$(DOCS))

%.pdf: %.tex $(wildcard figures/*)
	@if command -v tectonic >/dev/null 2>&1; then \
		tectonic $<; \
	else \
		latexmk -pdf -interaction=nonstopmode $<; \
	fi

clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.fls *.fdb_latexmk $(addsuffix .pdf,$(DOCS))

.PHONY: all clean
