CLANDRO_PKG_HOMEPAGE=https://mdocml.bsd.lv/
CLANDRO_PKG_DESCRIPTION="Man page viewer from the mandoc toolset"
CLANDRO_PKG_LICENSE="ISC, BSD 2-Clause, BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION=1.14.6
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=http://mdocml.bsd.lv/snapshots/mandoc-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8bf0d570f01e70a6e124884088870cbed7537f36328d512909eb10cd53179d9c
CLANDRO_PKG_DEPENDS="less, libandroid-glob, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS="man"
CLANDRO_PKG_REPLACES="man"
CLANDRO_PKG_PROVIDES="man"
CLANDRO_PKG_CONFFILES="etc/man.conf"
CLANDRO_PKG_RM_AFTER_INSTALL="share/examples"

clandro_step_pre_configure() {
	CPPFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
	LDFLAGS+=" -landroid-glob"
	# Stop trying to be smarter than you should be shellcheck.
	# We did mean CFLAGS not CPPFLAGS in that line.
	# shellcheck disable=SC2153
	{
		echo "PREFIX=\"$CLANDRO_PREFIX\""
		echo "CC=\"$CC\""
		echo "MANDIR=\"$CLANDRO_PREFIX/share/man\""
		echo "CFLAGS=\"$CFLAGS -std=c99 -DNULL=0 $CPPFLAGS\""
		echo "LDFLAGS=\"$LDFLAGS\""
		for HAVING in 'HAVE_STRLCAT' 'HAVE_STRLCPY' 'HAVE_SYS_ENDIAN' 'HAVE_ENDIAN' 'HAVE_NTOHL' 'HAVE_NANOSLEEP' 'HAVE_O_DIRECTORY' 'HAVE_ISBLANK'; do
			echo "$HAVING=1"
		done
	} > configure.local
}

clandro_step_post_massage() {
	mkdir -p etc
	echo "manpath	$CLANDRO_PREFIX/share/man" > etc/man.conf
}

clandro_step_create_debscripts() {
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "debian" ]]; then
		echo "interest-noawait $CLANDRO_PREFIX/share/man" > triggers
		{
			echo "#!$CLANDRO_PREFIX/bin/sh"
			echo "makewhatis -Q"
			echo "exit 0"
		} > postinst
	fi
}
