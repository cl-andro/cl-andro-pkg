CLANDRO_PKG_HOMEPAGE=https://ps-auxw.de/avs2bdnxml/
CLANDRO_PKG_DESCRIPTION="AVS to BluRay SUP/PGS and BDN XML"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=42a5572c631bbb4dcf9b43d07179de8c5607d47c
CLANDRO_PKG_VERSION=2019.02.06
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/hguandl/ass2bdnxml
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libpng"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi
}

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ass2bdnxml
}
