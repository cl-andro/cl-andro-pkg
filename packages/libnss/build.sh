CLANDRO_PKG_HOMEPAGE=https://firefox-source-docs.mozilla.org/security/nss/
CLANDRO_PKG_DESCRIPTION="Network Security Services (NSS)"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_LICENSE_FILE="nss/COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.123.1"
CLANDRO_PKG_SRCURL=https://archive.mozilla.org/pub/security/nss/releases/NSS_${CLANDRO_PKG_VERSION//./_}_RTM/src/nss-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=42065a3ff780a9710a3dddcd1cee9b9be2aa40628883cea851d562eb58b178b0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libnspr, libsqlite"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
CC_IS_CLANG=1
CROSS_COMPILE=1
NSPR_INCLUDE_DIR=$CLANDRO_PREFIX/include/nspr
NSS_DISABLE_GTESTS=1
NSS_ENABLE_WERROR=0
NSS_SEED_ONLY_DEV_URANDOM=1
NSS_USE_SYSTEM_SQLITE=1
OS_TEST=$CLANDRO_ARCH
"
CLANDRO_PKG_MAKE_PROCESSES=1
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_NO_STATICSPLIT=true

_LIBNSS_SIGN_LIBS="libfreebl3.so libnssdbm3.so libsoftokn3.so"

clandro_step_host_build() {
	mkdir -p nsinstall
	cd nsinstall
	for f in nsinstall.c pathsub.c; do
		gcc -c $CLANDRO_PKG_SRCDIR/nss/coreconf/nsinstall/$f
	done
	gcc nsinstall.o pathsub.o -o nsinstall
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -DANDROID"
	LDFLAGS+=" -llog"

	CLANDRO_PKG_EXTRA_MAKE_ARGS+=" NSINSTALL=$CLANDRO_PKG_HOSTBUILD_DIR/nsinstall/nsinstall"
	if [ $CLANDRO_ARCH_BITS -eq 64 ]; then
		CLANDRO_PKG_EXTRA_MAKE_ARGS+=" USE_64=1"
	fi
}

clandro_step_make() {
	cd nss
	make -j $CLANDRO_PKG_MAKE_PROCESSES \
		CCC="$CXX" \
		XCFLAGS="$CFLAGS $CPPFLAGS" \
		CPPFLAGS="$CPPFLAGS" \
		${CLANDRO_PKG_EXTRA_MAKE_ARGS}
}

clandro_step_make_install() {
	local nsprver="$(pkg-config --modversion nspr)"
	local pkgconfig_dir=$CLANDRO_PREFIX/lib/pkgconfig
	mkdir -p $pkgconfig_dir
	sed \
		-e "s|%prefix%|${CLANDRO_PREFIX}|g" \
		-e 's|%exec_prefix%|${prefix}|g' \
		-e 's|%libdir%|${prefix}/lib|g' \
		-e 's|%includedir%|${prefix}/include/nss|g' \
		-e "s|%NSS_VERSION%|${CLANDRO_PKG_VERSION#*:}|g" \
		-e "s|%NSPR_VERSION%|${nsprver}|g" \
		nss/pkg/pkg-config/nss.pc.in > $pkgconfig_dir/nss.pc
	cd dist
	install -Dm600 -t $CLANDRO_PREFIX/include/nss public/nss/*
	install -Dm600 -t $CLANDRO_PREFIX/include/nss/private private/nss/*
	install -Dm600 -t $CLANDRO_PREFIX/include/dbm public/dbm/*
	install -Dm600 -t $CLANDRO_PREFIX/include/dbm/private private/dbm/*
	pushd *.OBJ
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/*
	install -Dm600 -t $CLANDRO_PREFIX/lib lib/*
	for f in $_LIBNSS_SIGN_LIBS; do
		if [ ! -e lib/$f ]; then
			echo "ERROR: \"lib/$f\" not found."
			exit 1
		fi
	done
	popd
}

clandro_step_post_massage() {
	find lib -name '*.a' \
		-a ! -name libcrmf.a \
		-a ! -name libfreebl.a \
		-a ! -name libnssb.a \
		-a ! -name libnssckfw.a \
		-delete
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	for f in $_LIBNSS_SIGN_LIBS; do
		echo "$CLANDRO_PREFIX/bin/shlibsign -i $CLANDRO_PREFIX/lib/$f" >> postinst
	done
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
