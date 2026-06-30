CLANDRO_PKG_HOMEPAGE=https://devel.ringlet.net/editors/hexer/
CLANDRO_PKG_DESCRIPTION="A multi-buffer editor for binary files for Unix-like systems that displays its buffer(s) as a hex dump"
CLANDRO_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSES/BSD-2-Clause.txt, LICENSES/BSD-3-Clause.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.7"
CLANDRO_PKG_SRCURL=https://devel.ringlet.net/files/editors/hexer/hexer-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2d6bb5583f0b1a1a9825b0de1e836482f07af44484c2d73c5ad9472bdfa2fba1
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
PREFIX=$CLANDRO_PREFIX
MANDIR=$CLANDRO_PREFIX/share/man/man1
INSTALLBIN=install
"

clandro_step_post_configure() {
	cat >> config.h <<-EOF
		#if defined __ANDROID__ && __ANDROID_API__ < 26
		#define getpwent() (NULL)
		#define setpwent() ((void)0)
		#endif
	EOF

	make CPPFLAGS= CFLAGS= LDFLAGS= bin2c

	# only build the program
	mv pyproject.toml{,unused}
}
