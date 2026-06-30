CLANDRO_PKG_HOMEPAGE=https://musicbrainz.org/doc/libmusicbrainz
CLANDRO_PKG_DESCRIPTION="The MusicBrainz Client Library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=()
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_VERSION+=(5.1.0)
CLANDRO_PKG_VERSION+=(2.9.12) # libxml2 version
CLANDRO_PKG_VERSION+=(0.33.0) # libneon version
CLANDRO_PKG_SRCURL=(https://github.com/metabrainz/libmusicbrainz/releases/download/release-${CLANDRO_PKG_VERSION}/libmusicbrainz-${CLANDRO_PKG_VERSION}.tar.gz
                   ftp://xmlsoft.org/libxml2/libxml2-${CLANDRO_PKG_VERSION[1]}.tar.gz
                   https://notroj.github.io/neon/neon-${CLANDRO_PKG_VERSION[2]}.tar.gz)
CLANDRO_PKG_SHA256=(6749259e89bbb273f3f5ad7acdffb7c47a2cf8fcaeab4c4695484cef5f4c6b46
                   c8d6681e38c56f172892c85ddc0852e1fd4b53b4209e7f4ebf17f7e2eae71d92
                   659a5cc9cea05e6e7864094f1e13a77abbbdbab452f04d751a8c16a9447cf4b8)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++, libneon, libxml2"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	mv libxml2-${CLANDRO_PKG_VERSION[1]} libxml2
	mv neon-${CLANDRO_PKG_VERSION[2]} neon
}

clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD
	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	mkdir libxml2
	pushd libxml2
	$CLANDRO_PKG_SRCDIR/libxml2/configure --prefix=$_PREFIX_FOR_BUILD \
		--without-python
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
	popd

	mkdir neon
	pushd neon
	$CLANDRO_PKG_SRCDIR/neon/configure --prefix=$_PREFIX_FOR_BUILD \
		--with-libxml2
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make docs # "make install-docs" will fail without this
	make install
	popd

	clandro_setup_cmake

	cmake $CLANDRO_PKG_SRCDIR
	make -j $CLANDRO_PKG_MAKE_PROCESSES

	unset PKG_CONFIG_PATH
}

clandro_step_pre_configure() {
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DIMPORT_EXECUTABLES=$CLANDRO_PKG_HOSTBUILD_DIR/ImportExecutables.cmake"
}
