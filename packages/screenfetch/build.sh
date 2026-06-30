CLANDRO_PKG_HOMEPAGE=https://github.com/KittyKatt/screenFetch
CLANDRO_PKG_DESCRIPTION="Bash Screenshot Information Tool"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.9.9"
CLANDRO_PKG_SRCURL=https://github.com/KittyKatt/screenFetch/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=65ba578442a5b65c963417e18a78023a30c2c13a524e6e548809256798b9fb84
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install screenfetch-dev ${CLANDRO_PREFIX}/bin/screenfetch
	install screenfetch.1 ${CLANDRO_PREFIX}/share/man/man1/
}
