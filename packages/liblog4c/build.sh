CLANDRO_PKG_HOMEPAGE=https://log4c.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A C library for flexible logging to files, syslog and other destinations"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.4
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=http://prdownloads.sourceforge.net/log4c/log4c-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5991020192f52cc40fa852fbf6bbf5bd5db5d5d00aa9905c67f6f0eadeed48ea
CLANDRO_PKG_DEPENDS="libexpat"

clandro_step_pre_configure() {
	autoreconf -fi
}
