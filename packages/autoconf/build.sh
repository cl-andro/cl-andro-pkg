CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
CLANDRO_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.73"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/autoconf/autoconf-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9fd672b1c8425fac2fa67fa0477b990987268b90ff36d5f016dae57be0d6b52e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="m4, make, perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_GROUPS="base-devel"

clandro_step_post_get_source() {
	perl -p -i -e "s|/bin/sh|$CLANDRO_PREFIX/bin/sh|" lib/*/*.m4
}

clandro_step_post_massage() {
	perl -p -i -e "s|/usr/bin/m4|$CLANDRO_PREFIX/bin/m4|" bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$CLANDRO_PREFIX/bin/sh|" bin/autoconf
}
