CLANDRO_PKG_HOMEPAGE=https://github.com/gnosek/fcgiwrap
CLANDRO_PKG_DESCRIPTION="A simple server for running CGI applications over FastCGI"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_VERSION="1.1.0+g99c942c"
CLANDRO_PKG_SRCURL="https://github.com/gnosek/fcgiwrap/archive/${CLANDRO_PKG_VERSION##*+g}.tar.gz"
CLANDRO_PKG_SHA256=c72f2933669ebd21605975c5a11f26b9739e32e4f9d324fb9e1a1925e9c2ae88
CLANDRO_PKG_REPOLOGY_METADATA_VERSION="${CLANDRO_PKG_VERSION%%+*}"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_DEPENDS="fcgi"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--mandir=/share/man"

clandro_step_pre_configure() {
	autoreconf -i
}
