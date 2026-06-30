CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/recutils/
CLANDRO_PKG_DESCRIPTION="Set of tools and libraries to access human-editable, plain text databases called recfiles"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.9
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/recutils/recutils-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6301592b0020c14b456757ef5d434d49f6027b8e5f3a499d13362f205c486e0e
# Prevent libandroid-spawn from being picked up
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_spawn_h=no"
CLANDRO_PKG_EXTRA_MAKE_ARGS="lispdir=${CLANDRO_PREFIX}/share/emacs/site-lisp"
