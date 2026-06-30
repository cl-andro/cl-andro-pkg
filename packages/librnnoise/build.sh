CLANDRO_PKG_HOMEPAGE=https://jmvalin.ca/demo/rnnoise/
CLANDRO_PKG_DESCRIPTION="RNN-based noise suppression"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.xiph.org/xiph/rnnoise/-/archive/v$CLANDRO_PKG_VERSION/rnnoise-v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=fafc947fdd24109a6e72b5f25e4224b54bc74660a2620af5548def85be8c733a
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-examples
--disable-doc
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^OP_LT_'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed. Expected: $v, got: $_SOVERSION"
	fi

	bash download_model.sh
}

clandro_step_pre_configure() {
	autoreconf -fi
}
