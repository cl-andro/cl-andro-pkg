CLANDRO_PKG_HOMEPAGE=https://github.com/MrJoy/ssss
CLANDRO_PKG_DESCRIPTION="Simple command-line implementation of Shamir's Secret Sharing Scheme"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.7
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/MrJoy/ssss/archive/refs/tags/releases/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dbb1f03797cb3fa69594530f9b2c36010f66705b9d5fbbc27293dce72b9c9473
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libgmp"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 ssss-split "$CLANDRO_PREFIX"/bin/
	ln -sfr "$CLANDRO_PREFIX"/bin/ssss-split $CLANDRO_PREFIX/bin/ssss-combine

	install -Dm600 ssss.1 "$CLANDRO_PREFIX"/share/man/man1/ssss.1
	ln -sfr \
		"$CLANDRO_PREFIX"/share/man/man1/ssss.1 \
		"$CLANDRO_PREFIX"/share/man/man1/ssss-combine.1
	ln -sfr \
		"$CLANDRO_PREFIX"/share/man/man1/ssss.1 \
		"$CLANDRO_PREFIX"/share/man/man1/ssss-split.1
}
