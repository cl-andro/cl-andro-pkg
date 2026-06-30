# Contributor: @michalbednarski
CLANDRO_PKG_HOMEPAGE=https://proot-me.github.io/
CLANDRO_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
# Just bump commit and version when needed:
_COMMIT=4dba3afbf3a63af89b4d9c1a59bf2bda10f4d10f
CLANDRO_PKG_VERSION=5.1.107
CLANDRO_PKG_REVISION=70
CLANDRO_PKG_SRCURL=https://github.com/termux/proot/archive/${_COMMIT}.zip
CLANDRO_PKG_SHA256=a72668607184f981e44181bfa47f86ef52d52bb237b4012ee94f0dc89cb39211
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libtalloc"
CLANDRO_PKG_SUGGESTS="proot-distro"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-C src"

# Install loader in libexec instead of extracting it every time
export PROOT_UNBUNDLE_LOADER=$CLANDRO_PREFIX/libexec/proot

clandro_step_pre_configure() {
	CPPFLAGS+=" -DARG_MAX=131072"
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/man/man1
	install -m600 $CLANDRO_PKG_SRCDIR/doc/proot/man.1 $CLANDRO_PREFIX/share/man/man1/proot.1

	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		$CLANDRO_PKG_BUILDER_DIR/termux-chroot \
		> $CLANDRO_PREFIX/bin/termux-chroot
	chmod 700 $CLANDRO_PREFIX/bin/termux-chroot
}
