dir = usr/share/desktop-base/debian-logos

.PHONY: build clean install

LOGOS = $(basename $(wildcard *.svg))
$(info Logos: '$(LOGOS)')
RESOLUTIONS := 64 128 256
$(info Resolutions: '$(RESOLUTIONS)')

# The build: target should depend on all PNGs to generate
$(info $(foreach SVG,$(LOGOS),$(foreach RES,$(RESOLUTIONS),$(SVG)-$(RES).png)))
build: $(foreach SVG,$(LOGOS),$(foreach RES,$(RESOLUTIONS),$(SVG)-$(RES).png))

# Dynamically add rules for PNG generation for each resolution, for each logo file
define SVG_TO_PNG_RULE
$1-$2.png: $1.svg
	rsvg-convert $$< -h $2 -o $$@.raw
	optipng $$@.raw -out $$@
endef
$(foreach LOGO,$(LOGOS),$(foreach RES,$(RESOLUTIONS),$(eval $(call SVG_TO_PNG_RULE,$(LOGO),$(RES)))))

clean:
	rm -f *.png.raw
	rm -f *.png

install:
	install -d $(DESTDIR)/$(dir)
	$(INSTALL_DATA) $(wildcard *.svg) $(DESTDIR)/$(dir)
	$(INSTALL_DATA) $(wildcard *.png) $(DESTDIR)/$(dir)

include ../Makefile.inc
