CLANDRO_PKG_HOMEPAGE=https://github.com/imageworks/pystring
CLANDRO_PKG_DESCRIPTION="C++ functions matching the interface and behavior of python string methods with std::string"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/imageworks/pystring/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=49da0fe2a049340d3c45cce530df63a2278af936003642330287b68cefd788fb
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/include/pystring \
		$CLANDRO_PKG_SRCDIR/pystring.h
}
