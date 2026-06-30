CLANDRO_PKG_HOMEPAGE=https://github.com/MaskRay/ccls
CLANDRO_PKG_DESCRIPTION="C/C++/ObjC language server"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.20250815.1
CLANDRO_PKG_SRCURL=git+https://github.com/MaskRay/ccls.git
CLANDRO_PKG_GIT_BRANCH="$CLANDRO_PKG_VERSION"
CLANDRO_PKG_AUTO_UPDATE=false
# clang is for libclang-cpp.so
CLANDRO_PKG_DEPENDS="clang, libc++, libllvm"
CLANDRO_PKG_BUILD_DEPENDS="rapidjson, libllvm-static"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_SYSTEM_RAPIDJSON=ON
"

clandro_step_pre_configure() {
	touch $CLANDRO_PREFIX/bin/{clang-import-test,clang-offload-wrapper}
}

clandro_step_post_make_install() {
	rm $CLANDRO_PREFIX/bin/{clang-import-test,clang-offload-wrapper}
}
