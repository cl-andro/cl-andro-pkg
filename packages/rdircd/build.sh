CLANDRO_PKG_HOMEPAGE=https://github.com/mk-fg/reliable-discord-client-irc-daemon
CLANDRO_PKG_DESCRIPTION="A daemon that allows using a personal Discord account through an IRC client"
CLANDRO_PKG_LICENSE="WTFPL"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=026f1aef9857ae6ce06bfb00860898e6113adfc0
CLANDRO_PKG_VERSION=2023.02.07
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/mk-fg/reliable-discord-client-irc-daemon
CLANDRO_PKG_SHA256=c2cc88d6e1616d27f6f7849d536ba7613c7f13f0d16cac6022f9b1952ad537e2
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="python, python-pip"
CLANDRO_PKG_PYTHON_TARGET_DEPS="aiohttp"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

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
	install -Dm700 -t $CLANDRO_PREFIX/bin rdircd
}
