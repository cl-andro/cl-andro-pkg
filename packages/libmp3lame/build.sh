CLANDRO_PKG_HOMEPAGE=https://lame.sourceforge.io/
CLANDRO_PKG_DESCRIPTION="High quality MPEG Audio Layer III (MP3) encoder"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.100
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/lame/lame/${CLANDRO_PKG_VERSION}/lame-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ddfe36cab873794038ae2c1210557ad34857a4b6bdc515785d1da9e175b1da1e
CLANDRO_PKG_BREAKS="libmp3lame-dev"
CLANDRO_PKG_REPLACES="libmp3lame-dev"

clandro_step_pre_configure() {
	# Avoid build error: version script assignment of 'global' to symbol 'lame_init_old' failed: symbol not defined
	LDFLAGS+=" -Wl,-undefined-version"
}

clandro_step_post_make_install() {
	local _pkgconfig_dir=$CLANDRO_PREFIX/lib/pkgconfig
	mkdir -p ${_pkgconfig_dir}
	cat <<-EOF > ${_pkgconfig_dir}/lame.pc
		prefix=$CLANDRO_PREFIX
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: lame
		Description: MP3 encoding library
		Requires:
		Version: $CLANDRO_PKG_VERSION
		Libs: -L\${libdir} -lmp3lame
		Cflags: -I\${includedir}
	EOF
}

clandro_step_post_massage() {
	# Some programs, e.g. Audacity, try to dlopen(3) `libmp3lame.so.0`.
	cd ${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib || exit 1
	if [ ! -e "./libmp3lame.so.0" ]; then
		ln -sf libmp3lame.so libmp3lame.so.0
	fi
}
