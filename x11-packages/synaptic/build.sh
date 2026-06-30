CLANDRO_PKG_HOMEPAGE=https://www.nongnu.org/synaptic/
CLANDRO_PKG_DESCRIPTION="Synaptic is a graphical package management tool based on GTK+ and APT."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="0.91.7"
CLANDRO_PKG_SRCURL=https://github.com/mvo5/synaptic/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6da82e1ff9f0bd00b34db02ea7d291caeeb546303ba639a8e32ebac8a5db6ccf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="apt, dpkg, gdk-pixbuf, glib, gtk3, libc++, libvte, pango"
CLANDRO_PKG_RECOMMENDS="hicolor-icon-theme, netsurf"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure(){
	NOCONFIGURE=1 ./autogen.sh
	# Fix "error: no template named binary_function" (binary_function was removed in c++17):
	CXXFLAGS+=" -std=c++14"
}


clandro_step_post_make_install(){
	install -Dm700 -t ${CLANDRO_PREFIX}/bin ./gtk/synaptic
}
