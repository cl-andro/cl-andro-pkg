CLANDRO_PKG_HOMEPAGE=https://rclone.org/
CLANDRO_PKG_DESCRIPTION="rsync for cloud storage"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.74.1"
CLANDRO_PKG_SRCURL=https://github.com/rclone/rclone/releases/download/v${CLANDRO_PKG_VERSION}/rclone-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7da9f127d1f123d1d16cf43be771b6f05944434021008491d739cc648ea55a25
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	cd $CLANDRO_PKG_SRCDIR

	clandro_setup_golang

	mkdir -p .gopath/src/github.com/rclone
	ln -sf "$PWD" .gopath/src/github.com/rclone/rclone
	export GOPATH="$PWD/.gopath"

	go build -v -ldflags "-X github.com/rclone/rclone/fs.Version=v${CLANDRO_PKG_VERSION}-termux" -tags noselfupdate -o rclone

	# XXX: Fix read-only files which prevents removal of src dir.
	chmod u+w -R .

	cp rclone $CLANDRO_PREFIX/bin/rclone
	mkdir -p $CLANDRO_PREFIX/share/man/man1/
	cp rclone.1 $CLANDRO_PREFIX/share/man/man1/
}
