dir = usr/share/icons/hicolor
scal_emblems_dir = $(dir)/scalable/emblems

EMBLEMS = $(basename $(wildcard *.svg))
$(info Emblems: '$(EMBLEMS)')
RESOLUTIONS := 16 22 32 36 48 64 128 256
$(info Resolutions: '$(RESOLUTIONS)')

# The all target should depend on all PNGs to generate
$(info $(foreach SVG,$(EMBLEMS),$(foreach RES,$(RESOLUTIONS),$(SVG)-$(RES)x$(RES).png)))
.PHONY: build
build: $(foreach SVG,$(EMBLEMS),$(foreach RES,$(RESOLUTIONS),$(SVG)-$(RES)x$(RES).png))

# Dynamically add rules for PNG generation for each resolution, for each emblem file
define SVG_TO_PNG_RULE
$1-$2x$2.png: $1.svg
	rsvg-convert $$< -w $2 -h $2 > $$@
endef
$(foreach EMBLEM,$(EMBLEMS),$(foreach RES,$(RESOLUTIONS),$(eval $(call SVG_TO_PNG_RULE,$(EMBLEM),$(RES)))))

.PHONY: clean
clean:
	rm -f *.png

.PHONY: install
install:
	install -d $(DESTDIR)/$(dir)
	# Iterate over resolutions.
	# For each resolution, install PNG emblems in the emblems folder for their
	# resolution.
	for RES in $(RESOLUTIONS) ; do \
		RES_DIR=$(DESTDIR)/$(dir)/$${RES}x$${RES} ; \
		install -d $${RES_DIR} ; \
		for EMBLEM in $(EMBLEMS) ; do \
			EMBLEMS_DIR=$${RES_DIR}/emblems ; \
			install -d $${EMBLEMS_DIR} ; \
			PNG_SOURCE=$${EMBLEM}-$${RES}x$${RES}.png ; \
			$(INSTALL) $${PNG_SOURCE} $${EMBLEMS_DIR}/$${EMBLEM}.png ; \
			$(INSTALL) $${EMBLEM}.icon $${EMBLEMS_DIR}/ ; \
		done ; \
	done
	for EMBLEM in $(EMBLEMS) ; do \
		EMBLEMS_DIR=$(DESTDIR)/$(scal_emblems_dir) ; \
		install -d $${EMBLEMS_DIR} ; \
		$(INSTALL) $${EMBLEM}.svg $${EMBLEMS_DIR}/ ; \
		$(INSTALL) $${EMBLEM}.icon $${EMBLEMS_DIR}/ ; \
	done

include ../Makefile.inc
