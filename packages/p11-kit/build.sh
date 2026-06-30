CLANDRO_PKG_HOMEPAGE="https://p11-glue.github.io/p11-glue/p11-kit.html"
CLANDRO_PKG_DESCRIPTION="Provides a way to load and enumerate PKCS#11 modules"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.26.2"
CLANDRO_PKG_SRCURL="https://github.com/p11-glue/p11-kit/releases/download/$CLANDRO_PKG_VERSION/p11-kit-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=09fd9f44da4813a3141e73d5e7cf7008e5660d0405f13d56c15e1da9dcecf828
CLANDRO_PKG_DEPENDS="libffi, libtasn1"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, bash-completion"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtrust_module=enabled
"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	# force meson
	rm configure

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
		sed \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$CLANDRO_PKG_BUILDER_DIR"/0001-workaround-asn1Parser-for-cross-compile.diff | patch -p1
	fi
}

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^P11KIT_'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
