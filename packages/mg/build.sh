CLANDRO_PKG_HOMEPAGE=https://github.com/hboetes/mg
CLANDRO_PKG_DESCRIPTION="microscopic GNU Emacs-style editor"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20260227"
CLANDRO_PKG_SRCURL=https://github.com/hboetes/mg/archive/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=21877e912a63c69253538dc8ba6ae3beb1c89f35222e8381d14320f6537cec89
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d{8}"
CLANDRO_PKG_DEPENDS="libbsd, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# force make
	rm CMakeLists.txt meson.build
}

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -fcommon"
}
