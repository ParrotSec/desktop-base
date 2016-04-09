DEFAULT_BACKGROUND=desktop-background

INSTALL=install -m 0644
BACKGROUNDS=$(wildcard backgrounds/*.png backgrounds/*.jpg backgrounds/*.svg backgrounds/*.tga backgrounds/*.xml)
GDMLOGIN=$(wildcard gdm3/login/*.png)
SPLASH=$(wildcard splash/*.png splash/*.svg)
PIXMAPS=$(wildcard pixmaps/*.png)
DESKTOPFILES=$(wildcard *.desktop)

all:

clean:

install:
	# background files
	mkdir -p $(DESTDIR)/usr/share/images/desktop-base
	$(INSTALL) $(BACKGROUNDS) $(DESTDIR)/usr/share/images/desktop-base
	cd $(DESTDIR)/usr/share/images/desktop-base && ln -s $(DEFAULT_BACKGROUND) default
	# splash files
	$(INSTALL) $(SPLASH) $(DESTDIR)/usr/share/images/desktop-base
	# emblems
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor/36x36/emblems
	$(INSTALL) $(wildcard icons/36x36/emblems/*) $(DESTDIR)/usr/share/icons/hicolor/36x36/emblems
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor/64x64/emblems
	$(INSTALL) $(wildcard icons/64x64/emblems/*) $(DESTDIR)/usr/share/icons/hicolor/64x64/emblems
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor/128x128/emblems
	$(INSTALL) $(wildcard icons/128x128/emblems/*) $(DESTDIR)/usr/share/icons/hicolor/128x128/emblems
	mkdir -p $(DESTDIR)/usr/share/icons/hicolor/scalable/emblems
	$(INSTALL) $(wildcard icons/scalable/emblems/*) $(DESTDIR)/usr/share/icons/hicolor/scalable/emblems
	# desktop files
	mkdir -p $(DESTDIR)/usr/share/desktop-base
	$(INSTALL) $(DESKTOPFILES) $(DESTDIR)/usr/share/desktop-base/
	$(INSTALL) $(GDMLOGIN) $(DESTDIR)/usr/share/desktop-base/
	# pixmaps files
	mkdir -p $(DESTDIR)/usr/share/pixmaps
	$(INSTALL) $(PIXMAPS) $(DESTDIR)/usr/share/pixmaps/

	# KDE Config
	mkdir -p $(DESTDIR)/usr/share/desktop-base/profiles/kde-profile/share/config
	$(INSTALL) $(wildcard profiles/kde-profile/share/config/*) $(DESTDIR)/usr/share/desktop-base/profiles/kde-profile/share/config
	mkdir -p $(DESTDIR)/usr/share/kde4/config
	$(INSTALL) profiles/kde-profile/kdeglobals $(DESTDIR)/usr/share/kde4/config
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/plasma-desktop/init/
	$(INSTALL) kde-wallpaper/10-desktop-base.js $(DESTDIR)/usr/share/kde4/apps/plasma-desktop/init/

	# KDE Wallpaper
	## Joy
	mkdir -p $(DESTDIR)/usr/share/wallpapers/joy
	$(INSTALL) kde-wallpaper/joy/metadata.desktop $(DESTDIR)/usr/share/wallpapers/joy/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/joy/contents
	$(INSTALL) kde-wallpaper/joy/contents/screenshot.png $(DESTDIR)/usr/share/wallpapers/joy/contents/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/joy/contents/images
	$(INSTALL) $(wildcard kde-wallpaper/joy/contents/images/*) $(DESTDIR)/usr/share/wallpapers/joy/contents/images/
	# Inksplat Version
	mkdir -p $(DESTDIR)/usr/share/wallpapers/joy_inksplat
	$(INSTALL) kde-wallpaper/joy_inksplat/metadata.desktop $(DESTDIR)/usr/share/wallpapers/joy_inksplat/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/joy_inksplat/contents
	$(INSTALL) kde-wallpaper/joy_inksplat/contents/screenshot.png $(DESTDIR)/usr/share/wallpapers/joy_inksplat/contents/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/joy_inksplat/contents/images
	$(INSTALL) $(wildcard kde-wallpaper/joy_inksplat/contents/images/*) $(DESTDIR)/usr/share/wallpapers/joy_inksplat/contents/images/
	# Parrot version
	mkdir -p $(DESTDIR)/usr/share/wallpapers/parrot
	$(INSTALL) kde-wallpaper/parrot/metadata.desktop $(DESTDIR)/usr/share/wallpapers/parrot/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/parrot/contents
	$(INSTALL) kde-wallpaper/parrot/contents/screenshot.png $(DESTDIR)/usr/share/wallpapers/parrot/contents/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/parrot/contents/images
	$(INSTALL) $(wildcard kde-wallpaper/parrot/contents/images/*) $(DESTDIR)/usr/share/wallpapers/parrot/contents/images/
	## Lines
	mkdir -p $(DESTDIR)/usr/share/wallpapers/Lines
	$(INSTALL) kde-wallpaper/Lines/metadata.desktop $(DESTDIR)/usr/share/wallpapers/Lines/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/Lines/contents
	$(INSTALL) kde-wallpaper/Lines/contents/screenshot.png $(DESTDIR)/usr/share/wallpapers/Lines/contents/
	mkdir -p $(DESTDIR)/usr/share/wallpapers/Lines/contents/images
	$(INSTALL) $(wildcard kde-wallpaper/Lines/contents/images/*) $(DESTDIR)/usr/share/wallpapers/Lines/contents/images/

	# KDM theme
	mkdir -p $(DESTDIR)/etc/default/kdm.d
	$(INSTALL) kdm-theme/kdm.d/10_desktop-base $(DESTDIR)/etc/default/kdm.d
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/kdm/themes/joy
	$(INSTALL) $(wildcard kdm-theme/joy/*) $(DESTDIR)/usr/share/kde4/apps/kdm/themes/joy
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/kdm/themes/parrot
	$(INSTALL) $(wildcard kdm-theme/parrot/*) $(DESTDIR)/usr/share/kde4/apps/kdm/themes/parrot
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/kdm/themes/lines
	$(INSTALL) $(wildcard kdm-theme/lines/*) $(DESTDIR)/usr/share/kde4/apps/kdm/themes/lines

	# KSPLASH themes
	## Joy
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy
	$(INSTALL) ksplash-theme/joy/Preview.png $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy
	$(INSTALL) ksplash-theme/joy/Theme.rc $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1024x768
	$(INSTALL) $(wildcard ksplash-theme/joy/1024x768/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1024x768
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1280x800
	$(INSTALL) $(wildcard ksplash-theme/joy/1280x800/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1280x800
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1280x1024
	$(INSTALL) $(wildcard ksplash-theme/joy/1280x1024/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1280x1024
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1366x768
	$(INSTALL) $(wildcard ksplash-theme/joy/1366x768/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1366x768
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1600x1200
	$(INSTALL) $(wildcard ksplash-theme/joy/1600x1200/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1600x1200
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1920x1080
	$(INSTALL) $(wildcard ksplash-theme/joy/1920x1080/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1920x1080
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1920x1200
	$(INSTALL) $(wildcard ksplash-theme/joy/1920x1200/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/joy/1920x1200
	## parrot	
	mkdir -p $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/parrot
	cp -a ksplash-theme/parrot/* $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/parrot/
	## Lines
	install -d $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/lines/images
	$(INSTALL) $(wildcard ksplash-theme/lines/*.qml) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/lines
	$(INSTALL) $(wildcard ksplash-theme/lines/*.png) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/lines
	$(INSTALL) $(wildcard ksplash-theme/lines/*.rc) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/lines
	$(INSTALL) $(wildcard ksplash-theme/lines/images/*) $(DESTDIR)/usr/share/kde4/apps/ksplash/Themes/lines/images


	# Xfce 4.6
	mkdir -p $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml
	$(INSTALL) $(wildcard profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml/*) $(DESTDIR)/usr/share/desktop-base/profiles/xdg-config/xfce4/xfconf/xfce-perchannel-xml
	# GNOME background descriptor
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties
	$(INSTALL) gnome-backgrounds.xml $(DESTDIR)/usr/share/gnome-background-properties/debian.xml
	# GDM 3 theme
	mkdir -p $(DESTDIR)/usr/share/gdm/dconf
	$(INSTALL) gdm3/background.png $(DESTDIR)/usr/share/images/desktop-base/login-background.png
	$(INSTALL) gdm3/10-desktop-base-settings $(DESTDIR)/usr/share/gdm/dconf/

	# grub
	$(INSTALL) grub/lines-grub.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/lines-grub-1920x1080.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/joy-grub.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/spacefun-grub.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/spacefun-grub-widescreen.png $(DESTDIR)/usr/share/images/desktop-base/
	$(INSTALL) grub/grub_background.sh $(DESTDIR)/usr/share/desktop-base/
	$(INSTALL) grub/parrot-grub.png $(DESTDIR)/usr/share/images/desktop-base/

	# plymouth
	install -d $(DESTDIR)/usr/share/plymouth/themes/spacefun
	$(INSTALL) $(wildcard plymouth/spacefun/*) $(DESTDIR)/usr/share/plymouth/themes/spacefun

	install -d $(DESTDIR)/usr/share/plymouth/themes/joy
	$(INSTALL) $(wildcard plymouth/joy/*) $(DESTDIR)/usr/share/plymouth/themes/joy
	
	install -d $(DESTDIR)/usr/share/plymouth/themes/parrot
	$(INSTALL) $(wildcard plymouth/parrot/*) $(DESTDIR)/usr/share/plymouth/themes/parrot

	install -d $(DESTDIR)/usr/share/plymouth/themes/lines
	$(INSTALL) $(wildcard plymouth/lines/*) $(DESTDIR)/usr/share/plymouth/themes/lines
