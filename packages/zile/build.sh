CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/zile/
CLANDRO_PKG_DESCRIPTION="Lightweight clone of the Emacs text editor"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/zile/zile-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d5d44b85cb490643d0707e1a2186f3a32998c2f6eabaa9481479b65caeee57c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libgee, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
gl_cv_have_weak=no
"

clandro_step_post_configure() {
	# zile uses help2man to build the zile.1 man page, which would require
	# a host build.
	sed 's|@docdir@|$PREFIX/share/doc/zile|g' \
		"$CLANDRO_PKG_SRCDIR/doc/zile.1.in" \
		> "$CLANDRO_PKG_BUILDDIR/doc/zile.1"
	touch -d "next hour" "$CLANDRO_PKG_BUILDDIR/doc/zile.1"*
}
