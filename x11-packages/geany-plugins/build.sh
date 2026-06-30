CLANDRO_PKG_HOMEPAGE=https://plugins.geany.org/install.html
CLANDRO_PKG_DESCRIPTION="This is a plug-in for the editor Geany"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://plugins.geany.org/geany-plugins/geany-plugins-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=77ec3da07be809357ba9c986e9b72d2eca343008ccc0793673c9dcac2ad8dae1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="geany"
# --disable-markdown avoids:
# /bin/bash: line 1: peg-0.1.9/leg: cannot execute binary file: Exec format error
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-markdown
"
