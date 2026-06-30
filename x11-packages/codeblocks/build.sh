CLANDRO_PKG_HOMEPAGE=https://www.codeblocks.org/
CLANDRO_PKG_DESCRIPTION="Code::Blocks is the Integrated Development Environment (IDE)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=25.03
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/codeblocks/files/Sources/${CLANDRO_PKG_VERSION}/codeblocks_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b0f6aa5908d336d7f41f9576b2418ac7d27efbc59282aa8c9171d88cea74049e
CLANDRO_PKG_DEPENDS="codeblocks-data, glib, gtk3, libc++, wxwidgets, zip"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-contrib-plugins --disable-compiler"

clandro_step_host_build() {
	"${CLANDRO_PKG_SRCDIR}/configure"
	make -j $CLANDRO_PKG_MAKE_PROCESSES -C src/base
	make -j $CLANDRO_PKG_MAKE_PROCESSES -C src/build_tools
}

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"

	autoreconf -fi
}

clandro_step_post_configure() {
	sed -i 's/ -shared / -Wl,-O1,--as-needed\0/g' ./libtool
	cp -r $CLANDRO_PKG_HOSTBUILD_DIR/src/build_tools ./src/

	# We need to make sure the files are edited (or have their last modified date)
	# in a specific order to avoid accidentally triggering a recompilation.
	for file in ./src/build_tools/autorevision/{Makefile,autorevision.o,auto_revision}; do
		touch "${file}"
		sleep 0.1
	done
}
