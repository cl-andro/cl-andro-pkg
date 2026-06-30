CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/groff/
CLANDRO_PKG_DESCRIPTION="typesetting system that reads plain text mixed with formatting commands and produces formatted output"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.23.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/groff/groff-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6b9757f592b7518b4902eb6af7e54570bdccba37a871fddb2d30ae3863511c13
CLANDRO_PKG_DEPENDS="libc++, perl, mandoc"
CLANDRO_PKG_GROUPS="base-devel"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
am_cv_func_iconv=no
"
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/soelim
share/man/man1/soelim.1*
share/man/man7/roff.7*
"

clandro_step_pre_configure() {
	sed -i "s|@abs_top_builddir@|${CLANDRO_TOPDIR}/groff/host-build|" Makefile.in
}

clandro_step_post_make_install() {
	install -Dm600 $CLANDRO_PKG_HOSTBUILD_DIR/font/devpdf/[A-CEG-Z]* \
		$CLANDRO_PREFIX/share/groff/current/font/devpdf/
}
