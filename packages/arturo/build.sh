CLANDRO_PKG_HOMEPAGE=https://arturo-lang.io
CLANDRO_PKG_DESCRIPTION="Simple, expressive & portable programming language for efficient scripting"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Komo @mbekkomo"
CLANDRO_PKG_VERSION=0.9.83
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/arturo-lang/arturo/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0bb3632f21a1556167fdcb82170c29665350beb44f15b4666b4e22a23c2063cf
CLANDRO_PKG_DEPENDS="libgmp, libmpfr, libandroid-glob, libsqlite"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" -Wno-incompatible-function-pointer-types"
	LDFLAGS+=" -landroid-glob"
	sed -i \
		-e "s|@CLANDRO_STANDALONE_TOOLCHAIN@|${CLANDRO_STANDALONE_TOOLCHAIN}|g" \
		-e "s|@CLANDRO_HOST_PLATFORM@|${CLANDRO_HOST_PLATFORM}-|g" \
		-e "s|@CFLAGS@|${CPPFLAGS} ${CFLAGS}|g" \
		-e "s|@LDFLAGS@|${LDFLAGS}|g" \
		"${CLANDRO_PKG_SRCDIR}/build.nims"
}

clandro_step_configure() {
	# Arturo 0.9.83 can only build with Nim 1.6.20
	export CHOOSENIM_CHOOSE_VERSION=1.6.20
	curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
	export PATH="$HOME/.nimble/bin:$PATH"
}

clandro_step_make() {
	declare arch=${CLANDRO_ARCH}
	case "${arch}" in
	aarch64) arch=arm64 ;;
	i686) arch=x86 ;;
	esac

	nimble install -y smtp

	NIMFLAGS=""
	sed -i "s|@NIMFLAGS@|${NIMFLAGS}|g" build.nims

	nim build.nims install full "${arch}" noinstall release log \
		nowebview \
		noclipboard
}

clandro_step_make_install() {
	install -Dm700 bin/arturo "${CLANDRO_PREFIX}/bin/arturo"
}
