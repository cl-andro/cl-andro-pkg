# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE="https://github.com/containers/bubblewrap"
CLANDRO_PKG_DESCRIPTION="Unprivileged sandboxing tool"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.11.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/containers/bubblewrap/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=cfeeb15fcc47d177d195f06fdf0847e93ee3aa6bf46f6ac0a141fa142759e2c3
CLANDRO_PKG_DEPENDS="libcap, bash-completion"
CLANDRO_PKG_BUILD_DEPENDS="docbook-xsl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS='
-Dselinux=disabled
'
# patch was based on v0.6.2
CLANDRO_PKG_AUTO_UPDATE=false
