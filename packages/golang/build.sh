CLANDRO_PKG_HOMEPAGE=https://go.dev/
CLANDRO_PKG_DESCRIPTION="Go programming language compiler"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3:1.26.2"
CLANDRO_PKG_SRCURL=https://go.dev/dl/go${CLANDRO_PKG_VERSION#*:}.src.tar.gz
CLANDRO_PKG_SHA256=2e91ebb6947a96e9436fb2b3926a8802efe63a6d375dffec4f82aa9dbd6fd43b
CLANDRO_PKG_DEPENDS="clang"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="clang"
CLANDRO_PKG_RECOMMENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_post_get_source() {
	. "$CLANDRO_PKG_BUILDER_DIR/patch-script/fix-hardcoded-etc-resolv-conf.sh"
	. "$CLANDRO_PKG_BUILDER_DIR/patch-script/remove-pidfd.sh"
	. "$CLANDRO_PKG_BUILDER_DIR/patch-script/remove-futex_time64.sh"
}

clandro_step_make_install() {
	clandro_setup_golang

	CLANDRO_GOLANG_DIRNAME="${GOOS}_$GOARCH"
	CLANDRO_GODIR=$CLANDRO_PREFIX/lib/go
	local LINKER=/system/bin/linker
	if (( CLANDRO_ARCH_BITS == 64 )); then
		LINKER+="64"
	fi

	(
	cd "$CLANDRO_PKG_SRCDIR/src" || clandro_error_exit "failed to cd into source directory"
	# Unset PKG_CONFIG to avoid the path being hardcoded into src/cmd/cgo/zdefaultcc.go,
	# see https://github.com/termux/termux-packages/issues/3505.
	env CC_FOR_TARGET="$CC" \
		CXX_FOR_TARGET="$CXX" \
		CC=gcc \
		GO_LDFLAGS="-extldflags=-pie" \
		GO_LDSO="$LINKER" \
		GOROOT_BOOTSTRAP="$GOROOT" \
		GOROOT_FINAL="$CLANDRO_GODIR" \
		PKG_CONFIG= \
		./make.bash
	)

	rm -Rf "$CLANDRO_GODIR"
	mkdir -p "$CLANDRO_GODIR"/{bin,src,doc,lib,"pkg/tool/$CLANDRO_GOLANG_DIRNAME",pkg/include}
	cp "bin/$CLANDRO_GOLANG_DIRNAME"/{go,gofmt} "$CLANDRO_GODIR/bin/"
	ln -sfr "$CLANDRO_GODIR/bin/go" "$CLANDRO_PREFIX/bin/go"
	ln -sfr "$CLANDRO_GODIR/bin/gofmt" "$CLANDRO_PREFIX/bin/gofmt"
	cp go.env "$CLANDRO_GODIR/"
	cp VERSION "$CLANDRO_GODIR/"
	cp "pkg/tool/$CLANDRO_GOLANG_DIRNAME"/* "$CLANDRO_GODIR/pkg/tool/$CLANDRO_GOLANG_DIRNAME/"
	cp -Rf src/* "$CLANDRO_GODIR/src/"
	cp -Rf doc/* "$CLANDRO_GODIR/doc/"
	cp pkg/include/* "$CLANDRO_GODIR/pkg/include/"
	cp -Rf lib/* "$CLANDRO_GODIR/lib"
	cp -Rf misc/ "$CLANDRO_GODIR/"

	# testdata directories are not needed on the installed system
	find "$CLANDRO_GODIR/src" -path '*/testdata*' -delete
}
