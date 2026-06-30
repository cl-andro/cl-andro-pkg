CLANDRO_PKG_HOMEPAGE="http://voikko.sourceforge.net"
CLANDRO_PKG_DESCRIPTION="A spelling and grammar checker, hyphenator and collection of related linguistic data for Finnish language"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.puimula.org/voikko-sources/libvoikko/libvoikko-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d1162965c61de44f72162fd87ec1394bd4f90f87bc8152d13fe4ae692fdc73fa
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hfst=false
"

clandro_step_pre_configure() {
	# ld.lld: error: non-exported symbol '__aeabi_uidiv' in '/home/builder/.termux-build/_cache/android-r27b-api-24-v1/lib/clang/18/lib/linux/libclang_rt.builtins-arm-android.a(udivsi3.S.o)' is referenced by DSO '../.libs/libvoikko.so'
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
