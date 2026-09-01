DOCS = as-we-may-think-software-es as-we-may-think-software-en
PDFS = $(addprefix essay/,$(addsuffix .pdf,$(DOCS)))

all: $(PDFS)

essay/%.pdf: essay/%.tex $(wildcard essay/figures/*)
	@if command -v tectonic >/dev/null 2>&1; then \
		tectonic $<; \
	else \
		latexmk -cd -pdf -interaction=nonstopmode $<; \
	fi

clean:
	rm -f essay/*.aux essay/*.log essay/*.out essay/*.toc essay/*.bbl essay/*.blg essay/*.fls essay/*.fdb_latexmk $(PDFS)

.PHONY: all clean
