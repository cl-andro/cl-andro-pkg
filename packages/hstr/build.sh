CLANDRO_PKG_HOMEPAGE=https://github.com/dvorka/hstr
CLANDRO_PKG_DESCRIPTION="Shell history suggest box for bash and zsh"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/dvorka/hstr/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e5293d4fe2502662f19c793bef416e05ac020490218e71c75a5e92919c466071
CLANDRO_PKG_DEPENDS="ncurses, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__tmp_hstr_ms_wsl=no
"

clandro_step_pre_configure() {
	autoreconf -fi
}
