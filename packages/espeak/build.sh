CLANDRO_PKG_HOMEPAGE=https://github.com/espeak-ng/espeak-ng
CLANDRO_PKG_DESCRIPTION="Compact software speech synthesizer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Use eSpeak NG as the original eSpeak project is dead.
CLANDRO_PKG_VERSION="1.52.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/espeak-ng/espeak-ng/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=bb4338102ff3b49a81423da8a1a158b420124b055b60fa76cfb4b18677130a23
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, pcaudiolib"
CLANDRO_PKG_BREAKS="espeak-dev"
CLANDRO_PKG_REPLACES="espeak-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-async --with-pcaudiolib"

clandro_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if ${CLANDRO_ON_DEVICE_BUILD}; then
		clandro_error_exit "Package '${CLANDRO_PKG_NAME}' is not safe for on-device builds."
	fi

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local e=$(sed -En 's/^SHARED_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi

	./autogen.sh
}

clandro_step_host_build() {
	cd "${CLANDRO_PKG_SRCDIR}" || exit 1
	./configure && make
	# Man pages require the ronn ruby program.
	#make src/espeak-ng.1
	#cp src/espeak-ng.1 $CLANDRO_PREFIX/share/man/man1
	#(cd $CLANDRO_PREFIX/share/man/man1 && ln -s -f espeak-ng.1 espeak.1)
}

clandro_step_make() {
	make -B src/{e,}speak-ng
}

clandro_step_pre_configure() {
	# Oz flag causes problems. See https://github.com/termux/termux-packages/issues/1680:
	CFLAGS=${CFLAGS/-Oz/-Os}

	# ld.lld: error: non-exported symbol '__umoddi3' in arm and i686
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}

clandro_step_make_install() {
	# Calling make install directly tends to build lang data files again but with cross compiled espeak-ng.
	# So use make install-data which will install the data files compiled with previously built espeak-ng
	# in host build step.
	make install-data install-exec
}
