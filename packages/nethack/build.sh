CLANDRO_PKG_HOMEPAGE=http://www.nethack.org/
CLANDRO_PKG_DESCRIPTION="Dungeon crawl game"
CLANDRO_PKG_LICENSE="Nethack"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.6.7
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.nethack.org/download/${CLANDRO_PKG_VERSION}/nethack-${CLANDRO_PKG_VERSION//./}-src.tgz
CLANDRO_PKG_SHA256=98cf67df6debf9668a61745aa84c09bcab362e5d33f5b944ec5155d44d2aacb2
CLANDRO_PKG_DEPENDS="gzip, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_GROUPS="games"

clandro_step_host_build() {
	cp -r $CLANDRO_PKG_SRCDIR/* .
	pushd sys/unix
	sh setup.sh hints/linux
	popd && cd util
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		HOST_CC="gcc -m32"
	else
		HOST_CC="gcc"
	fi
	CFLAGS="" CC="$HOST_CC" LD="ld" make makedefs
	CFLAGS="" CC="$HOST_CC" LD="ld" make lev_comp
	CFLAGS="" CC="$HOST_CC" LD="ld" make dgn_comp dlb recover
}

clandro_step_pre_configure() {
	WINTTYLIB="$LDFLAGS -lcurses"
	export LFLAGS="$LDFLAGS"
	export CFLAGS="$CPPFLAGS $CFLAGS"
	cd sys/unix
	sh setup.sh hints/linux
}

clandro_step_post_configure() {
	# cp hostbuilt tools from hostbuild dir
	cp $CLANDRO_PKG_HOSTBUILD_DIR/util/{makedefs,lev_comp,dgn_comp,dlb} \
		util/
	touch -d "next hour" util/*
}

clandro_step_post_make_install() {
	cd doc
	mkdir -p $CLANDRO_PREFIX/share/man/man6
	install -m600 nethack.6 $CLANDRO_PREFIX/share/man/man6/
	ln -sf $CLANDRO_PREFIX/games/nethack $CLANDRO_PREFIX/bin/
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "mkdir -p $CLANDRO_PREFIX/games/nethackdir/save" >> postinst
	echo "exit 0" >> postinst
}
