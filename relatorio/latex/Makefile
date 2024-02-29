# latex engine
TEX = xelatex
# output directory
OUT = output

all: clean build

build:
	mkdir -p $(OUT)
	$(TEX) -output-directory=$(OUT) main.tex

install:
	sudo apt install -y texlive-xetex texlive-lang-portuguese texlive-latex-recommended ttf-mscorefonts-installer
	sudo fc-cache -f && fc-match Arial

clean:
	rm -f $(OUT)/*.log $(OUT)/*.aux $(OUT)/*.fdb_latexmk $(OUT)/*.fls $(OUT)/*.lof $(OUT)/*.lot $(OUT)/*.nlo $(OUT)/*.out $(OUT)/*.toc
