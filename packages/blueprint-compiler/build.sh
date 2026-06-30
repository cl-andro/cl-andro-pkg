CLANDRO_PKG_HOMEPAGE=https://gnome.pages.gitlab.gnome.org/blueprint-compiler/
CLANDRO_PKG_DESCRIPTION="Markup language for GTK user interfaces"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.20.4"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/blueprint-compiler/${CLANDRO_PKG_VERSION%.*}/blueprint-compiler-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=1f1ecc84bcd698902d422f7de83d39229a209dd3016f6d2c3b0ed0ab123f6891
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gobject-introspection, python, pygobject"

clandro_step_pre_configure() {
	clandro_setup_python_pip
}
