dir = usr/share/desktop-base/parrot-theme/grub

.PHONY: build clean install

#files = \
#	grub-4x3.png \
#	grub-16x9.png

#build: $(files)
build:

clean:
#	rm -f grub-4x3.png.raw grub-16x9.png.raw
#	rm -f grub-4x3.png grub-16x9.png

install:
	install -d $(DESTDIR)/$(dir)
	install -d $(DESTDIR)/boot
	$(INSTALL_DATA) $(wildcard *.png *.sh) $(DESTDIR)/$(dir)
	$(INSTALL_DATA) $(wildcard *.png *.sh) $(DESTDIR)/boot

#grub-4x3.png: grub-4x3.svg
#	inkscape --export-filename=$@ $<
#	mv $@ $@.raw
#	optipng $@.raw -out $@

#grub-16x9.png: grub-16x9.svg
#	inkscape --export-filename=$@ $<
#	mv $@ $@.raw
#	optipng $@.raw -out $@

include ../../Makefile.inc
