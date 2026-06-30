CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
CLANDRO_PKG_DESCRIPTION="GNU Internationalization utilities"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=71132a3fb71e68245b8f2ac4e9e97137d3e5c02f415636eb508ae607bc01add7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="attr, libc++, libiconv, libunistring, libxml2, ncurses"
CLANDRO_PKG_BREAKS="gettext-dev"
CLANDRO_PKG_REPLACES="gettext-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_decl_posix_spawn=no
ac_cv_header_spawn_h=no
gl_cv_func_working_error=yes
gl_cv_terminfo_tparm=yes
--disable-openmp
--with-included-libcroco
--with-included-libglib
--without-included-libxml
"
CLANDRO_PKG_GROUPS="base-devel"

clandro_step_pre_configure() {
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		LDFLAGS+=" -Wl,-z,muldefs"
	fi
}

clandro_step_post_configure() {
	local pv=$(awk '/^PACKAGE_VERSION =/ { print $3 }' Makefile)
	local lib
	for lib in libgettext{lib,src}; do
		ln -sf ${lib}-${pv}.so $CLANDRO_PREFIX/lib/${lib}.so
	done
}
