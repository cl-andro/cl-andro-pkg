CLANDRO_PKG_HOMEPAGE=https://www.ruby-lang.org/
CLANDRO_PKG_DESCRIPTION="Dynamic programming language with a focus on simplicity and productivity"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
# Packages which should be rebuilt after "minor" bump (e.g. 3.1.x to 3.2.0):
# - asciidoctor
# - weechat
CLANDRO_PKG_VERSION="3.4.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://cache.ruby-lang.org/pub/ruby/$(echo $CLANDRO_PKG_VERSION | cut -d . -f 1-2)/ruby-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=018d59ffb52be3c0a6d847e22d3fd7a2c52d0ddfee249d3517a0c8c6dbfa70af
# libbffi is used by the fiddle extension module:
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libandroid-support, libffi, libgmp, readline, openssl, libyaml, zlib"
CLANDRO_PKG_RECOMMENDS="clang, make, pkg-config, resolv-conf"
CLANDRO_PKG_BREAKS="ruby-dev"
CLANDRO_PKG_REPLACES="ruby-dev"
# Needed to fix compilation on android:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setgroups=no ac_cv_func_setresuid=no ac_cv_func_setreuid=no --enable-rubygems"
# Do not link in libcrypt.so if available (now in disabled-packages):
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# Fix DEPRECATED_TYPE macro clang compatibility:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_type_deprecated=x"
# getresuid(2) does not work on ChromeOS - https://github.com/termux/termux-app/issues/147:
# CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getresuid=no"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--prefix=$CLANDRO_PKG_HOSTBUILD_DIR/ruby-host
--disable-install-doc
--disable-install-rdoc
--disable-install-capi
"

clandro_step_host_build() {
	"$CLANDRO_PKG_SRCDIR/configure" ${CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
}

clandro_step_pre_configure() {
	_RUBY_API_VERSION=$(echo $CLANDRO_PKG_VERSION | cut -d . -f 1-2).0
	test ${_RUBY_ABI_VERSION:=} && _RUBY_API_VERSION+=+${_RUBY_ABI_VERSION}

	echo "Applying tool-rbinstall.rb.diff"
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@RUBY_API_VERSION@|${_RUBY_API_VERSION}|g" \
		$CLANDRO_PKG_BUILDER_DIR/tool-rbinstall.rb.diff \
		| patch --silent -p1

	autoreconf -fi

	export PATH=$CLANDRO_PKG_HOSTBUILD_DIR/ruby-host/bin:$PATH

	if [ "$CLANDRO_ARCH_BITS" = 32 ]; then
		# process.c:function timetick2integer: error: undefined reference to '__mulodi4'
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_builtin___builtin_mul_overflow=no"
	fi

	# Do not remove: fix for Clang's "overoptimization".
	CFLAGS+=" -fno-strict-aliasing"
}

clandro_step_make_install() {
	make install
	make uninstall # remove possible remains to get fresh timestamps
	make install

	local RBCONFIG=$CLANDRO_PREFIX/lib/ruby/${_RUBY_API_VERSION}/${CLANDRO_HOST_PLATFORM}/rbconfig.rb

	# Fix absolute paths to executables:
	perl -p -i -e 's/^.*CONFIG\["INSTALL"\].*$/  CONFIG["INSTALL"] = "install -c"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["PKG_CONFIG"\].*$/  CONFIG["PKG_CONFIG"] = "pkg-config"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MAKEDIRS"\].*$/  CONFIG["MAKEDIRS"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MKDIR_P"\].*$/  CONFIG["MKDIR_P"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["EGREP"\].*$/  CONFIG["EGREP"] = "grep -E"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["GREP"\].*$/  CONFIG["GREP"] = "grep"/' $RBCONFIG
}

clandro_step_post_massage() {
	local _RUBYGEMS_ARCH=${CLANDRO_HOST_PLATFORM/i686-/x86-}
	if [ ! -d ./lib/ruby/gems/${_RUBY_API_VERSION}/extensions/${_RUBYGEMS_ARCH} ]; then
		clandro_error_exit "Extensions for bundled gems were not installed."
	fi
}
