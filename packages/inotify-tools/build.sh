CLANDRO_PKG_HOMEPAGE=https://github.com/rvoicilas/inotify-tools/wiki
CLANDRO_PKG_DESCRIPTION="Programs providing a simple interface to inotify"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.25.9.0"
CLANDRO_PKG_SRCURL=https://github.com/rvoicilas/inotify-tools/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d33a4fd24c72c2d08893f129d724adf725b93dae96c359e4f4e9f32573cc853b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="inotify-tools-dev"
CLANDRO_PKG_REPLACES="inotify-tools-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	./autogen.sh
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	# the command-line tools needs the libinotifytools installed before building
	make -C libinotifytools install
	make install
}
