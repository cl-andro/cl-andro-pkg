CLANDRO_PKG_HOMEPAGE=https://www.nano-editor.org/
CLANDRO_PKG_DESCRIPTION="Small, free and friendly text editor"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.0"
CLANDRO_PKG_SRCURL=https://nano-editor.org/dist/latest/nano-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=9f384374b496110a25b73ad5a5febb384783c6e3188b37063f677ac908013fde
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
ac_cv_header_pwd_h=no
gl_cv_func_strcasecmp_works=yes
--disable-libmagic
--enable-utf8
--with-wordbounds
"
CLANDRO_PKG_CONFFILES="etc/nanorc"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/rnano share/man/man1/rnano.1 share/nano/man-html"

clandro_step_post_make_install() {
	# Configure nano to use syntax highlighting:
	NANORC=$CLANDRO_PREFIX/etc/nanorc
	echo "include \"$CLANDRO_PREFIX/share/nano/*nanorc\"" > "$NANORC"
}
