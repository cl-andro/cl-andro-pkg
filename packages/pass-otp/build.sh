CLANDRO_PKG_HOMEPAGE=https://github.com/tadfisher/pass-otp
CLANDRO_PKG_DESCRIPTION="A pass/passage extension for managing one-time-password (OTP) tokens"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
_COMMIT=7bb50dbc4b6073f12f40be66a5ee371b9652a646
_COMMIT_DATE=20250809
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION=1.2.0-p${_COMMIT_DATE}
CLANDRO_PKG_SRCURL=https://github.com/tadfisher/pass-otp/archive/$_COMMIT.tar.gz
CLANDRO_PKG_SHA256=126b3685fa2ac8fe34aaf1b0036c5be8d480cd913a9709c1f90a5aba117ffa44
CLANDRO_PKG_DEPENDS="oathtool"
CLANDRO_PKG_SUGGESTS="pass | passage, libqrencode"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	export PREFIX=$CLANDRO_PREFIX
	export BASHCOMPDIR=$CLANDRO_PREFIX/share/bash-completion/completions
	export MANDIR=$CLANDRO_PREFIX/share/man
}

clandro_step_post_configure() {
	# Replace $PREFIX with $PASS_PREFIX
	# to avoid variable name conflicts with Termux's $PREFIX
	# See: https://github.com/termux/termux-packages/issues/23569
	sed -i "s|PREFIX|PASS_PREFIX|g" otp.bash
}

clandro_step_post_make_install() {
	# Symlink for passage
	mkdir -p "$CLANDRO_PREFIX/lib/passage/extensions"
	ln -sf $CLANDRO_PREFIX/lib/password-store/extensions/otp.bash "$CLANDRO_PREFIX/lib/passage/extensions/"
}
