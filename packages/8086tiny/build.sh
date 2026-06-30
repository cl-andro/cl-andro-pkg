CLANDRO_PKG_HOMEPAGE=https://github.com/adriancable/8086tiny
CLANDRO_PKG_DESCRIPTION="A PC XT-compatible emulator/virtual machine"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.25
CLANDRO_PKG_REVISION=5
# Version tag is unavailable.
CLANDRO_PKG_SRCURL=https://github.com/adriancable/8086tiny/archive/c79ca2a34d96931d55ef724c815b289d0767ae3a.tar.gz
CLANDRO_PKG_SHA256=ede246503a745274430fdee77ba639bc133a2beea9f161bff3f7132a03544bf6
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="bash, coreutils, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CPPFLAGS+=" -DNO_GRAPHICS"
}

clandro_step_make_install() {
	install -Dm700 8086tiny "$CLANDRO_PREFIX"/libexec/8086tiny
	install -Dm600 bios "$CLANDRO_PREFIX"/share/8086tiny/bios.bin
	install -Dm600 fd.img "$CLANDRO_PREFIX"/share/8086tiny/dos.img

	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		-e "s|@PACKAGE_VERSION@|$CLANDRO_PKG_VERSION|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/8086tiny.sh > "$CLANDRO_PREFIX"/bin/8086tiny
	chmod 700 "$CLANDRO_PREFIX"/bin/8086tiny
}
