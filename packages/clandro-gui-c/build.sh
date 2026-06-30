CLANDRO_PKG_HOMEPAGE="https://github.com/tareksander/clandro-gui-c-bindings"
CLANDRO_PKG_DESCRIPTION="A C library for the Termux:GUI plugin"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@tareksander"
CLANDRO_PKG_VERSION="0.1.3"
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_DEPENDS="abseil-cpp, libc++, libandroid-stub, libprotobuf"
CLANDRO_PKG_SRCURL="https://github.com/tareksander/clandro-gui-c-bindings/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=7781fdbd37ca1376b4c2339440976b0aa00cc2188592ea51438e473589db466f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	clandro_setup_protobuf
	export SHARED_BUILD=1
}
