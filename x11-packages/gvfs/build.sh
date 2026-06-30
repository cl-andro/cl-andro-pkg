CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/gvfs
CLANDRO_PKG_DESCRIPTION="A userspace virtual filesystem implementation for GIO"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.60.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gvfs/${CLANDRO_PKG_VERSION%.*}/gvfs-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=648273f069e92c7e3c013b92148e82c901f08044e2b3b14c6cfbd52269f6b646
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus, gcr4, glib, gsettings-desktop-schemas, libarchive, libsecret, libsoup3, libxml2"
CLANDRO_PKG_RECOMMENDS="gnome-keyring"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dsystemduserunitdir=no
-Dtmpfilesdir=no
-Dprivileged_group=system
-Dadmin=false
-Dafc=false
-Dafp=false
-Darchive=true
-Dcdda=false
-Ddnssd=false
-Dgoa=false
-Dgoogle=false
-Dgphoto2=false
-Dhttp=true
-Dmtp=false
-Dnfs=false
-Donedrive=false
-Dsftp=true
-Dsmb=false
-Dudisks2=false
-Dbluray=false
-Dfuse=false
-Dgcr=true
-Dgcrypt=false
-Dgudev=false
-Dlogind=false
-Dlibusb=false
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
