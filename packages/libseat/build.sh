CLANDRO_PKG_HOMEPAGE=https://sr.ht/~kennylevinsen/seatd/
CLANDRO_PKG_DESCRIPTION="Reference implementation of a wayland compositor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.3"
CLANDRO_PKG_SRCURL=https://github.com/kennylevinsen/seatd/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=302564d54d8e28191fadfd734f2675ecb0c9e0615a58011b89ef15dfa4dbaa96
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
# -Dman-pages=disabled prevents
# Exec format error: '/data/data/com.zk.clandro/files/usr/bin/scdoc'
# if scdoc package was installed in the same container before cross-compiling
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddefaultpath=$CLANDRO_PREFIX/var/run/seatd.sock
-Dman-pages=disabled
"
