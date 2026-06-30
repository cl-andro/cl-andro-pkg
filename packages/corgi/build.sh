CLANDRO_PKG_HOMEPAGE=https://github.com/DrakeW/corgi
CLANDRO_PKG_DESCRIPTION="CLI workflow manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.4"
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://github.com/DrakeW/corgi/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=783fa88c29aecfbd8a557c186cee4d2f41927a3147464d4ccabb99600e3a02e6
CLANDRO_PKG_RECOMMENDS="fzf"
CLANDRO_PKG_SUGGESTS="peco"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go mod init main.go
	go get
	chmod +w $GOPATH -R
}

clandro_step_make() {
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go build -o corgi
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/corgi
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/etc/profile.d
	cat <<- EOF > "$CLANDRO_PREFIX"/etc/profile.d/corgi.sh
	export HISTFILE="\$HISTFILE"
	EOF
	chmod 700 "$CLANDRO_PREFIX"/etc/profile.d/corgi.sh
}
