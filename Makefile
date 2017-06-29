GRUB_THEMES=parrot-theme/grub
DEFAULT_BACKGROUND=desktop-background

PIXMAPS=$(wildcard pixmaps/*.png)
DESKTOPFILES=$(wildcard *.desktop)

all: build-grub build-emblems

build-grub clean-grub install-grub:
	@target=`echo $@ | sed s/-grub//`; \
	for grub_theme in $(GRUB_THEMES) ; do \
		if [ -f $$grub_theme/Makefile ] ; then \
			$(MAKE) $$target -C $$grub_theme || exit 1; \
		fi \
	done$

build-emblems clean-emblems install-emblems:
	@target=`echo $@ | sed s/-emblems//`; \
	$(MAKE) $$target -C emblems-debian || exit 1;

clean: clean-grub clean-emblems

install: install-grub install-emblems install-local

install-local:
	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	cd $(DESTDIR)/usr/share/images/desktop-base && ln -s $(DEFAULT_BACKGROUND) default
	# desktop files
	mkdir -p $(DESTDIR)/usr/share/desktop-base
	$(INSTALL) $(DESKTOPFILES) $(DESTDIR)/usr/share/desktop-base/
	# pixmaps files
	mkdir -p $(DESTDIR)/usr/share/pixmaps
	$(INSTALL) $(PIXMAPS) $(DESTDIR)/usr/share/pixmaps/


	# Set Plasma 5/KDE default wallpaper
	install -d $(DESTDIR)/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates
	$(INSTALL) defaults/plasma5/desktop-base.js $(DESTDIR)/usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/

	# Xfce 4.6
	mkdir -p $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml
	$(INSTALL) $(wildcard profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml/*) $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml

	# GNOME background descriptors
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties

	# parrot theme
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/parrot
	$(INSTALL) $(wildcard parrot-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/parrot
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme
	cd $(DESTDIR)/usr/share/desktop-base/parrot-theme && ln -s /usr/share/plymouth/themes/parrot plymouth
	$(INSTALL) parrot-theme/plymouthd.defaults $(DESTDIR)/usr/share/desktop-base/parrot-theme
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme/login
	$(INSTALL) $(wildcard parrot-theme/login/*) $(DESTDIR)/usr/share/desktop-base/parrot-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper/contents/images
	$(INSTALL) parrot-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper
	$(INSTALL) parrot-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper
	$(INSTALL) $(wildcard parrot-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/parrot-theme/wallpaper/contents/images/
	$(INSTALL) parrot-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-parrot.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/parrot-theme/wallpaper parrot

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen/contents/images
	$(INSTALL) parrot-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen
	$(INSTALL) parrot-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen
	$(INSTALL) $(wildcard parrot-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/parrot-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/parrot-theme/lockscreen parrotLockScreen


include Makefile.inc
