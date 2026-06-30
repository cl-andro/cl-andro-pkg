CLANDRO_PKG_HOMEPAGE=https://github.com/measurement-factory/dnstop
CLANDRO_PKG_DESCRIPTION="A libpcap application that displays various tables of DNS traffic on your network"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=2ec80df727aee31bbaaf9cccd8adbd16ca539bb3
CLANDRO_PKG_VERSION=2022.10.19
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/measurement-factory/dnstop
CLANDRO_PKG_SHA256=5b3e58944a0ff03e9836133c974387269f47d4ef8fdeb7100faa66f74ed56624
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_DEPENDS="libpcap, ncurses"
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

	sed -i "s/@VERSION@/$version/g" dnstop.c
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_BSD"
}
