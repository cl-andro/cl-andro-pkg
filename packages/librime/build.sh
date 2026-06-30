CLANDRO_PKG_HOMEPAGE=https://rime.im/
CLANDRO_PKG_DESCRIPTION="A modular, extensible input method engine in cross-platform C++ code"
CLANDRO_PKG_LICENSE="BSD 3-Clause, LGPL-3.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE, data/preset/LICENSE.PRELUDE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.16.1"
CLANDRO_PKG_SRCURL="https://github.com/rime/librime/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=944909b5d9fb81171b044b7f2ea89922bd73457fcc5105798a259173288cd2d9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, google-glog, leveldb, libc++, libopencc, libyaml-cpp, marisa"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, gflags, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TEST=OFF
-DBUILD_DATA=ON
"

clandro_step_post_get_source() {
	local _presetdir="$CLANDRO_PKG_SRCDIR"/data/preset/
	local _baseurl="https://raw.githubusercontent.com/rime/rime-prelude/dd84abecc33f0b05469f1d744e32d2b60b3529e3"
	mkdir -p "$_presetdir"

	clandro_download "$_baseurl"/default.yaml \
		"$_presetdir"/default.yaml \
		dd55653a991f9418eb425ee2112666f82e3e753c5ce3ed5702dd243041a45382
	clandro_download "$_baseurl"/key_bindings.yaml \
		"$_presetdir"/key_bindings.yaml \
		5c484257cccbab899bc874dfeb9257ce7190c99fee3abc33321767c8dac56af9
	clandro_download "$_baseurl"/punctuation.yaml \
		"$_presetdir"/punctuation.yaml \
		d6f89592149098f0a2d0ed3e5c83f49adb6226cdf1d967b0bc0d293f4e5c496a
	clandro_download "$_baseurl"/symbols.yaml \
		"$_presetdir"/symbols.yaml \
		22d6996edd5ac2dc60741d2f3727eec23919503273701e48f8509213ff3f2bd4
	clandro_download "$_baseurl"/LICENSE \
		"$_presetdir"/LICENSE.PRELUDE \
		da7eabb7bafdf7d3ae5e9f223aa5bdc1eece45ac569dc21b3b037520b4464768
}
