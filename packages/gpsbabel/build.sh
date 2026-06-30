CLANDRO_PKG_HOMEPAGE=https://www.gpsbabel.org/
CLANDRO_PKG_DESCRIPTION="GPS file conversion plus transfer to/from GPS units"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# 1.4.4 is the last version that does not require Qt dependency.
CLANDRO_PKG_VERSION=1.4.4
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/gpsbabel/gpsbabel/archive/refs/tags/gpsbabel_${CLANDRO_PKG_VERSION//./_}.tar.gz
CLANDRO_PKG_SHA256=22860e913f093aa9124e295d52d1d4ae1afccaa67ed6bed6f1f8d8b0a45336d1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libexpat"

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+=/gpsbabel
}
