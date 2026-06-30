CLANDRO_PKG_HOMEPAGE=https://www.isc.org/bind/
CLANDRO_PKG_DESCRIPTION="Clients provided with BIND"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.20.22"
CLANDRO_PKG_SRCURL="https://downloads.isc.org/isc/bind9/${CLANDRO_PKG_VERSION}/bind-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=cba92ff631b949655f475fe4b54290f6860fd0070d399f2279f6437c0d383ec6
CLANDRO_PKG_DEPENDS="cmocka, json-c, krb5, libandroid-execinfo, libandroid-glob, libcap, libnghttp2, liburcu, libuv, libxml2, openssl, readline, resolv-conf, zlib"
CLANDRO_PKG_BREAKS="dnsutils-dev"
CLANDRO_PKG_REPLACES="dnsutils-dev"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ax_cv_have_func_attribute_constructor=yes
ax_cv_have_func_attribute_destructor=yes
lt_cv_prog_compiler_pic_works=yes
--disable-static
--with-json-c
--with-libxml2
--with-liburcu=qsbr
--enable-developer
"

clandro_step_pre_configure() {
	_RESOLV_CONF=$CLANDRO_PREFIX/etc/resolv.conf
	CFLAGS+=" $CPPFLAGS -DRESOLV_CONF=\\\"$_RESOLV_CONF\\\""
	LDFLAGS+=" -landroid-glob"
}

clandro_step_post_configure() {
	# Android linker is unable to directly resolve versioned libraries.
	# This will create a symlink to versioned library via `libname.so`.
	sed -i 's|library_names_spec=.*|library_names_spec="\\\$libname\\\$release\\\$shared_ext \\\$libname\\\$shared_ext"|g' ./libtool
}
