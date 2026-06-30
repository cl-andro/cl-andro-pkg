CLANDRO_PKG_HOMEPAGE=https://github.com/TomWright/dasel
CLANDRO_PKG_DESCRIPTION="Select, put and delete data from JSON, TOML, YAML, XML and CSV files with a single utility"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.1"
CLANDRO_PKG_SRCURL=https://github.com/TomWright/dasel/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=92711ddecfad9a1e97a41011d12ea88e9bb3c37827e5d5a718c3a8e8eaa88eaa
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	mkdir bin
	go build -o ./bin -trimpath ./cmd/dasel
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/*
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
}
