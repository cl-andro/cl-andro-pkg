CLANDRO_PKG_HOMEPAGE=https://micro-editor.github.io/
CLANDRO_PKG_DESCRIPTION="Modern and intuitive terminal-based text editor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.15"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_SRCURL=git+https://github.com/zyedidia/micro

clandro_step_make() {
	return
}

clandro_step_make_install() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	local MICRO_SRC=$GOPATH/src/github.com/zyedidia/micro

	cd "$CLANDRO_PKG_SRCDIR"
	mkdir -p "$MICRO_SRC"
	cp -R . "$MICRO_SRC"

	cd "$MICRO_SRC"
	sed -zEi 's/VERSION = \$\(.+\\\n.+\)/VERSION = '"$CLANDRO_PKG_VERSION"'/gm' Makefile
	make build
	mv micro "$CLANDRO_PREFIX/bin/micro"
}
