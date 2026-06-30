CLANDRO_PKG_HOMEPAGE=https://tsduck.io/
CLANDRO_PKG_DESCRIPTION="An extensible toolkit for MPEG transport streams"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.43.4549"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/tsduck/tsduck/archive/refs/tags/v$(sed 's/\./-/2' <<< "$CLANDRO_PKG_VERSION").tar.gz"
CLANDRO_PKG_SHA256=a3399661d21e0d965dfef3750d4af7da61eb2924e7b48ee3edaae194ffa5203c
CLANDRO_PKG_DEPENDS="libandroid-glob, libc++, libcurl, libedit"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/-/./"
CLANDRO_PKG_EXTRA_MAKE_ARGS="
ALTDEVROOT=${CLANDRO_PREFIX}
CROSS=1
CROSS_TARGET=${CLANDRO_ARCH}
NOCURL=
NODEKTEC=1
NOEDITLINE=
NOGITHUB=1
NOHIDES=
NOPCSC=1
NORIST=1
NOSRT=1
NOTELETEXT=1
NOTEST=1
NOVATEK=1
SYSPREFIX=${CLANDRO_PREFIX}
USELIB64=
CXXFLAGS_WARNINGS=
NATIVEBINDIR=$CLANDRO_PKG_HOSTBUILD_DIR/bin/release
"
CLANDRO_PKG_RM_AFTER_INSTALL="
etc/security
etc/udev
"

clandro_step_post_get_source() {
	# Needs to call `clandro_step_configure_autotools` for `*-config` hack.
	touch configure
	chmod u+x configure
}

clandro_step_host_build() {
	find $CLANDRO_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	make -j $CLANDRO_PKG_MAKE_PROCESSES \
		NOCURL=1 \
		NODEKTEC=1 \
		NOEDITLINE=1 \
		NOGITHUB=1 \
		NOHIDES=1 \
		NOPCSC=1 \
		NORIST=1 \
		NOSRT=1 \
		NOTELETEXT=1 \
		NOTEST=1 \
		NOVATEK=1
}

clandro_step_pre_configure() {
	PATH=$CLANDRO_PKG_HOSTBUILD_DIR/bin/release:$PATH

	CXXFLAGS+=" -fno-strict-aliasing"
	LDFLAGS+=" -landroid-glob"
}

clandro_step_make() {
	sed \
		-e "s|\$(search-cross g++)|${CXX}|g" \
		-e "s|\$(search-cross gcc)|${CC}|g" \
		-e "s|\$(search-cross ld)|${LD}|g" \
		-i ${CLANDRO_PKG_SRCDIR}/scripts/make-config.sh
	make -j $CLANDRO_PKG_MAKE_PROCESSES \
		CXX="$CXX" \
		GCC="$CC" \
		LD="$LD" \
		CXXFLAGS_CROSS="$CXXFLAGS $CPPFLAGS" \
		LDFLAGS_CROSS="$LDFLAGS" \
		${CLANDRO_PKG_EXTRA_MAKE_ARGS}
}
