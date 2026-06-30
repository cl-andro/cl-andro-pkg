# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://git.linuxtv.org/v4l-utils.git
CLANDRO_PKG_DESCRIPTION="Linux utilities to handle media devices"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.24.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://linuxtv.org/downloads/v4l-utils/v4l-utils-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=cbb7fe8a6307f5ce533a05cded70bb93c3ba06395ab9b6d007eb53b75d805f5b
CLANDRO_PKG_DEPENDS="argp, libc++, libv4l"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-glob"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-libdvbv5
--disable-qv4l2
--disable-qvidcap
--disable-bpf
--without-jpeg
--without-libudev
"

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

	LDFLAGS+=" -L${_lib} -l:libgetsubopt.a -landroid-glob"
}

clandro_step_make_install() {
	make -C utils install
	make -C contrib install
	install -Dm600 -t $CLANDRO_PREFIX/etc/rc_keymaps \
		$CLANDRO_PKG_SRCDIR/utils/keytable/rc_keymaps/*
}
