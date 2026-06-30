# Not making sense on Termux which is essentially a single-user environment.
CLANDRO_PKG_HOMEPAGE=https://savannah.gnu.org/projects/acct/
CLANDRO_PKG_DESCRIPTION="GNU Accounting Utilities"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=6.6.4
CLANDRO_PKG_SRCURL=https://ftp.gnu.org/gnu/acct/acct-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4c15bf2b58b16378bcc83f70e77d4d40ab0b194acf2ebeefdb507f151faa663f

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_massage() {
	mkdir -p ./var/account
}
