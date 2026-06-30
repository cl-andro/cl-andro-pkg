CLANDRO_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/projects/orc.html
CLANDRO_PKG_DESCRIPTION="Library of Optimized Inner Loops Runtime Compiler"
CLANDRO_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.4.42"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/gstreamer/orc/-/archive/${CLANDRO_PKG_VERSION}/orc-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1f5c3f614de5bd4a6522ba3c24a93b99d06c9f773ef5618252269d7f40251456
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dorc-test=disabled
-Dtests=disabled
-Dbenchmarks=disabled
-Dexamples=disabled
-Dhotdoc=disabled
"
