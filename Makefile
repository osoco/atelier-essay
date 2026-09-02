TEXS = essay/as-we-may-think-software-es.tex essay/as-we-may-think-software-en.tex

all:
	@for t in $(TEXS); do \
		if command -v tectonic >/dev/null 2>&1; then \
			tectonic $$t; \
		else \
			latexmk -cd -pdf -interaction=nonstopmode $$t; \
		fi; \
	done
	@mv essay/as-we-may-think-software-es.pdf "essay/As We May Think Software-ES.pdf"
	@mv essay/as-we-may-think-software-en.pdf "essay/As We May Think Software-EN.pdf"
	@ls -1 essay/*.pdf

clean:
	rm -f essay/*.aux essay/*.log essay/*.out essay/*.toc essay/*.bbl essay/*.blg essay/*.fls essay/*.fdb_latexmk essay/*.pdf

.PHONY: all clean
