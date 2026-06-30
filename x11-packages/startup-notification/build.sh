CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="Utility libraries for XC Binding"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.12
CLANDRO_PKG_REVISION=29
CLANDRO_PKG_SRCURL=https://www.freedesktop.org/software/startup-notification/releases/startup-notification-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a
CLANDRO_PKG_DEPENDS="libx11, libxcb, xcb-util"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="lf_cv_sane_realloc=yes"
