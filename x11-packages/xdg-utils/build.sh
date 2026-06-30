CLANDRO_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/xdg-utils/
CLANDRO_PKG_DESCRIPTION="A set of simple scripts that provide basic desktop integration functions for any Free Desktop"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v${CLANDRO_PKG_VERSION}/xdg-utils-v${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=93d510dccf328378f012fe195b4574c2fac1cd65a74d0852d6eaa72e5a2065a7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="desktop-file-utils, file, make, perl, shared-mime-info, which, xorg-xprop"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/xdg-screensaver
share/man/man1/xdg-screensaver.1
"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_post_make_install() {
	# `bin/xdg-open` conflicts with termux-tools.
	mv $CLANDRO_PREFIX/bin/{,xdg-utils-}xdg-open
	mv $CLANDRO_PREFIX/share/man/man1/{,xdg-utils-}xdg-open.1
}

clandro_step_create_debscripts() {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl File::MimeInfo ..."
	cpan -Ti File::MimeInfo

	exit 0
	POSTINST_EOF
}
