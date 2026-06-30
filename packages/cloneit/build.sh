CLANDRO_PKG_HOMEPAGE=https://github.com/alok8bb/cloneit
CLANDRO_PKG_DESCRIPTION="A cli tool to download specific GitHub directories or files"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=58e9213ba5af457e76a7ea55696eb77f6d0d9025
_COMMIT_DATE=2025.07.22
CLANDRO_PKG_VERSION=${_COMMIT_DATE//./}
CLANDRO_PKG_SRCURL=git+https://github.com/alok8bb/cloneit
CLANDRO_PKG_SHA256=69e5d916bb6ce319234102b7efef705b2be75b2041eaccce9bcfc5cdb57e1198
CLANDRO_PKG_GIT_BRANCH="master"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="openssl"

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$_COMMIT_DATE" ]; then
		echo -n "ERROR: The specified commit date \"$_COMMIT_DATE\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files: expected=${CLANDRO_PKG_SHA256}, actual=${s}"
	fi
}

clandro_step_make() {
	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/cloneit
}
