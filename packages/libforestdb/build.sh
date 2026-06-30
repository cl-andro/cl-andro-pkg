CLANDRO_PKG_HOMEPAGE=https://github.com/couchbase/forestdb
CLANDRO_PKG_DESCRIPTION="A key-value storage engine"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/couchbase/forestdb/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=52463e4e3bd94ff70503b8a278ec0304c13acb6862e5d5fd3d2b3f05e60b7aa0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libsnappy"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_configure() {
	if [ "$CLANDRO_PKG_CMAKE_BUILD" == "Ninja" ]; then
		sed -i -e 's:\$INCLUDES:& -I'$CLANDRO_PREFIX'/include:g' \
			CMakeFiles/rules.ninja
	fi
}
