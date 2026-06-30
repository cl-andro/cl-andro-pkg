CLANDRO_PKG_HOMEPAGE=http://iverilog.icarus.com/
CLANDRO_PKG_DESCRIPTION="Icarus Verilog compiler and simulation tool"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=12.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/steveicarus/iverilog/archive/refs/tags/v${CLANDRO_PKG_VERSION/./_}.tar.gz
CLANDRO_PKG_SHA256=a68cb1ef7c017ef090ebedb2bc3e39ef90ecc70a3400afb4aa94303bc3beaa7d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+_\d+"
CLANDRO_PKG_DEPENDS="libbz2, libc++, readline, zlib"
CLANDRO_PKG_BREAKS="iverilog-dev"
CLANDRO_PKG_REPLACES="iverilog-dev"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
	aclocal
	autoconf
	export CFLAGS+=" -fcommon"

	local _BUILD_LIB=$CLANDRO_PKG_BUILDDIR/_build/lib
	mkdir -p "$_BUILD_LIB"
	for l in bz2 termcap; do
		echo '!<arch>' > "$_BUILD_LIB/lib${l}.a"
	done
	export LDFLAGS_FOR_BUILD+=" -L$_BUILD_LIB"
}

clandro_step_post_configure() {
	find . -name Makefile -print0 | xargs -0 -n 1 sed -i \
		-e 's:@EXTRALIBS@::g' \
		-e 's:@MINGW32@:no:g' \
		-e 's:@PICFLAG@:-fPIC:g' \
		-e 's:@install_suffix@::g' \
		-e 's:@rdynamic@:-rdynamic:g' \
		-e 's:@shared@:-shared:g'
}
