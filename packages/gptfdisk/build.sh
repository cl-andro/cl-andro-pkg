# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://www.rodsbooks.com/gdisk/
CLANDRO_PKG_DESCRIPTION="A text-mode partitioning tool that works on GUID Partition Table (GPT) disks"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.10"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/gptfdisk/files/gptfdisk/$CLANDRO_PKG_VERSION/gptfdisk-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=2abed61bc6d2b9ec498973c0440b8b804b7a72d7144069b5a9209b2ad693a282
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libpopt, libuuid, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -d "$CLANDRO_PREFIX"/{bin,share/{doc/gdisk,man/man8}}
	install -t "$CLANDRO_PREFIX"/bin/ {,c,s}gdisk fixparts
	install -m600 -t "$CLANDRO_PREFIX"/share/man/man8/ {{,c,s}gdisk,fixparts}.8
}
