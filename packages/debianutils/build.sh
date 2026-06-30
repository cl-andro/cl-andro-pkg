CLANDRO_PKG_HOMEPAGE=https://packages.debian.org/debianutils
CLANDRO_PKG_DESCRIPTION="Small utilities which are used primarily by the installation scripts of Debian packages"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.23.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/d/debianutils/debianutils_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=79e524b7526dba2ec5c409d0ee52ebec135815cf5b2907375d444122e0594b69
CLANDRO_PKG_AUTO_UPDATE=true

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/add-shell
bin/installkernel
bin/remove-shell
bin/update-shells
bin/which
share/man/man1/which.1
share/man/man8/add-shell.8
share/man/man8/installkernel.8
share/man/man8/remove-shell.8
share/man/man8/update-shells.8
"

clandro_step_pre_configure() {
	autoreconf -vfi
}
