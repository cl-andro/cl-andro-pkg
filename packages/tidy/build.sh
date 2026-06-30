CLANDRO_PKG_HOMEPAGE=http://www.html-tidy.org/
CLANDRO_PKG_DESCRIPTION="A tool to tidy down your HTML code to a clean style"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="README/LICENSE.md"
CLANDRO_PKG_MAINTAINER="@clandro"
# Using unstable API version due to CVE-2021-33391.
# Please revbump revdeps to rebuild when bumping version.
CLANDRO_PKG_VERSION=5.9.14-next
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/htacg/tidy-html5/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=83cc9d9cdfa59bfe400dc745dea14eb1e1be4ca088facfb911eac8b78e75f2b4
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libxslt"
CLANDRO_PKG_BREAKS="tidy-dev"
CLANDRO_PKG_REPLACES="tidy-dev"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=

	local _MAJOR=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	local _MINOR=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 2)
	local v=
	if [ $(( _MINOR % 2 )) == 0 ]; then
		v="${_MAJOR}${_MINOR}"
	fi
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_host_build() {
	## Host build required to generate man pages.
	clandro_setup_cmake
	cmake $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS "$CLANDRO_PKG_SRCDIR" && make
}

clandro_step_post_make_install() {
	install -Dm600 \
		"$CLANDRO_PKG_HOSTBUILD_DIR"/tidy.1 \
		"$CLANDRO_PREFIX"/share/man/man1/
}
