CLANDRO_PKG_HOMEPAGE=https://github.com/xo/usql
CLANDRO_PKG_DESCRIPTION="A universal command-line interface for SQL databases"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@flipee"
CLANDRO_PKG_VERSION="0.21.4"
CLANDRO_PKG_SRCURL=https://github.com/xo/usql/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=6dfe613eff669606ba52f8c4a046d70677c47b2af61e87dc471ae2c44e50cca7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	local tags="most no_adodb no_duckdb"
	if [ "${CLANDRO_ARCH}" = "arm" ] || [ "${CLANDRO_ARCH}" = "i686" ]; then
		tags="$tags no_netezza no_chai"
	fi

	# TODO: remove this once the upstream package is updated to suport go 1.26
	go mod edit -replace github.com/cockroachdb/swiss=github.com/cockroachdb/swiss@b0f6560
	go mod tidy
	go build \
		-trimpath \
		-tags="$tags" \
		-ldflags="-X github.com/xo/usql/text.CommandName=usql
		-X github.com/xo/usql/text.CommandVersion=$CLANDRO_PKG_VERSION" \
		-o usql
}

clandro_step_make_install() {
	install -Dm755 "$CLANDRO_PKG_SRCDIR/usql" -t "$CLANDRO_PREFIX/bin"

	install -Dm644 "$CLANDRO_PKG_SRCDIR/README.md" -t "$CLANDRO_PREFIX/share/doc/usql"
}
