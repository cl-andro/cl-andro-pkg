CLANDRO_PKG_HOMEPAGE=http://www.columbia.edu/kermit/gkermit.html
CLANDRO_PKG_DESCRIPTION="Simple, Portable, Free File Transfer Software for UNIX"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.01"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.kermitproject.org/ftp/kermit/archives/gku${CLANDRO_PKG_VERSION/./}.tar.gz
CLANDRO_PKG_SHA256=19f9ac00d7b230d0a841928a25676269363c2925afc23e62704cde516fc1abbd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_post_get_source() {
	local file filename
	filename=$(basename "$CLANDRO_PKG_SRCURL")
	file="$CLANDRO_PKG_CACHEDIR/$filename"
	tar xf "$file" -C "$CLANDRO_PKG_SRCDIR"
}
