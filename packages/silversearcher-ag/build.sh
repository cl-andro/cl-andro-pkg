CLANDRO_PKG_HOMEPAGE=https://geoff.greer.fm/ag/
CLANDRO_PKG_DESCRIPTION="Fast grep-like program, alternative to ack-grep"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.0
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://geoff.greer.fm/ag/releases/the_silver_searcher-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d9621a878542f3733b5c6e71c849b9d1a830ed77cb1a1f6c2ea441d4b0643170
CLANDRO_PKG_DEPENDS="pcre, liblzma, zlib"

clandro_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}
