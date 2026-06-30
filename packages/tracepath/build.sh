CLANDRO_PKG_HOMEPAGE=https://github.com/iputils/iputils
CLANDRO_PKG_DESCRIPTION="Tool to trace the network path to a remote host"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20250605"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/iputils/iputils/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=19e680c9eef8c079da4da37040b5f5453763205b4edfb1e2c114de77908927e4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d{8}"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	return
}

clandro_step_make() {
	return
}

clandro_step_make_install() {
	CPPFLAGS+=" -DPACKAGE_VERSION=\"$CLANDRO_PKG_VERSION\" -DHAVE_ERROR_H"
	$CC $CFLAGS $CPPFLAGS $LDFLAGS -o $CLANDRO_PREFIX/bin/tracepath iputils_common.c tracepath.c

	local MANDIR=$CLANDRO_PREFIX/share/man/man8
	mkdir -p $MANDIR
	cd $CLANDRO_PKG_SRCDIR/doc
	xsltproc \
		--stringparam man.output.quietly 1 \
		--stringparam funcsynopsis.style ansi \
		--stringparam man.th.extra1.suppress 1 \
		--stringparam iputils.version $CLANDRO_PKG_VERSION \
		custom-man.xsl \
		tracepath.xml
	cp tracepath.8 $MANDIR/

	# `traceroute` command is now provided by the package of the same name.
	# Please do not make `traceroute` an alias of `tracepath`.
}
