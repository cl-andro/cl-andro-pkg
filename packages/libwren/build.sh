CLANDRO_PKG_HOMEPAGE=https://wren.io/
CLANDRO_PKG_DESCRIPTION="Small, fast, class-based concurrent scripting language libraries"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.0
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/wren-lang/wren/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=23c0ddeb6c67a4ed9285bded49f7c91714922c2e7bb88f42428386bf1cf7b339
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="wren-dev, wren (<< 0.3.0)"
CLANDRO_PKG_REPLACES="wren-dev, wren (<< 0.3.0)"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_make() {
	local QUIET_BUILD=
	if [ "$CLANDRO_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	cd projects/make
	if [ "$CLANDRO_ARCH" = i686 ] || [ "$CLANDRO_ARCH" = arm ]; then
		RELEASE=release_32bit
	else
		RELEASE=release_64bit
	fi
	make -j $CLANDRO_PKG_MAKE_PROCESSES $QUIET_BUILD config=${RELEASE}
}

clandro_step_make_install() {
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/src/include/wren.h \
		"$CLANDRO_PREFIX"/include/wren.h

	install -Dm600 "$CLANDRO_PKG_SRCDIR"/lib/libwren.so \
		"$CLANDRO_PREFIX"/lib/libwren.so

	install -Dm600 "$CLANDRO_PKG_SRCDIR"/lib/libwren.a \
		"$CLANDRO_PREFIX"/lib/libwren.a
}
