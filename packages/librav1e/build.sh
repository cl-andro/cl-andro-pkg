CLANDRO_PKG_HOMEPAGE=https://github.com/xiph/rav1e/
CLANDRO_PKG_DESCRIPTION="An AV1 encoder library focused on speed and safety"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.1"
CLANDRO_PKG_SRCURL=https://github.com/xiph/rav1e/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=06d1523955fb6ed9cf9992eace772121067cca7e8926988a1ee16492febbe01e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	clandro_setup_rust
	clandro_setup_cargo_c

	export CARGO_BUILD_TARGET=$CARGO_TARGET_NAME

	# clash with rust host build
	unset CFLAGS

	cargo fetch \
		--target $CARGO_TARGET_NAME
}

clandro_step_make_install() {
	cargo install \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--path . \
		--force \
		--locked \
		--no-track \
		--target $CARGO_TARGET_NAME \
		--root $CLANDRO_PREFIX

	# `cargo cinstall` refuses to work with Android
	cargo cbuild \
		--release \
		--prefix $CLANDRO_PREFIX \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME

	cd target/$CARGO_TARGET_NAME/release/
	install -Dm644 -t $CLANDRO_PREFIX/include/rav1e/ rav1e.h
	install -Dm644 -t $CLANDRO_PREFIX/lib/pkgconfig/ rav1e.pc
	install -Dm644 -t $CLANDRO_PREFIX/lib/ librav1e.a
	install -Dm644 librav1e.so $CLANDRO_PREFIX/lib/librav1e.so.$CLANDRO_PKG_VERSION
	ln -fs librav1e.so.$CLANDRO_PKG_VERSION \
		$CLANDRO_PREFIX/lib/librav1e.so.${CLANDRO_PKG_VERSION%%.*}
	ln -fs librav1e.so.$CLANDRO_PKG_VERSION $CLANDRO_PREFIX/lib/librav1e.so
}
