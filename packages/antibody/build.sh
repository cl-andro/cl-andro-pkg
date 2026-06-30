CLANDRO_PKG_HOMEPAGE=https://github.com/getantibody/antibody
CLANDRO_PKG_DESCRIPTION="The fastest shell plugin manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=6.1.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/getantibody/antibody/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=87bced5fba8cf5d587ea803d33dda72e8bcbd4e4c9991a9b40b2de4babbfc24f
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/getantibody
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/getantibody/antibody

	cd "$GOPATH"/src/github.com/getantibody/antibody
	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/getantibody/antibody/antibody \
		"$CLANDRO_PREFIX"/bin/
}
