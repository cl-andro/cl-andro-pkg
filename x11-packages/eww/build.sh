CLANDRO_PKG_HOMEPAGE=https://elkowar.github.io/eww/
CLANDRO_PKG_DESCRIPTION="ElKowars wacky widgets"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/elkowar/eww
CLANDRO_PKG_DEPENDS="glib, gtk3, gtk-layer-shell, pango, gdk-pixbuf, libcairo, libdbusmenu-gtk3"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	rm -rf $CARGO_HOME/registry/src/*/x11rb-protocol-*
	rm -rf $CARGO_HOME/registry/src/*/zbus-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local d p
	p="x11rb-protocol-path.diff"
	for d in $CARGO_HOME/registry/src/*/x11rb-protocol-*; do
		sed \
			"s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			"${CLANDRO_PKG_BUILDER_DIR}/${p}" \
			| patch --silent -p1 -d ${d}
	done

	p="zbus-path.diff"
	for d in $CARGO_HOME/registry/src/*/zbus-*; do
		sed \
			"s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			"${CLANDRO_PKG_BUILDER_DIR}/${p}" \
			| patch --silent -p1 -d ${d}
	done
}

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/eww
}

clandro_step_post_massage() {
	rm -rf $CARGO_HOME/registry/src/*/x11rb-protocol-*
	rm -rf $CARGO_HOME/registry/src/*/zbus-*
}
