GRUB_THEMES=parrot-theme/grub softwaves-theme/grub lines-theme/grub joy-theme/grub spacefun-theme/grub
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


	# Space Fun theme (Squeeze’s default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/spacefun
	$(INSTALL) $(wildcard spacefun-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/spacefun
	cd $(DESTDIR)/usr/share/desktop-base/spacefun-theme && ln -s /usr/share/plymouth/themes/spacefun plymouth
	$(INSTALL) spacefun-theme/plymouthd.defaults $(DESTDIR)/usr/share/desktop-base/spacefun-theme
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/spacefun-theme/login
	$(INSTALL) $(wildcard spacefun-theme/login/*) $(DESTDIR)/usr/share/desktop-base/spacefun-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/spacefun-theme/wallpaper/contents/images
	$(INSTALL) spacefun-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/spacefun-theme/wallpaper
	$(INSTALL) spacefun-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/spacefun-theme/wallpaper
	$(INSTALL) $(wildcard spacefun-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/spacefun-theme/wallpaper/contents/images/
	$(INSTALL) spacefun-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-spacefun.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/spacefun-theme/wallpaper SpaceFun

	### Lockscreen (same as wallpaper)
	cd $(DESTDIR)/usr/share/desktop-base/spacefun-theme && ln -s wallpaper lockscreen


	# Joy theme (Wheezy’s default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/joy
	$(INSTALL) $(wildcard joy-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/joy
	cd $(DESTDIR)/usr/share/desktop-base/joy-theme && ln -s /usr/share/plymouth/themes/joy plymouth
	$(INSTALL) joy-theme/plymouthd.defaults $(DESTDIR)/usr/share/desktop-base/joy-theme

	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/joy-theme/login
	$(INSTALL) $(wildcard joy-theme/login/*) $(DESTDIR)/usr/share/desktop-base/joy-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/joy-theme/wallpaper/contents/images
	$(INSTALL) joy-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/joy-theme/wallpaper
	$(INSTALL) joy-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/joy-theme/wallpaper
	$(INSTALL) $(wildcard joy-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/joy-theme/wallpaper/contents/images/
	$(INSTALL) joy-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-joy.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/joy-theme/wallpaper Joy

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/joy-theme/lockscreen/contents/images
	$(INSTALL) joy-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/joy-theme/lockscreen
	$(INSTALL) joy-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/joy-theme/lockscreen
	$(INSTALL) $(wildcard joy-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/joy-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/joy-theme/lockscreen JoyLockScreen

	# Joy Inksplat theme (Wheezy’s alternate theme)
	install -d $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme
	### Plymouth theme
	# Reuse « normal » joy theme
	cd $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme \
		&& ln -s /usr/share/plymouth/themes/joy plymouth \
		&& ln -s /usr/share/desktop-base/joy-theme/plymouthd.defaults plymouthd.defaults

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme/wallpaper/contents/images
	$(INSTALL) joy-inksplat-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme/wallpaper
	$(INSTALL) joy-inksplat-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme/wallpaper
	$(INSTALL) $(wildcard joy-inksplat-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme/wallpaper/contents/images/
	$(INSTALL) joy-inksplat-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-joy-inksplat.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/joy-inksplat-theme/wallpaper JoyInksplat
	### Lockscreen (same as Joy)
	cd $(DESTDIR)/usr/share/desktop-base/joy-inksplat-theme && ln -s /usr/share/desktop-base/joy-theme/lockscreen lockscreen


	# Lines theme (Jessie’s default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/lines
	$(INSTALL) $(wildcard lines-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/lines
	cd $(DESTDIR)/usr/share/desktop-base/lines-theme && ln -s /usr/share/plymouth/themes/lines plymouth
	$(INSTALL) lines-theme/plymouthd.defaults $(DESTDIR)/usr/share/desktop-base/lines-theme
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/lines-theme/login
	$(INSTALL) $(wildcard lines-theme/login/*) $(DESTDIR)/usr/share/desktop-base/lines-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/lines-theme/wallpaper/contents/images
	$(INSTALL) lines-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/lines-theme/wallpaper
	$(INSTALL) lines-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/lines-theme/wallpaper
	$(INSTALL) $(wildcard lines-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/lines-theme/wallpaper/contents/images/
	$(INSTALL) lines-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-lines.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/lines-theme/wallpaper Lines

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/lines-theme/lockscreen/contents/images
	$(INSTALL) lines-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/lines-theme/lockscreen
	$(INSTALL) lines-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/lines-theme/lockscreen
	$(INSTALL) $(wildcard lines-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/lines-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/lines-theme/lockscreen LinesLockScreen


	# Soft waves theme (Stretch’s default)
	### Plymouth theme
	install -d $(DESTDIR)/usr/share/plymouth/themes/softwaves
	$(INSTALL) $(wildcard softwaves-theme/plymouth/*) $(DESTDIR)/usr/share/plymouth/themes/softwaves
	cd $(DESTDIR)/usr/share/desktop-base/softwaves-theme && ln -s /usr/share/plymouth/themes/softwaves plymouth
	$(INSTALL) softwaves-theme/plymouthd.defaults $(DESTDIR)/usr/share/desktop-base/softwaves-theme
	### Login background
	install -d $(DESTDIR)/usr/share/desktop-base/softwaves-theme/login
	$(INSTALL) $(wildcard softwaves-theme/login/*) $(DESTDIR)/usr/share/desktop-base/softwaves-theme/login

	### Wallpapers
	install -d $(DESTDIR)/usr/share/desktop-base/softwaves-theme/wallpaper/contents/images
	$(INSTALL) softwaves-theme/wallpaper/metadata.desktop $(DESTDIR)/usr/share/desktop-base/softwaves-theme/wallpaper
	$(INSTALL) softwaves-theme/wallpaper/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/softwaves-theme/wallpaper
	$(INSTALL) $(wildcard softwaves-theme/wallpaper/contents/images/*) $(DESTDIR)/usr/share/desktop-base/softwaves-theme/wallpaper/contents/images/
	$(INSTALL) softwaves-theme/gnome-wp-list.xml $(DESTDIR)/usr/share/gnome-background-properties/debian-softwaves.xml
	# Wallpaper symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/softwaves-theme/wallpaper SoftWaves

	### Lockscreen
	install -d $(DESTDIR)/usr/share/desktop-base/softwaves-theme/lockscreen/contents/images
	$(INSTALL) softwaves-theme/lockscreen/metadata.desktop $(DESTDIR)/usr/share/desktop-base/softwaves-theme/lockscreen
	$(INSTALL) softwaves-theme/lockscreen/gnome-background.xml $(DESTDIR)/usr/share/desktop-base/softwaves-theme/lockscreen
	$(INSTALL) $(wildcard softwaves-theme/lockscreen/contents/images/*) $(DESTDIR)/usr/share/desktop-base/softwaves-theme/lockscreen/contents/images/
	# Lock screen symlink for KDE
	install -d $(DESTDIR)/usr/share/wallpapers
	cd $(DESTDIR)/usr/share/wallpapers && ln -s /usr/share/desktop-base/softwaves-theme/lockscreen SoftWavesLockScreen

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
