CLANDRO_PKG_HOMEPAGE=https://fastcgi-archives.github.io/
CLANDRO_PKG_DESCRIPTION="A language independent, high performant extension to CGI"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4.7
CLANDRO_PKG_SRCURL="https://github.com/FastCGI-Archives/fcgi2/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e41ddc3a473b555bdc0cbd80703dcb1f4610c1a7700d3b9d3d0c14a416e1074b
CLANDRO_PKG_BREAKS="fcgi-dev"
CLANDRO_PKG_REPLACES="fcgi-dev"

clandro_step_pre_configure() {
	libtoolize --automake --copy --force
	aclocal
	autoheader
	automake --add-missing --force-missing --copy
	autoconf
	export LIBS="-lm"
}
