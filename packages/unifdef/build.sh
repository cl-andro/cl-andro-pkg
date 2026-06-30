CLANDRO_PKG_HOMEPAGE=http://dotat.at/prog/unifdef/
CLANDRO_PKG_DESCRIPTION="Remove #ifdef'ed lines"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.12
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://dotat.at/prog/unifdef/unifdef-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=fba564a24db7b97ebe9329713ac970627b902e5e9e8b14e19e024eb6e278d10b
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/share/man/man1/
	install -Dm700 unifdef "$CLANDRO_PREFIX"/bin/
	install -Dm600 unifdef.1 "$CLANDRO_PREFIX"/share/man/man1/
}
