GRUB_THEMES=parrot-theme/grub
DEFAULT_BACKGROUND=desktop-background

PIXMAPS=$(wildcard pixmaps/*.png)
DESKTOPFILES=$(wildcard *.desktop)

.PHONY: all clean install install-local
all: build-grub build-emblems build-logos
clean: clean-grub clean-emblems clean-logos

.PHONY: build-grub clean-grub install-grub
build-grub clean-grub install-grub:
	@target=`echo $@ | sed s/-grub//`; \
	for grub_theme in $(GRUB_THEMES) ; do \
		if [ -f $$grub_theme/Makefile ] ; then \
			$(MAKE) $$target -C $$grub_theme || exit 1; \
		fi \
	done

.PHONY: build-emblems clean-emblems install-emblems
build-emblems clean-emblems install-emblems:
	@target=`echo $@ | sed s/-emblems//`; \
	$(MAKE) $$target -C emblems-debian || exit 1;

.PHONY: build-logos clean-logos install-logos
build-logos clean-logos install-logos:
	@target=`echo $@ | sed s/-logos//`; \
	$(MAKE) $$target -C debian-logos || exit 1;


install: install-grub install-emblems install-logos install-local

install-local:
	# debian logo in circle as default user face icon
	install -d $(DESTDIR)/etc/skel
	$(INSTALL_DATA) defaults/common/etc/skel/.face $(DESTDIR)/etc/skel
	cd $(DESTDIR)/etc/skel && ln -s .face .face.icon

	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	cd $(DESTDIR)/usr/share/images/desktop-base && ln -s $(DEFAULT_BACKGROUND) default
	# desktop files
	mkdir -p $(DESTDIR)/usr/share/desktop-base
	$(INSTALL_DATA) $(DESKTOPFILES) $(DESTDIR)/usr/share/desktop-base/
	# pixmaps files
	mkdir -p $(DESTDIR)/usr/share/pixmaps
	$(INSTALL_DATA) $(PIXMAPS) $(DESTDIR)/usr/share/pixmaps/

	# Create a 'debian-theme' symlink in plymouth themes folder, pointing at the
	# plymouth theme for the currently active 'desktop-theme' alternative.
	mkdir -p $(DESTDIR)/usr/share/plymouth/themes
	ln -s ../../desktop-base/active-theme/plymouth $(DESTDIR)/usr/share/plymouth/themes/debian-theme

	# Set Plasma 5 customizations
	install -d $(DESTDIR)/etc/xdg/autostart
	$(INSTALL_DATA) defaults/kde/etc/xdg/kcm-about-distrorc $(DESTDIR)/etc/xdg
	$(INSTALL_DATA) defaults/kde/etc/xdg/kickoffrc $(DESTDIR)/etc/xdg
	$(INSTALL_DATA) $(wildcard defaults/kde/etc/xdg/autostart/*) $(DESTDIR)/etc/xdg/autostart/
	install -d $(DESTDIR)/etc/xdg/plasma-workspace/env
	$(INSTALL_DATA) $(wildcard defaults/kde/etc/xdg/plasma-workspace/env/*) $(DESTDIR)/etc/xdg/plasma-workspace/env/
	install -d $(DESTDIR)/usr/share/desktop-base/kf5-settings
	$(INSTALL_DATA) $(wildcard defaults/kde/kf5-settings/*) $(DESTDIR)/usr/share/desktop-base/kf5-settings/
	install -d $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop/contents
	$(INSTALL_DATA) defaults/kde/plasma/look-and-feel/org.debian.desktop/metadata.json $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop
	$(INSTALL_DATA) defaults/kde/plasma/look-and-feel/org.debian.desktop/contents/defaults $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop/contents
	install -d $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop/contents/layouts
	$(INSTALL_DATA) $(wildcard defaults/kde/plasma/look-and-feel/org.debian.desktop/contents/layouts/*) $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop/contents/layouts/
	install -d $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop/contents/previews
	$(INSTALL_DATA) $(wildcard defaults/kde/plasma/look-and-feel/org.debian.desktop/contents/previews/*) $(DESTDIR)/usr/share/plasma/look-and-feel/org.debian.desktop/contents/previews/

	# Xfce 4.6
	mkdir -p $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml
	$(INSTALL_DATA) $(wildcard profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml/*) $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml

	# GNOME background descriptors
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties


	# Parrot Theme (default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/parrot6
	$(INSTALL_DATA) $(wildcard parrot-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/parrot6
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme
	cd $(DESTDIR)/usr/share/desktop-base/parrot-theme && ln -s /usr/share/plymouth/themes/parrot6 plymouth
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme/login
	$(INSTALL_DATA) $(wildcard parrot-theme/login/*) $(DESTDIR)/usr/share/desktop-base/parrot-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper/contents/images
	$(INSTALL_DATA) parrot-theme/wallpaper/metadata.json $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper
	$(INSTALL_DATA) parrot-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper
	$(INSTALL_DATA) $(wildcard parrot-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper/contents/images/
	$(INSTALL_DATA) parrot-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-parrot.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/parrot-theme/wallpaper parrot

	### Lockscreen is using the same image as wallpaper
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen/contents/images
	$(INSTALL_DATA) parrot-theme/wallpaper/metadata.json $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen
	$(INSTALL_DATA) parrot-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen
	$(INSTALL_DATA) $(wildcard parrot-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen/contents/images/

	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/parrot-theme/wallpaper parrot_wallpaper

include Makefile.inc
