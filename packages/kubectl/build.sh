CLANDRO_PKG_HOMEPAGE=https://kubernetes.io/
CLANDRO_PKG_DESCRIPTION="Kubernetes.io client binary"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.36.0"
CLANDRO_PKG_SRCURL=https://dl.k8s.io/v$CLANDRO_PKG_VERSION/kubernetes-src.tar.gz
CLANDRO_PKG_SHA256=2230c08273a4e12c7321db4d2ba9546f828e431990780c89a69bad858813793e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_CACHEDIR"
	mkdir -p "$CLANDRO_PKG_SRCDIR"

	clandro_download "$CLANDRO_PKG_SRCURL" "$CLANDRO_PKG_CACHEDIR"/kubernetes-src.tar.gz \
		"$CLANDRO_PKG_SHA256"

	tar xf "$CLANDRO_PKG_CACHEDIR"/kubernetes-src.tar.gz \
		-C "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make() {
	clandro_setup_golang

	# Needed to generate manpages.
	#(
	#	export GOPATH="$CLANDRO_PKG_BUILDDIR/host"
	#	unset GOOS GOARCH CGO_LDFLAGS
	#	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	#	cd "$CLANDRO_PKG_SRCDIR"
	#	./hack/update-generated-docs.sh
	#)

	export GOPATH="$CLANDRO_PKG_BUILDDIR/target"
	#chmod +w "$CLANDRO_PKG_SRCDIR"/_output
	#rm -rf "$CLANDRO_PKG_SRCDIR"/_output

	cd "$CLANDRO_PKG_SRCDIR"/cmd/kubectl
	go build .
}

clandro_step_make_install() {
	install -Dm700 "$CLANDRO_PKG_SRCDIR"/cmd/kubectl/kubectl \
		"$CLANDRO_PREFIX"/bin/kubectl

	#mkdir -p "$CLANDRO_PREFIX"/share/man/man1
	#cp -f "$CLANDRO_PKG_SRCDIR"/docs/man/man1/kubectl-*.1 \
	#	"$CLANDRO_PREFIX"/share/man/man1/
}
