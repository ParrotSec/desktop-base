TARGET_DIR = usr/share/icons/desktop-base
TARGET_DIR_SCALABLE = $(TARGET_DIR)/scalable/emblems
# Generic folder for alternatives
TARGET_VENDOR = usr/share/icons/vendor
# TODO remove installing to _legacy early in bullseye cycle
TARGET_DIR_LEGACY = usr/share/icons/hicolor
TARGET_DIR_SCALABLE_LEGACY = $(TARGET_DIR_LEGACY)/scalable/emblems

.PHONY: build clean install

EMBLEMS = $(basename $(wildcard *.svg))
$(info Emblems: '$(EMBLEMS)')
# TODO remove installing to _legacy early in bullseye cycle
RESOLUTIONS := 64 128 256
$(info Resolutions: '$(RESOLUTIONS)')
RESOLUTIONS_LEGACY := 16 22 32 36 48 64 128 256
$(info Legacy Resolutions: '$(RESOLUTIONS_LEGACY)')

# The build: target should depend on all PNGs to generate
$(info $(foreach SVG,$(EMBLEMS),$(foreach RES,$(RESOLUTIONS),$(SVG)-$(RES)x$(RES).png)))
build: $(foreach SVG,$(EMBLEMS),$(foreach RES,$(RESOLUTIONS),$(SVG)-$(RES)x$(RES).png))

# Dynamically add rules for PNG generation for each resolution, for each emblem file
define SVG_TO_PNG_RULE
$1-$2x$2.png: $1.svg
	rsvg-convert $$< -w $2 -h $2 -o $$@.raw
	optipng $$@.raw -out $$@
endef
$(foreach EMBLEM,$(EMBLEMS),$(foreach RES,$(RESOLUTIONS),$(eval $(call SVG_TO_PNG_RULE,$(EMBLEM),$(RES)))))

clean:
	rm -f *.png.raw
	rm -f *.png

install:
	# Generic vendor folders, created empty and will be populated with
	# update-alternatives
	for RES in $(RESOLUTIONS) ; do \
		RES_DIR=$(DESTDIR)/$(TARGET_VENDOR)/$${RES}x$${RES}/emblems ; \
		install -d $${RES_DIR} ; \
	done
	install -d $(DESTDIR)/$(TARGET_VENDOR)/scalable/emblems
	# Iterate over resolutions.
	# For each resolution, install PNG emblems in the emblems folder for their
	# resolution.
	# TODO remove installing to _legacy early in bullseye cycle
	for CURRENT_DIR in $(TARGET_DIR) $(TARGET_DIR_LEGACY) ; do \
		install -d $(DESTDIR)/$${CURRENT_DIR} ; \
		for RES in $(RESOLUTIONS) ; do \
			RES_DIR=$(DESTDIR)/$${CURRENT_DIR}/$${RES}x$${RES} ; \
			install -d $${RES_DIR} ; \
			for EMBLEM in $(EMBLEMS) ; do \
				EMBLEMS_DIR=$${RES_DIR}/emblems ; \
				install -d $${EMBLEMS_DIR} ; \
				PNG_SOURCE=$${EMBLEM}-$${RES}x$${RES}.png ; \
				$(INSTALL_DATA) $${PNG_SOURCE} $${EMBLEMS_DIR}/$${EMBLEM}.png ; \
			done ; \
		done ; \
	done
	# TODO remove installing to _legacy early in bullseye cycle
	for RES in $(RESOLUTIONS) ; do \
		EMBLEMS_DIR=$(DESTDIR)/$(TARGET_DIR)/$${RES}x$${RES}/emblems ; \
		install -d $${EMBLEMS_DIR} ; \
		for EMBLEM in $(EMBLEMS) ; do \
			PNG_SOURCE=$${EMBLEM}-$${RES}x$${RES}.png ; \
			$(INSTALL_DATA) $${PNG_SOURCE} $${EMBLEMS_DIR}/$${EMBLEM}.png ; \
		done ; \
	done
	for RES in $(RESOLUTIONS_LEGACY) ; do \
		EMBLEMS_DIR=$(DESTDIR)/$(TARGET_DIR_LEGACY)/$${RES}x$${RES}/emblems ; \
		install -d $${EMBLEMS_DIR} ; \
		for EMBLEM in $(EMBLEMS) ; do \
			$(INSTALL_DATA) $${PNG_SOURCE} $${EMBLEMS_DIR}/$${EMBLEM}.png ; \
			$(INSTALL_DATA) $${EMBLEM}.icon $${EMBLEMS_DIR}/ ; \
		done ; \
	done
	# Install SVG emblems in the scalable emblems dir.
	for CURRENT_SCAL_DIR in $(TARGET_DIR_SCALABLE) $(TARGET_DIR_SCALABLE_LEGACY) ; do \
		install -d $(DESTDIR)/$${CURRENT_SCAL_DIR} ; \
		for EMBLEM in $(EMBLEMS) ; do \
			EMBLEMS_DIR=$(DESTDIR)/$${CURRENT_SCAL_DIR} ; \
			install -d $${EMBLEMS_DIR} ; \
			$(INSTALL_DATA) $${EMBLEM}.svg $${EMBLEMS_DIR}/ ; \
		done ; \
	done
	for EMBLEM in $(EMBLEMS) ; do \
		EMBLEMS_DIR=$(DESTDIR)/$(TARGET_DIR_SCALABLE) ; \
		install -d $${EMBLEMS_DIR} ; \
		$(INSTALL_DATA) $${EMBLEM}.svg $${EMBLEMS_DIR}/ ; \
	done
	for EMBLEM in $(EMBLEMS) ; do \
		EMBLEMS_DIR=$(DESTDIR)/$(TARGET_DIR_SCALABLE_LEGACY) ; \
		install -d $${EMBLEMS_DIR} ; \
		$(INSTALL_DATA) $${EMBLEM}.icon $${EMBLEMS_DIR}/ ; \
	done

include ../Makefile.inc
