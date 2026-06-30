CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/xfce4-panel-profiles/start
CLANDRO_PKG_DESCRIPTION="A simple application to manage Xfce panel layouts."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://archive.xfce.org/src/apps/xfce4-panel-profiles/${CLANDRO_PKG_VERSION%.*}/xfce4-panel-profiles-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=0126373a03778bb4894afa151de28d36bfc563ddab96d3bd7c63962350d34ba2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gtk3, libxfce4ui, libxfce4util, pygobject, python, python-pip, python-psutil, xfce4-panel"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	# from configure
	sed -e s,@prefix@,$CLANDRO_PREFIX, Makefile.in.in > Makefile.in
	sed \
		-e s,@appname@,xfce4-panel-profiles,g \
		-e s,@version@,$CLANDRO_PKG_VERSION,g \
		-e s,@mandir@,$CLANDRO_PREFIX/share/man,g \
		-e s,@docdir@,$CLANDRO_PREFIX/share/doc/xfce4-panel-profiles,g \
		-e s,@python@,$CLANDRO_PREFIX/bin/python,g \
		Makefile.in > Makefile
	sed \
		-e s,@VERSION@,$CLANDRO_PKG_VERSION,g \
		-e s,@COPYRIGHT_YEAR@,2025,g \
	xfce4-panel-profiles.1.in > xfce4-panel-profiles.1
}
