CLANDRO_PKG_HOMEPAGE=https://github.com/tizonia/
CLANDRO_PKG_DESCRIPTION="A command-line streaming music client/server for Linux"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.22.0"
CLANDRO_PKG_REVISION=24
CLANDRO_PKG_SRCURL="https://github.com/tizonia/tizonia-openmax-il/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0750cae23ed600fb4b4699a392f43a5e03dcd0870383d64da4b8c28ea94a82f8
CLANDRO_PKG_DEPENDS="boost, dbus, libandroid-wordexp, libc++, libcurl, libflac, liblog4c, libmad, libmediainfo, libmp3lame, liboggz, libopus, libsndfile, libsqlite, libuuid, libvpx, libmpg123, opusfile, pulseaudio, python, taglib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, libev"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_build_python
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	local srcdir="$CLANDRO_PKG_SRCDIR"/3rdparty/dbus-cplusplus
	autoreconf -fi "$srcdir"
	"$srcdir"/configure --prefix=$_PREFIX_FOR_BUILD
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
}

clandro_step_pre_configure() {
	clandro_setup_python_pip
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix

	install -Dm700 $CLANDRO_PKG_BUILDER_DIR/exe_wrapper $_PREFIX_FOR_BUILD/bin/
	PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	export BOOST_ROOT=$CLANDRO_PREFIX
	LDFLAGS+=" -landroid-wordexp"
}

clandro_step_configure_meson() {
	clandro_setup_meson
	sed -i 's/^\(\[binaries\]\)$/\1\nexe_wrapper = '\'exe_wrapper\''/g' \
		$CLANDRO_MESON_CROSSFILE
	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $CLANDRO_MESON \
		$CLANDRO_PKG_SRCDIR \
		$CLANDRO_PKG_BUILDDIR \
		--cross-file $CLANDRO_MESON_CROSSFILE \
		--prefix $CLANDRO_PREFIX \
		--libdir lib \
		--buildtype minsize \
		--strip \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}
