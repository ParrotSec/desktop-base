INSTALL=install
INSTALL_PROGRAM=$(INSTALL)
# Don't use $(INSTALL) for data as debhelper >= 11 injects
# --strip-program=true which is specific to non-data files
#INSTALL_DATA=$(INSTALL) -m 644
INSTALL_DATA=install -m 644

