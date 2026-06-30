CLANDRO_PKG_HOMEPAGE=http://site.icu-project.org/home
CLANDRO_PKG_DESCRIPTION='International Components for Unicode library'
CLANDRO_PKG_LICENSE="custom"
# We override CLANDRO_PKG_SRCDIR clandro_step_post_get_source so need to do
# this hack to be able to find the license file.
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
# Never forget to always bump revision of reverse dependencies and rebuild them
# when bumping "major" version.
CLANDRO_PKG_VERSION="78.3"
CLANDRO_PKG_SRCURL=https://github.com/unicode-org/icu/releases/download/release-${CLANDRO_PKG_VERSION}/icu4c-${CLANDRO_PKG_VERSION}-sources.tgz
CLANDRO_PKG_SHA256=3a2e7a47604ba702f345878308e6fefeca612ee895cf4a5f222e7955fabfe0c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="libicu-dev"
CLANDRO_PKG_REPLACES="libicu-dev"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-samples --disable-tests --with-cross-build=$CLANDRO_PKG_HOSTBUILD_DIR"

clandro_step_post_get_source() {
	rm "$CLANDRO_PKG_SRCDIR/LICENSE"
	curl -L "https://raw.githubusercontent.com/unicode-org/icu/release-${CLANDRO_PKG_VERSION//./-}/LICENSE" -o "$CLANDRO_PKG_SRCDIR/LICENSE"
	CLANDRO_PKG_SRCDIR+="/source"
	find . -type f -print0 | xargs -0 touch
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libicuuc.so.78"
	if [[ ! -e "${_GUARD_FILE}" ]]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
