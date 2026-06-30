CLANDRO_PKG_HOMEPAGE=https://codeberg.org/Anoxinon_e.V./xmppc
CLANDRO_PKG_DESCRIPTION="Command Line Interface Tool for XMPP"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://codeberg.org/Anoxinon_e.V./xmppc/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=05259ec5cba25f693edfe01389a3405835404539c7817fb208c201e29480e6b7
CLANDRO_PKG_DEPENDS="libstrophe, glib, gpgme"

clandro_step_pre_configure() {
	./bootstrap.sh
}
