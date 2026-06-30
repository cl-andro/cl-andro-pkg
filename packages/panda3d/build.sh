CLANDRO_PKG_HOMEPAGE=https://www.panda3d.org/
CLANDRO_PKG_DESCRIPTION="A framework for 3D rendering and game development for Python and C++ programs"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.16"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/panda3d/panda3d/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=25d04b2b6ab2c45a0b0cc3ba7a01aa66aabc0e4473b2aa83038e1d61ce1ece2e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, python"
CLANDRO_PKG_BUILD_DEPENDS="libandroid-glob"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/panda3d"
}

clandro_step_make() {
	local PANDA_ARCH="${CLANDRO_ARCH}"
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		PANDA_ARCH="x86"
	fi
	python makepanda/makepanda.py \
		--arch "$PANDA_ARCH" \
		--nothing \
		--threads "${CLANDRO_PKG_MAKE_PROCESSES}"
}

clandro_step_make_install() {
	python makepanda/installpanda.py --prefix $CLANDRO_PREFIX
}
