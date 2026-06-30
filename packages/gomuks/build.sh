CLANDRO_PKG_HOMEPAGE=https://go.mau.fi/gomuks
CLANDRO_PKG_DESCRIPTION="A terminal Matrix client written in Go"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/gomuks/gomuks/archive/refs/tags/v0.${CLANDRO_PKG_VERSION/.}.0.tar.gz"
CLANDRO_PKG_SHA256=d01e3b23fe759f62e7619304b6cab8f6676978ed685869f1ce55a7157ac8c409
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="0\.\K\d+(?=\.0)"
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/([0-9][0-9])([0-9][0-9])/\1.\2/"
CLANDRO_PKG_DEPENDS="libolm, resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
# i686 fails to compile:
# go.mau.fi/goheif/dav1d
# In file included from dav1d-tmpl-16.c:2:
# In file included from ./dav1d-tmpl.inl:1:
# In file included from ./src/cdef_apply_tmpl.c:28:
# go/pkg/mod/go.mau.fi/goheif@v0.0.0-20260413100809-7ec7087b8d7d/dav1d/config.h:30:2: error: "Unsupported architecture. Only x86_64, ARM64, and RISC-V are supported."
CLANDRO_PKG_EXCLUDED_ARCHES=i686

clandro_step_host_build() {
	clandro_setup_golang

	GOBIN="$CLANDRO_PKG_HOSTBUILD_DIR" GOOS=linux GOARCH=amd64 go install go.mau.fi/util/cmd/maubuild@latest
}

clandro_step_post_get_source() {
	clandro_setup_golang
	export GOPATH="$CLANDRO_PKG_SRCDIR/go"
	go get ./cmd/gomuks
	chmod +w "$GOPATH" -R

	local d
	for d in go/pkg/mod/go.mau.fi/goheif*; do
		patch -p1 -d "${d}" < "$CLANDRO_PKG_BUILDER_DIR/goheif-no-pthread_getaffinity_np.diff"
	done
}

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	export GOPATH="$CLANDRO_PKG_SRCDIR/go"
	# This is adapted directly from the upstream `./build-noweb.sh`
	# https://github.com/gomuks/gomuks/blob/v0.2511.0/build-noweb.sh
	mkdir -p web/dist/
	touch web/dist/empty
	BINARY_NAME=gomuks MAU_VERSION_PACKAGE=go.mau.fi/gomuks/version $CLANDRO_PKG_HOSTBUILD_DIR/maubuild "$@"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" gomuks
}
