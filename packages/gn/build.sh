CLANDRO_PKG_HOMEPAGE=https://gn.googlesource.com/gn
CLANDRO_PKG_DESCRIPTION="Meta-build system that generates build files for Ninja"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_SRCURL=git+https://gn.googlesource.com/gn
_COMMIT=64d35867ca0a1088f13de8f4ccaf1a5687d7f1ce
_COMMIT_DATE=2025.12.17
CLANDRO_PKG_VERSION=${_COMMIT_DATE//./}
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_RECOMMENDS="ninja"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
	clandro_setup_gn
}

clandro_step_configure() {
	./build/gen.py --no-static-libstdc++
}

clandro_step_make() {
	clandro_setup_ninja
	ninja -C out/
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin out/gn
}
