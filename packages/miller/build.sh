CLANDRO_PKG_HOMEPAGE=https://miller.readthedocs.io/
CLANDRO_PKG_DESCRIPTION="Like awk, sed, cut, join, and sort for name-indexed data such as CSV, TSV, and tabular JSON"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.18.1"
CLANDRO_PKG_SRCURL=git+https://github.com/johnkerl/miller
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	local dir="$GOPATH"/src/github.com/johnkerl/miller
	mkdir -p "$(dirname "${dir}")"
	ln -sfT "$CLANDRO_PKG_SRCDIR" "${dir}"
	CLANDRO_PKG_BUILDDIR="${dir}"
	cd "${dir}"
}

clandro_step_configure() {
	:
}
