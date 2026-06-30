##
## Since Termux is continuing to use APT as package manager, abuild & apk-tools
## are disabled because don't have real use-cases currently.
##

## TODO: restore fakeroot functionality
CLANDRO_PKG_HOMEPAGE=https://github.com/alpinelinux/abuild
CLANDRO_PKG_DESCRIPTION="Build script to build Alpine packages"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.4.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/alpinelinux/abuild/archive/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f6f704e34f9d388a0228b645050dc7db7bf92f15a088835ae2c9b244420b9b61
CLANDRO_PKG_DEPENDS="apk-tools, autoconf, automake, bash, clang, curl, libtool, make, openssl-tool, pkg-config, tar, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="sysconfdir=$CLANDRO_PREFIX/etc"
CLANDRO_PKG_CONFFILES="etc/abuild.conf"

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/abuild-adduser
bin/abuild-addgroup
bin/abuild-apk
bin/abuild-sudo
bin/buildlab
"

clandro_step_post_make_install() {
    install -Dm600 "$CLANDRO_PKG_SRCDIR/abuild.conf" "$CLANDRO_PREFIX/etc/abuild.conf"
}
