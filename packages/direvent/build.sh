CLANDRO_PKG_HOMEPAGE=https://www.gnu.org.ua/software/direvent/
CLANDRO_PKG_DESCRIPTION="Monitor of events in file system directories"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/direvent/direvent-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1dbbc6192aab67e345725148603d570c6a2828380c964215762af91524d795ba
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob"

clandro_step_pre_configure() {
	export LIBS="-landroid-glob"
}
