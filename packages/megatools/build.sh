CLANDRO_PKG_HOMEPAGE=https://xff.cz/megatools/
CLANDRO_PKG_DESCRIPTION="Open-source command line tools and C library (libmega) for accessing Mega.co.nz cloud storage"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.11.5.20250706
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://xff.cz/megatools/builds/megatools-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=51f78a03748a64b1066ce28a2ca75d98dbef5f00fe9789dc894827f9a913b362
CLANDRO_PKG_DEPENDS="glib, libandroid-support, libcurl, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dsymlinks=true
"
