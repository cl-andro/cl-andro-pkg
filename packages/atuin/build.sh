CLANDRO_PKG_HOMEPAGE=https://atuin.sh/
CLANDRO_PKG_DESCRIPTION="Magical shell history"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="../../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="18.16.0"
CLANDRO_PKG_SRCURL="https://github.com/atuinsh/atuin/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=433a6ee912d84b2aa4b59b329775a7ee1a1cdc3094412c2f185ac5ce681a64f0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_protobuf
	clandro_setup_rust
	clandro_setup_cmake
	CLANDRO_PKG_SRCDIR+="/crates/atuin"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"

	# https://github.com/termux/termux-packages/issues/8029
	if [[ "${CLANDRO_ARCH}" == "x86_64" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi

	# clash with rust host build
	unset CFLAGS

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
}

clandro_step_post_make_install() {
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/atuin
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_atuin
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/atuin.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		atuin gen-completions -s bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/atuin
		atuin gen-completions -s zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_atuin
		atuin gen-completions -s fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/atuin.fish
	EOF
}
