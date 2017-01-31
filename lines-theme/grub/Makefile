dir = usr/share/desktop-base/lines-theme/grub

files = \
	grub-4x3.png \
	grub-16x9.png

build: $(files)

clean:
	rm -f grub-4x3.png grub-16x9.png

install:
	install -d $(DESTDIR)/$(dir)
	$(INSTALL) $(wildcard *.png *.sh) $(DESTDIR)/$(dir)

grub-4x3.png: grub-4x3.svg
	rsvg-convert $< > $@

grub-16x9.png: grub-16x9.svg
	rsvg-convert $< > $@

include ../../Makefile.inc
