CLANDRO_PKG_HOMEPAGE=https://rrthomas.github.io/enchant/
CLANDRO_PKG_DESCRIPTION="Wraps a number of different spelling libraries and programs with a consistent interface"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.16"
CLANDRO_PKG_SRCURL=https://github.com/rrthomas/enchant/releases/download/v${CLANDRO_PKG_VERSION}/enchant-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d73162b5eff401a6397e1215e2b103bcef83f921c396c7f6b1394d2450d124e2
CLANDRO_PKG_DEPENDS="aspell, glib, hunspell, libc++"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-relocatable"

clandro_step_pre_configure() {
	local _libgcc="$($CC -print-libgcc-file-name)"
	LDFLAGS+=" -L$(dirname $_libgcc) -l:$(basename $_libgcc)"
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libenchant-2.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
