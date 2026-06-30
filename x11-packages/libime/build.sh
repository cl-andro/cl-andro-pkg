CLANDRO_PKG_HOMEPAGE=https://github.com/fcitx/libime
CLANDRO_PKG_DESCRIPTION="A library to support generic input method implementation"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.14"
CLANDRO_PKG_SRCURL=git+https://github.com/fcitx/libime
CLANDRO_PKG_GIT_BRANCH="${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_DEPENDS="boost, fcitx5, libc++, libime-data, zstd"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, boost-headers, extra-cmake-modules"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_DATA=OFF
-DENABLE_TEST=OFF
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
		patch -p1 -i "$CLANDRO_PKG_BUILDER_DIR"/data-CMakeLists.txt.diff
	fi
}

clandro_step_post_make_install() {
	echo -e "termux - building libime-data..."
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=' -DENABLE_DATA=ON'
	clandro_step_configure
	clandro_step_make

	# from add_custom_commands in data/CMakeLists.txt
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		pushd data
		termux-proot-run ../bin/libime_slm_build_binary -s -a 22 -q 8 trie lm_sc.arpa sc.lm
		termux-proot-run ../bin/libime_prediction sc.lm lm_sc.arpa sc.lm.predict
		termux-proot-run ../bin/libime_pinyindict dict_sc.txt sc.dict
		termux-proot-run ../bin/libime_pinyindict dict_extb.txt extb.dict
		declare -a files=(db.txt erbi.txt qxm.txt wanfeng.txt wbpy.txt wbx.txt zrm.txt cj.txt)
		for file in "${files[@]}"; do
			termux-proot-run ../bin/libime_tabledict "$file" "${file/.txt/.main.dict}"
		done
		popd
	fi

	clandro_step_make_install
}
