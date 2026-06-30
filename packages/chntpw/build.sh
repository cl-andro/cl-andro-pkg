CLANDRO_PKG_HOMEPAGE=https://pogostick.net/~pnh/ntpasswd/
CLANDRO_PKG_DESCRIPTION="Offline Windows NT Password & Registry Editor"
CLANDRO_PKG_LICENSE="GPL-2.0-only, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@xingguangcuican6666"
CLANDRO_PKG_VERSION="140201"
CLANDRO_PKG_SRCURL="https://pogostick.net/~pnh/ntpasswd/chntpw-source-$CLANDRO_PKG_VERSION.zip"
CLANDRO_PKG_SHA256=96e20905443e24cba2f21e51162df71dd993a1c02bfa12b1be2d0801a4ee2ccc
# NOTE: dependency on openssl/libgcrypt is disabled by default because the code associated with
# it only works on the password databases of Windows 2000 and older (?!?)
# See: https://salsa.debian.org/debian/chntpw/-/blob/e00c8dd756fdb6a04d6dd27e7bedf19981a398f8/debian/changelog#L51
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm 755 chntpw "${CLANDRO_PREFIX}/bin/chntpw"
	install -Dm 755 cpnt "${CLANDRO_PREFIX}/bin/cpnt"
	install -Dm 755 reged "${CLANDRO_PREFIX}/bin/reged"
	install -Dm 755 samusrgrp "${CLANDRO_PREFIX}/bin/samusrgrp"
	install -Dm 755 sampasswd "${CLANDRO_PREFIX}/bin/sampasswd"
	install -Dm 755 samunlock "${CLANDRO_PREFIX}/bin/samunlock"

	local doc docdir="${CLANDRO_PREFIX}/share/doc/${CLANDRO_PKG_NAME}"
	mkdir -p "$docdir"
	for doc in *.txt; do
		install -Dm0644 "$doc" "$docdir/$doc"
	done
}
