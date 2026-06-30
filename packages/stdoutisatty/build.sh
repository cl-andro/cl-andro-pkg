CLANDRO_PKG_HOMEPAGE=https://github.com/lilydjwg/stdoutisatty
CLANDRO_PKG_DESCRIPTION="Patch the isatty() calls for colored output in pipeline"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION=1.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lilydjwg/stdoutisatty/archive/refs/tags/"$CLANDRO_PKG_VERSION".tar.gz
CLANDRO_PKG_SHA256=fadc12401cd89e718d7b0127b882cf47335f436ffcc7b83a9fbf557befe5beb2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_make_install() {
	cd "$CLANDRO_PKG_SRCDIR"
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
}
