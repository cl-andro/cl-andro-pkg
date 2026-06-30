CLANDRO_SUBPKG_INCLUDE="
bin/fetchmailconf
lib/python*
share/man/man1/fetchmailconf.1.gz
"
CLANDRO_SUBPKG_DESCRIPTION="A GUI configurator for generating fetchmail configuration files"
CLANDRO_SUBPKG_DEPENDS="python, python-tkinter"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=true
CLANDRO_SUBPKG_CONFLICTS="fetchmail (<< 6.4.33)"
CLANDRO_SUBPKG_REPLACES="fetchmail (<< 6.4.33)"
