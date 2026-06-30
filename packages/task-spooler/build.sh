CLANDRO_PKG_HOMEPAGE=https://vicerveza.homeunix.net/~viric/soft/ts/
CLANDRO_PKG_DESCRIPTION="Task spooler is a Unix batch system where the tasks spooled run one after the other"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:1.0.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://vicerveza.homeunix.net/~viric/soft/ts/ts-${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=fa833311543dc535b60cb7ab83c64ab5ee31128dbaaaa13dde341984e542b428
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_post_make_install() {
	install -Dm600  \
		$CLANDRO_PKG_SRCDIR/ts.1 \
		$CLANDRO_PREFIX/share/man/man1/tsp.1
}
