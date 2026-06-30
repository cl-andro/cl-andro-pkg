CLANDRO_PKG_HOMEPAGE=https://www.nongnu.org/renameutils/
CLANDRO_PKG_DESCRIPTION="A set of programs designed to make renaming of files faster and less cumbersome"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.12.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://savannah.nongnu.org/download/renameutils/renameutils-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=cbd2f002027ccf5a923135c3f529c6d17fabbca7d85506a394ca37694a9eb4a3
CLANDRO_PKG_DEPENDS="libandroid-wordexp, readline"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-wordexp"
}
