CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
CLANDRO_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages (legacy v2.13)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.13
CLANDRO_PKG_SRCURL=http://ftp.gnu.org/gnu/autoconf/autoconf-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f0611136bee505811e9ca11ca7ac188ef5323a8e2ef19cffd3edb3cf08fd791e
CLANDRO_PKG_DEPENDS="m4, make, perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--program-suffix=-2.13"

clandro_step_post_get_source() {
	perl -p -i -e "s|/bin/sh|$CLANDRO_PREFIX/bin/sh|" *.m4
}

clandro_step_post_massage() {
	perl -p -i -e "s|/usr/bin/m4|$CLANDRO_PREFIX/bin/m4|" $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$CLANDRO_PREFIX/bin/sh|" $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/bin/autoconf-2.13
}
