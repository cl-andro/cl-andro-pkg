CLANDRO_PKG_HOMEPAGE=https://core.tcl-lang.org/tcllib/
CLANDRO_PKG_DESCRIPTION="Tcl Standard Library"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="license.terms"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0"
CLANDRO_PKG_SRCURL=https://core.tcl-lang.org/tcllib/uv/tcllib-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=642c2c679c9017ab6fded03324e4ce9b5f4292473b62520e82aacebb63c0ce20
CLANDRO_PKG_DEPENDS="tcl"
CLANDRO_PKG_RECOMMENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_configure() {
	true
}

clandro_step_make() {
	true
}

clandro_step_make_install() {
	tclsh installer.tcl \
		-pkg-path ${CLANDRO_PREFIX}/lib/tcllib${CLANDRO_PKG_VERSION} \
		-app-path ${CLANDRO_PREFIX}/bin \
		-nroff-path ${CLANDRO_PREFIX}/share/man/mann \
		-no-examples \
		-no-html \
		-no-wait \
		-no-gui
}
