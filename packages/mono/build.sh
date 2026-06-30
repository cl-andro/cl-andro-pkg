CLANDRO_PKG_HOMEPAGE=https://gitlab.winehq.org/mono/mono
CLANDRO_PKG_DESCRIPTION="Framework Mono"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.14.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://gitlab.winehq.org/mono/mono
CLANDRO_PKG_GIT_BRANCH=mono-${CLANDRO_PKG_VERSION}
CLANDRO_PKG_DEPENDS="krb5, zlib"
CLANDRO_PKG_HOSTBUILD=true
# https://github.com/mono/mono/issues/21796
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-btls
--without-ikvm-native
"

clandro_step_host_build() {
	clandro_setup_cmake

	pushd $CLANDRO_PKG_SRCDIR
	NOCONFIGURE=1 ./autogen.sh
	popd

	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	$CLANDRO_PKG_SRCDIR/configure --prefix=$_PREFIX_FOR_BUILD \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
}

clandro_step_pre_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", mono-libs"

	clandro_setup_cmake

	if [ "$CLANDRO_ARCH" == "arm" ]; then
		CFLAGS="${CFLAGS//-mthumb/}"
	fi
	LDFLAGS+=" -lgssapi_krb5"

	NOCONFIGURE=1 ./autogen.sh
}

clandro_step_post_make_install() {
	pushd $CLANDRO_PKG_HOSTBUILD_DIR/prefix/lib/mono
	find . -name '*.so' -exec rm -f \{\} \;
	rm -f ./4.5/mono-shlib-cop.exe.config
	cp -rT . $CLANDRO_PREFIX/lib/mono
	popd

	# Strip off SOVERSION suffix for shared libraries.
	sed -i -E 's/\.so\.[0-9]+/.so/g' $CLANDRO_PREFIX/etc/mono/config
}
