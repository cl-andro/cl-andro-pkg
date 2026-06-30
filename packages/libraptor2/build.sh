CLANDRO_PKG_HOMEPAGE=https://librdf.org/raptor/
CLANDRO_PKG_DESCRIPTION="RDF Syntax Library"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.LIB, LICENSE-2.0.txt, LICENSE.txt, NOTICE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.16
CLANDRO_PKG_REVISION=10
CLANDRO_PKG_SRCURL=https://download.librdf.org/source/raptor2-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=089db78d7ac982354bdbf39d973baf09581e6904ac4c92a98c5caadb3de44680
CLANDRO_PKG_DEPENDS="libcurl, libicu, libxml2, libxslt, yajl"
CLANDRO_PKG_BUILD_DEPENDS="icu-devtools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-icu-config=icu-config
--with-yajl=$CLANDRO_PREFIX
"

clandro_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}

clandro_step_post_massage() {
	# For backward compatibility. Rebuild revdeps and delete this.
	cd ${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib || exit 1
	if [ ! -e "./libraptor2.so.0" ]; then
		ln -sf libraptor2.so libraptor2.so.0
	fi
}
