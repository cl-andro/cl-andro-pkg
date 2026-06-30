CLANDRO_PKG_HOMEPAGE=https://github.com/falconindy/pkgfile
CLANDRO_PKG_DESCRIPTION="An alpm .files metadata explorer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="25"
CLANDRO_PKG_SRCURL=https://github.com/falconindy/pkgfile/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dc18d7fcb03844bfd9857cb7b05b666d8a3469a38c73d3182da05fd4f8dd6403
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libandroid-glob, libandroid-utimes, libarchive, libcurl, pcre"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dsystemd_units=false
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-utimes"
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/cache/pkgfile
	EOF

	cat <<- EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	if [ "$CLANDRO_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	exit 0
	fi
	rm -rf $CLANDRO_PREFIX/var/cache/pkgfile
	EOF
}
