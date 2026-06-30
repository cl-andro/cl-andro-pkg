CLANDRO_PKG_HOMEPAGE=https://github.com/hashicorp/hcl
CLANDRO_PKG_DESCRIPTION="A toolkit for creating structured configuration languages"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.24.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/hashicorp/hcl/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0eef23c176aeb7d6f2e7a93aa7bb66405ff38bb407bac0a1ecbab89b09c7c6cf
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

_HCL_TOOLS="hcldec hclfmt hclspecsuite"

clandro_step_pre_configure() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR/_go
	mkdir -p $GOPATH
	go mod tidy
}

clandro_step_make() {
	for f in $_HCL_TOOLS; do
		go install ./cmd/$f
	done
}

clandro_step_make_install() {
	for f in $_HCL_TOOLS; do
		install -Dm700 -t $CLANDRO_PREFIX/bin $GOPATH/bin/*/$f
	done
}
