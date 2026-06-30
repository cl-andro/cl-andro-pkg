CLANDRO_PKG_HOMEPAGE=https://hunspell.github.io
CLANDRO_PKG_DESCRIPTION="Spell checker"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.3"
CLANDRO_PKG_SRCURL=https://github.com/hunspell/hunspell/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=933be3dac6fd55f6e752331a170efb7e33800e40fae1156d8434cc8c85379a1b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libiconv, ncurses, readline, hunspell-en-us"
CLANDRO_PKG_BREAKS="hunspell-dev"
CLANDRO_PKG_REPLACES="hunspell-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-ui --with-readline"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -vfi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libhunspell-1.7.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
