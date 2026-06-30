CLANDRO_PKG_HOMEPAGE=https://getmonero.org/
CLANDRO_PKG_DESCRIPTION="A private, secure, untraceable, decentralised digital currency"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.18.5.0"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=git+https://github.com/monero-project/monero
CLANDRO_PKG_DEPENDS="boost, libc++, libprotobuf, libsodium, libunbound, libusb, libzmq, openssl, readline"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DReadline_ROOT_DIR=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	clandro_setup_protobuf

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"
}

clandro_step_post_configure() {
	local bin=$CLANDRO_PKG_BUILDDIR/_prefix/bin
	mkdir -p $bin
	$CC_FOR_BUILD \
		$CLANDRO_PKG_SRCDIR/translations/generate_translations_header.c \
		-o $bin/generate_translations_header_for_build
	export PATH=$bin:$PATH
}
