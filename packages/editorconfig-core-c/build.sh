CLANDRO_PKG_HOMEPAGE=https://editorconfig.org/
CLANDRO_PKG_DESCRIPTION="EditorConfig core code written in C (for use by plugins supporting EditorConfig parsing)"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.11"
CLANDRO_PKG_SRCURL=https://github.com/editorconfig/editorconfig-core-c/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9d8b420b56a969ea3cf784861c72d26fa0e158fa1494d732df2c8a1480d36a5c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="pcre2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_DOCUMENTATION=OFF
"
