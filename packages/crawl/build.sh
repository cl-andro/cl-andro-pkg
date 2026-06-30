CLANDRO_PKG_HOMEPAGE=https://crawl.develz.org/
CLANDRO_PKG_DESCRIPTION="Roguelike adventure through dungeons filled with dangerous monsters"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.34.1"
CLANDRO_PKG_SRCURL="https://github.com/crawl/crawl/releases/download/$CLANDRO_PKG_VERSION/stone_soup-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=473b9cdc16be0b537ac11e43c6c77db4b290000e4a17f72a842eba59c6b7be2a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, lua51, libsqlite, ncurses, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
FHS=yes
--debug
"

clandro_step_post_get_source() {
	echo "Applying util-gen_ver.pl.diff"
	sed "s|@VERSION@|${CLANDRO_PKG_VERSION#*:}|g" \
		$CLANDRO_PKG_BUILDER_DIR/util-gen_ver.pl.diff \
		| patch --silent -p1
	pushd source
	local f
	for f in initfile.cc main.cc startup.cc syscalls.cc; do
		sed -i 's|\(__ANDROID_\)_|\1_NO_TERMUX__|g' "${f}"
	done
	popd
}

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/source"
	CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_SRCDIR

	export DEFINES_L="-DHAVE_STAT"
	export LIBS="-llog -Wl,--rpath=$CLANDRO_PREFIX/lib"
}
