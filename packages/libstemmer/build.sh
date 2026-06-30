CLANDRO_PKG_HOMEPAGE=https://snowballstem.org/
CLANDRO_PKG_DESCRIPTION="Snowball compiler and stemming algorithms"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.1"
CLANDRO_PKG_SRCURL="https://github.com/snowballstem/snowball/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=80ac10ce40dc4fcfbfed8d085c457b5613da0e86a73611a3d5527d044a142d60
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin stemwords
	install -Dm600 -t $CLANDRO_PREFIX/include include/libstemmer.h
	install -Dm600 -t $CLANDRO_PREFIX/lib libstemmer.a

	local f
	for f in libstemmer.so*; do
		if test -L "${f}"; then
			ln -sf "$(readlink "${f}")" $CLANDRO_PREFIX/lib/"${f}"
		else
			install -Dm600 -t $CLANDRO_PREFIX/lib "${f}"
		fi
	done
}
