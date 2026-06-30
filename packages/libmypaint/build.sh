CLANDRO_PKG_HOMEPAGE=https://github.com/mypaint/libmypaint
CLANDRO_PKG_DESCRIPTION="MyPaint brush engine library"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/mypaint/libmypaint/releases/download/v${CLANDRO_PKG_VERSION}/libmypaint-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=741754f293f6b7668f941506da07cd7725629a793108bb31633fb6c3eae5315f
CLANDRO_PKG_DEPENDS="glib, json-c"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
--with-glib
ac_cv_func_bind_textdomain_codeset=yes
ac_cv_search_dgettext=yes
gt_cv_func_dgettext_libc=yes
gt_cv_func_ngettext_libc=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}

clandro_step_post_configure() {
	# What is this?
	find . -name Makefile | xargs -n 1 sed -i 's/ yes -lm/ -lm/g'
}
