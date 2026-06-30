CLANDRO_PKG_HOMEPAGE=https://github.com/skeeto/passphrase2pgp
CLANDRO_PKG_DESCRIPTION="Generate EdDSA/cv25519 private key in GnuPG/SSH format reproducibly per hash of user given passphrase"
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/skeeto/passphrase2pgp/releases/download/v$CLANDRO_PKG_VERSION/passphrase2pgp-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=dfed400dc3c5d5547a117dc91cc068bc1613daa0396089f6f66a51190b9889d7
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	mkdir bin
	go build -o ./bin -trimpath
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/*
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
}
