CLANDRO_PKG_HOMEPAGE=https://nethackwiki.com/wiki/Slash%27EM_Extended
CLANDRO_PKG_DESCRIPTION="A variant of SLASH'EM (a variant of NetHack)"
CLANDRO_PKG_LICENSE="Nethack"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.7.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/SLASHEM-Extended/SLASHEM-Extended/archive/refs/tags/slex-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=54d301bcb8d79d92030a30195f091e694f843d4656061dbce85730fc12023dee
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	for s in dgn lev; do
		ln -sf ${s}_comp.h include/${s}.tab.h
	done
	for f in alloc.c decl.c dlb.c drawing.c monst.c objects.c; do
		ln -sf ../src/$f util/$f
	done
}

clandro_step_make() {
	CFLAGS+=" -fcommon -DMAILPATH=\\\"/dev/null\\\""
	export CFLAGS_FOR_BUILD="-m${CLANDRO_ARCH_BITS} -O2 -fcommon"
	export LDFLAGS_FOR_BUILD="-m${CLANDRO_ARCH_BITS}"
	make -f sys/unix/GNUmakefile
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin "$CLANDRO_PKG_BUILDDIR/src/slex"
	install -Dm600 -t $CLANDRO_PREFIX/share/games/slex "$CLANDRO_PKG_BUILDDIR/dat/nhdat"
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/slex "$CLANDRO_PKG_SRCDIR/dat/license"
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/games/slex" >> postinst
	echo "touch $CLANDRO_PREFIX/var/games/slex/perm" >> postinst
	echo "touch $CLANDRO_PREFIX/var/games/slex/record" >> postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/games/slex/save" >> postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/games/slex/unshare" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
