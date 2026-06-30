CLANDRO_PKG_HOMEPAGE=https://janet-lang.org
CLANDRO_PKG_DESCRIPTION="Development library for Janet"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Komo @mbekkomo"
CLANDRO_PKG_VERSION="1.41.2"
CLANDRO_PKG_SRCURL=https://github.com/janet-lang/janet/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=168e97e1b790f6e9d1e43685019efecc4ee473d6b9f8c421b49c195336c0b725
CLANDRO_PKG_DEPENDS="libandroid-spawn"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_host_build() {
	cd "${CLANDRO_PKG_SRCDIR}" || clandro_error_exit "failed to perform host-build for janet"

	cat >> config.mk <<-EOF
	HOSTCC=$(command -v gcc)
	EOF

	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" build/janet_boot
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" build/janet_host
}

# Prefer Make over Meson
clandro_step_configure() { :; }

clandro_step_make() {
	cat >> config.mk <<-EOF
	PREFIX=${CLANDRO_PREFIX}
	CFLAGS=${CPPFLAGS} ${CFLAGS}
	LDFLAGS=${LDFLAGS} -landroid-spawn
	LIBJANET_LDFLAGS=\$(LDFLAGS)
	EOF

	make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
	make -j "${CLANDRO_PKG_MAKE_PROCESSES}" HAS_SHARED=0
}

clandro_step_make_install() {
	make build/janet.pc
	install -Dm700 -t "${CLANDRO_PREFIX}/bin" build/janet
	install -Dm600 -t "${CLANDRO_PREFIX}/include" build/janet.h
	install -Dm600 -t "${CLANDRO_PREFIX}/lib" build/libjanet.a
	install -Dm600 build/libjanet.so "${CLANDRO_PREFIX}/lib/libjanet.so.${CLANDRO_PKG_VERSION}"
	ln -sf "${CLANDRO_PREFIX}/lib/"{libjanet.so.${CLANDRO_PKG_VERSION},libjanet.so.${CLANDRO_PKG_VERSION%.*}}
	ln -sf "${CLANDRO_PREFIX}/lib/"{libjanet.so.${CLANDRO_PKG_VERSION%.*},libjanet.so}
	install -Dm600 -t "${CLANDRO_PREFIX}/share/man/man1" janet.1
	install -Dm600 -t "${CLANDRO_PREFIX}/lib/pkgconfig" build/janet.pc
}

clandro_step_post_make_install() {
	# Fix rebuilds without ./clean.sh.
	rm -rf "$CLANDRO_PKG_HOSTBUILD_DIR"
}
