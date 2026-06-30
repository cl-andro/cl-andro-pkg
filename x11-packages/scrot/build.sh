CLANDRO_PKG_HOMEPAGE=https://github.com/dreamer/scrot
CLANDRO_PKG_DESCRIPTION="Simple command-line screenshot utility for X"
# License: MIT-feh
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.0"
CLANDRO_PKG_SRCURL=https://github.com/resurrecting-open-source-projects/scrot/releases/download/${CLANDRO_PKG_VERSION}/scrot-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1b4b3acadfe07bf89234838675d1d23508a9a6810cb64584f1d9610103d6cdfa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="imlib2, libx11, libxcomposite, libxfixes, libxrandr"

clandro_step_pre_configure() {
	local _inc="$CLANDRO_PKG_SRCDIR/_getsubopt/include"
	rm -rf "${_inc}"
	mkdir -p "${_inc}"
	cp "$CLANDRO_PKG_BUILDER_DIR/getsubopt.h" "${_inc}"

	CPPFLAGS+=" -I${_inc} -D__force= -UANDROID"

	local _lib="$CLANDRO_PKG_BUILDDIR/_getsubopt/lib"
	rm -rf "${_lib}"
	mkdir -p "${_lib}"
	pushd "${_lib}"/..
	$CC $CFLAGS $CPPFLAGS "$CLANDRO_PKG_BUILDER_DIR/getsubopt.c" \
		-fvisibility=hidden -c -o ./getsubopt.o
	$AR cru "${_lib}"/libgetsubopt.a ./getsubopt.o
	popd

	LDFLAGS+=" -L${_lib} -l:libgetsubopt.a"
}
