CLANDRO_PKG_HOMEPAGE=https://github.com/adrianlopezroche/fdupes
CLANDRO_PKG_DESCRIPTION="Duplicates file detector"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/adrianlopezroche/fdupes/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2a11250ef0e9d82837dcf336853b2891732cc78e2888ccdc6b689ab7b47b0f5b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libsqlite, ncurses, pcre2"

clandro_step_pre_configure() {
	autoreconf --install
}
