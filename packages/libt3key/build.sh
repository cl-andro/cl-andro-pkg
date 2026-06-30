CLANDRO_PKG_HOMEPAGE=https://os.ghalkes.nl/t3/libt3key.html
CLANDRO_PKG_DESCRIPTION="A library and database with escape sequence to key symbol mappings"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.11"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://os.ghalkes.nl/dist/libt3key-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=e4dfdef50be52e365f68745df6177e819df5a7600e61716063d5480f7db3c06c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libt3config, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-gettext"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	sed -i 's/ -s / /g' Makefile.in
}

clandro_step_host_build() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	export PKG_CONFIG_PATH=$_PREFIX_FOR_BUILD/lib/pkgconfig

	local LIBT3CONFIG_BUILD_SH=$CLANDRO_SCRIPTDIR/packages/libt3config/build.sh
	local LIBT3CONFIG_SRCURL=$(bash -c ". $LIBT3CONFIG_BUILD_SH; echo \$CLANDRO_PKG_SRCURL")
	local LIBT3CONFIG_SHA256=$(bash -c ". $LIBT3CONFIG_BUILD_SH; echo \$CLANDRO_PKG_SHA256")
	local LIBT3CONFIG_TARFILE=$CLANDRO_PKG_CACHEDIR/$(basename $LIBT3CONFIG_SRCURL)
	clandro_download $LIBT3CONFIG_SRCURL $LIBT3CONFIG_TARFILE $LIBT3CONFIG_SHA256

	mkdir -p libt3config
	pushd libt3config
	tar xf $LIBT3CONFIG_TARFILE --strip-components=1
	./configure --prefix=$_PREFIX_FOR_BUILD --without-gettext
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
	popd

	mkdir -p libt3key
	pushd libt3key
	find $CLANDRO_PKG_SRCDIR -mindepth 1 -maxdepth 1 -exec cp -a \{\} ./ \;
	./configure --prefix=$_PREFIX_FOR_BUILD --without-gettext \
		LDFLAGS="-Wl,-rpath=$_PREFIX_FOR_BUILD/lib"
	make -j $CLANDRO_PKG_MAKE_PROCESSES
	make install
	popd

	unset PKG_CONFIG_PATH
}

clandro_step_pre_configure() {
	local _PREFIX_FOR_BUILD=$CLANDRO_PKG_HOSTBUILD_DIR/prefix
	export PATH=$_PREFIX_FOR_BUILD/bin:$PATH

	local libtooldir=$CLANDRO_PKG_TMPDIR/_libtool
	mkdir -p $libtooldir
	pushd $libtooldir
	cat > configure.ac <<-EOF
		AC_INIT
		LT_INIT
		AC_OUTPUT
	EOF
	touch install-sh
	cp "$CLANDRO_SCRIPTDIR/scripts/config.sub" ./
	cp "$CLANDRO_SCRIPTDIR/scripts/config.guess" ./
	autoreconf -fi
	./configure --host=$CLANDRO_HOST_PLATFORM
	popd
	export LIBTOOL=$libtooldir/libtool
}
