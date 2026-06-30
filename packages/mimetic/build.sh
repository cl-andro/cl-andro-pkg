# Contributor: @librehat
CLANDRO_PKG_HOMEPAGE=https://www.codesink.org/mimetic_mime_library.html
CLANDRO_PKG_DESCRIPTION="A C++ Email library (MIME)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.9.8
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.codesink.org/download/mimetic-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3a07d68d125f5e132949b078c7275d5eb0078dd649079bd510dd12b969096700
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
