CLANDRO_PKG_HOMEPAGE=https://aosc.io/oma
CLANDRO_PKG_DESCRIPTION="oma is an attempt at reworking APT's interface"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.25.2"
CLANDRO_PKG_SRCURL="https://github.com/AOSC-Dev/oma/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=2dee1f294bf857445e090efdeb6949d75d5171338bc2062b615d7151267b7a08
CLANDRO_PKG_DEPENDS="libnettle, apt"
CLANDRO_PKG_RECOMMENDS="ripgrep"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="v\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--no-default-features
--features nice-setup
"

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/rustls-platform-verifier \
		-exec rm -rf '{}' \;

	find vendor/rustls-platform-verifier -type f -print0 | \
		xargs -0 sed -i \
		-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
		-e "s|ANDROID|DISABLING_THIS_BECAUSE_IT_IS_FOR_BUILDING_AN_APK|g" \
		-e 's|"linux"|"android"|g'

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo 'rustls-platform-verifier = { path = "./vendor/rustls-platform-verifier" }' >> Cargo.toml

	# hardcoded upstream both /data/data/com.zk.clandro/files/usr and /data/data/com.zk.clandro/cache
	local original_name_component_one="com."
	local original_name_component_two="termux"
	local original_name="${original_name_component_one}${original_name_component_two}"
	if [[ "${original_name}" != "${CLANDRO_APP__PACKAGE_NAME}" ]]; then
		find "$CLANDRO_PKG_SRCDIR" -type f | \
			xargs -n 1 sed -i -e "s%${original_name}%${CLANDRO_APP__PACKAGE_NAME}%g"
	fi

	# error: function-like macro '__GLIBC_USE' is not defined
	export BINDGEN_EXTRA_CLANG_ARGS_${CARGO_TARGET_NAME//-/_}="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot --target=${CARGO_TARGET_NAME}"
	CXXFLAGS+=" $CPPFLAGS"
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/oma"

	install -Dm644 "$CLANDRO_PKG_SRCDIR/README.md" "$CLANDRO_PREFIX/share/doc/oma/README"
	install -Dm644 "$CLANDRO_PKG_SRCDIR/data/apt.conf.d/50oma-debian.conf" "$CLANDRO_PREFIX/etc/apt/apt.conf.d/50oma.conf"
	install -Dm644 "$CLANDRO_PKG_SRCDIR/data/config/oma-debian.toml" "$CLANDRO_PREFIX/etc/oma.toml"

	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/bash-completion/completions/oma.bash"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/zsh/site-functions/_oma"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/oma.fish"
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		COMPLETE=bash oma > ${CLANDRO_PREFIX}/share/bash-completion/completions/oma.bash
		COMPLETE=zsh oma > ${CLANDRO_PREFIX}/share/zsh/site-functions/_oma
		COMPLETE=fish oma > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/oma.fish
	EOF
}
