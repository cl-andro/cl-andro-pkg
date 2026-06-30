CLANDRO_PKG_HOMEPAGE=https://github.com/gogakoreli/snake
CLANDRO_PKG_DESCRIPTION="Eat as much as you want while avoiding walls"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=a57f7f8aa8c77fcce2dabafca1a5ec4b96825231
CLANDRO_PKG_VERSION=2022.11.07
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/gogakoreli/snake
CLANDRO_PKG_SHA256=3fc981af52289eaac169944de362e20d4fe6260a41158f5a8a44741e1522b89b
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin/ snake
}

clandro_step_install_license() {
	install -Dm644 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/ \
		$CLANDRO_PKG_BUILDER_DIR/LICENSE
}
