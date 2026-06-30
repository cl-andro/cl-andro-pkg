CLANDRO_PKG_HOMEPAGE=https://www.alsa-project.org
CLANDRO_PKG_DESCRIPTION="The Advanced Linux Sound Architecture (ALSA) - utils"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.15.2"
CLANDRO_PKG_SRCURL="https://github.com/alsa-project/alsa-utils/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=9c989af53728efbe901f100ee02f36a550223322c56f82a66fa31c805b5f99ff
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="ncurses, alsa-lib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-udev-rules-dir=$CLANDRO_PREFIX/lib/udev/rules.d
--with-asound-state-dir=$CLANDRO_PREFIX/var/lib/alsa
--disable-bat
--disable-rst2man
"

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"
	export ACLOCAL_PATH="${CLANDRO_PREFIX}/share/aclocal"
	autoreconf -fi
}
