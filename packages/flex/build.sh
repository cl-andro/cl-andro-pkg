CLANDRO_PKG_HOMEPAGE=https://github.com/westes/flex
CLANDRO_PKG_DESCRIPTION="Fast lexical analyser generator"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.6.4
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/westes/flex/releases/download/v${CLANDRO_PKG_VERSION}/flex-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="m4"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="ac_cv_path_M4=$CLANDRO_PREFIX/bin/m4"
CLANDRO_PKG_CONFLICTS="flex-dev"
CLANDRO_PKG_REPLACES="flex-dev"
CLANDRO_PKG_GROUPS="base-devel"

# Work around https://github.com/westes/flex/issues/241 when building
# under ubuntu 17.10:
CLANDRO_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="CFLAGS=-D_GNU_SOURCE=1"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local e=$(sed -En 's/^SHARED_VERSION_INFO="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	mkdir -p $CLANDRO_PKG_BUILDDIR/src/
	cp $CLANDRO_PKG_HOSTBUILD_DIR/src/stage1flex $CLANDRO_PKG_BUILDDIR/src/stage1flex
	touch -d "next hour" $CLANDRO_PKG_BUILDDIR/src/stage1flex
}
