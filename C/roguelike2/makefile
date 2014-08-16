#Make file for roguelike project
VPATH = src/
OUTPUTFILE = roguelike
INSTALLDIR = bin

.PHONY: all
all: $(OUTPUTFILE)

$(OUTPUTFILE): main.cpp
	g++ -o $@ $< -lsfml-graphics -lsfml-window -lsfml-system

.PHONY: install
install:
	mkdir -p $(INSTALLDIR)
	cp -p $(OUTPUTFILE) $(INSTALLDIR)

.PHONY: clean
clean:
	rm -f $(OUTPUTFILE)
