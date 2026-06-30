CLANDRO_PKG_HOMEPAGE=https://github.com/fcitx/fcitx5-chinese-addons
CLANDRO_PKG_DESCRIPTION="Addons related to Chinese, including IME previous bundled inside fcitx4"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.1.12"
CLANDRO_PKG_SRCURL="https://github.com/fcitx/fcitx5-chinese-addons/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b60de3b84dbb091f1301367ba9d2e8228735bf7a0ff125b738b8363c74b2ff32
CLANDRO_PKG_DEPENDS="boost, fcitx5, fcitx5-qt, libc++, libcurl, libime, libopencc, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, boost-headers, extra-cmake-modules"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_BROWSER=OFF
-DENABLE_DATA=OFF
-DENABLE_TEST=OFF
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
		patch -p1 -i "$CLANDRO_PKG_BUILDER_DIR"/im-pinyin-CMakeLists.txt.diff
	fi
}

clandro_step_post_make_install() {
	echo -e "termux - building fcitx5-chinese-addons dictionary..."
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=' -DENABLE_DATA=ON'
	clandro_step_configure
	clandro_step_make

	# from add_custom_commands in im/pinyin/CMakeLists.txt
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		pushd im/pinyin
		termux-proot-run "${CLANDRO_PREFIX}"/bin/libime_pinyindict "${CLANDRO_PKG_SRCDIR}"/im/pinyin/chaizi.txt chaizi.dict
		popd
	fi

	clandro_step_make_install
}
