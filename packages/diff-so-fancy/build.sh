CLANDRO_PKG_HOMEPAGE="https://github.com/so-fancy/diff-so-fancy"
CLANDRO_PKG_DESCRIPTION="Good-lookin' diffs. Actually... nah... The best-lookin' diffs"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_VERSION="1.4.10"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL="https://github.com/so-fancy/diff-so-fancy/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=9df1e7b5c47f1f70ea5d23b18a5994c431548029448465256a93b3b7cfeb0b4a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_RECOMMENDS="git"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	# relative paths of vendored libs to absolute system lib paths
	sed "s#^use lib .*\$#use lib \"$CLANDRO_PREFIX/share/diff-so-fancy\";#" -i diff-so-fancy

	install -Dm700 diff-so-fancy        "$CLANDRO_PREFIX/bin/diff-so-fancy"
	install -Dm700 lib/DiffHighlight.pm "$CLANDRO_PREFIX/share/diff-so-fancy/DiffHighlight.pm"
	install -Dm600 README.md            "$CLANDRO_PREFIX/share/doc/diff-so-fancy/README.md"
}
