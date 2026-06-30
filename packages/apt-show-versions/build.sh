CLANDRO_PKG_HOMEPAGE=https://salsa.debian.org/debian/apt-show-versions
CLANDRO_PKG_DESCRIPTION="Lists available package versions with distribution"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.22.16"
CLANDRO_PKG_SRCURL="https://salsa.debian.org/debian/apt-show-versions/-/archive/$CLANDRO_PKG_VERSION/apt-show-versions-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=15308503b113209a551e495f9ca8cf002acf8d3e4ce31df58e1fcc4fa7713310
CLANDRO_PKG_DEPENDS="apt, libapt-pkg-perl, perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$CLANDRO_PREFIX
INSTALLSITEMAN1DIR=$CLANDRO_PREFIX/share/man/man1
INSTALLSITEMAN3DIR=$CLANDRO_PREFIX/share/man/man3
"

# for some reason, make install installs some weird files in lib,
# then before the package is finalized, the lib folder needs to be removed.
# this behavior and build process is identifiable as intended, since it is
# ported directly from the behavior of the Debian build script:
# https://salsa.debian.org/debian/apt-show-versions/-/blob/c500448e886a96f75770bbb59570e95c8e77802c/debian/rules#L61
CLANDRO_PKG_RM_AFTER_INSTALL="lib"
# install step may pollute lib folder with weird perl files
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

# the original creator of perl.makemaker decided in 2003 that formal accomodation
# of distros like Termux that can be described as "distros with timestamp-based packaging systems"
# is undesirable because such a distro was either unheard of to them at the time, or
# they imagined the hypothetical possibility of the present or future existence of such a distro
# as an unsupportable edge case,
# so the Makefile that perl.makemaker generates will not reliably install everything
# unless all desired files are forcibly removed before make install is invoked
# https://www.nntp.perl.org/group/perl.makemaker/2003/04/msg1092.html

# files that should be in $CLANDRO_PREFIX after make install
_MAKE_INSTALL_PROVIDED_FILES="
bin/apt-show-versions
share/man/man1/apt-show-versions.1p
"

clandro_step_pre_configure() {
	pushd "$CLANDRO_PREFIX"
	rm -f $_MAKE_INSTALL_PROVIDED_FILES
	popd
}

# clandro_step_configure() for Makefile.PLs based on package perl-rename
clandro_step_configure() {
	perl Makefile.PL $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_post_make_install() {
	install -D --mode=644 "$CLANDRO_PKG_SRCDIR/debian/apt-show-versions.apt.conf" \
		"$CLANDRO_PREFIX/etc/apt/apt.conf.d/20apt-show-versions"

	install -D --mode=644 "$CLANDRO_PKG_SRCDIR/debian/apt-show-versions.bash-completion" \
		"$CLANDRO_PREFIX/share/bash-completion/completions/apt-show-versions"
}

clandro_step_create_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	if [ "$CLANDRO_PACKAGE_FORMAT" = "debian" ] && [ "\$1" != "configure" ]; then
		exit 0
	fi
	echo "** initializing cache. This may take a while **"
	apt-show-versions -i
	exit 0
	POSTINST_EOF

	cat <<- PRERM_EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	if [ "$CLANDRO_PACKAGE_FORMAT" = "debian" ] && [ "\$1" != "remove" ]; then
		exit 0
	fi
	rm -rf $CLANDRO_PREFIX/var/cache/apt-show-versions
	exit 0
	PRERM_EOF
}
