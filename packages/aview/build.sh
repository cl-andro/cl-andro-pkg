CLANDRO_PKG_HOMEPAGE=https://aa-project.sourceforge.net/aview/
CLANDRO_PKG_DESCRIPTION="High quality ascii-art image browser and animation player"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.0rc1
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/aa-project/aview/aview-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99
CLANDRO_PKG_DEPENDS="aalib (>> 1.4rc5-8)"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
"
