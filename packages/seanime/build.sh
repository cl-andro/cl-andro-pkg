CLANDRO_PKG_HOMEPAGE=https://github.com/5rahim/seanime
CLANDRO_PKG_DESCRIPTION="Self-hosted anime and manga server for sea rovers."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.1"
CLANDRO_PKG_SRCURL=https://github.com/5rahim/seanime/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3868449b61d33458e54269310931d909017eb4046614f7175caffdde621925f2
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_nodejs

	cp -r $CLANDRO_PKG_SRCDIR/seanime-web ./seanime-web
	cd seanime-web
	npm install
	npm run build
}

clandro_step_pre_configure() {
	cp -r $CLANDRO_PKG_HOSTBUILD_DIR/seanime-web/out $CLANDRO_PKG_SRCDIR/web/

	clandro_setup_golang
}

clandro_step_make() {
	# -checklinkname=0 for https://github.com/wlynxg/anet?tab=readme-ov-file#how-to-build-with-go-1230-or-later
	go build -o seanime -trimpath -ldflags="-checklinkname=0 -s -w"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/seanime
}
