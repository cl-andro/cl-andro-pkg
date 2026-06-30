CLANDRO_PKG_HOMEPAGE=https://pagure.io/mlocate
CLANDRO_PKG_DESCRIPTION="Tool to find files anywhere in the filesystem based on their name"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# If not linking to libandroid-support we segfault in
# the libc mbsnrtowcs() function when using a wildcard
# like in '*.deb'.
CLANDRO_PKG_DEPENDS="libandroid-support"
CLANDRO_PKG_VERSION=0.26
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://releases.pagure.org/mlocate/mlocate-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e

clandro_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/mlocate/" >> postinst
	echo "if [ ! -e $CLANDRO_PREFIX/var/mlocate/mlocate.db ]; then" >> postinst
	echo "  echo Remember to run \\\`updatedb\\'." >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
