CLANDRO_PKG_HOMEPAGE=http://aspell.net
CLANDRO_PKG_DESCRIPTION="A free and open source spell checker designed to replace Ispell"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.60.8.2"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/aspell/aspell-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=57fe4863eae6048f72245a8575b44b718fb85ca14b9f8c0afc41b254dfd76919
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
# To use the same compiled dictionaries on every platform:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-32-bit-hash-fun"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
