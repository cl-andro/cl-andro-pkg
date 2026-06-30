CLANDRO_PKG_HOMEPAGE=https://bitbucket.org/verateam/vera
CLANDRO_PKG_DESCRIPTION="A programmable tool for verification, analysis and transformation of C++ source code"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL="https://github.com/verateam/vera/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=32d1d29be8ec96556fa0935d908d2627daffbf117abd1aa639f5a1c64ae10ceb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="boost, libc++, tcl"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DVERA_LUA=OFF
-DVERA_PYTHON=OFF
-DVERA_USE_SYSTEM_BOOST=ON
"

clandro_step_post_configure() {
	if [ "$CLANDRO_PKG_CMAKE_BUILD" = "Ninja" ]; then
		sed -i 's:[^ ]*/src/vera++ :true :g' build.ninja
	fi
}
