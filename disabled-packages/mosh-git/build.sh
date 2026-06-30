CLANDRO_PKG_HOMEPAGE=https://mosh.org
CLANDRO_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo. Bleeding edge git version."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2022.02.04
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_SRCURL=git+https://github.com/mobile-shell/mosh
CLANDRO_PKG_DEPENDS="libandroid-support, libc++, libprotobuf, ncurses, openssl, openssh, perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="mosh, mosh-perl"
CLANDRO_PKG_REPLACES="mosh, mosh-perl"
CLANDRO_PKG_PROVIDES="mosh, mosh-perl"
_COMMIT=dbe419d0e069df3fedc212d456449f64d0280c76

clandro_step_pre_configure() {
	clandro_setup_protobuf
	./autogen.sh
}

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout "$_COMMIT"

	local version
	version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}
