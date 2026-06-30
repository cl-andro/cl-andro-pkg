CLANDRO_PKG_HOMEPAGE=https://github.com/Nukesor/pueue
CLANDRO_PKG_DESCRIPTION="A command-line task management tool for sequential and parallel execution of long-running tasks"
CLANDRO_PKG_LICENSE="MIT, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE.MIT, LICENSE.APACHE"
CLANDRO_PKG_MAINTAINER="@stevenxxiu"
CLANDRO_PKG_VERSION="4.0.4"
CLANDRO_PKG_SRCURL="https://github.com/Nukesor/pueue/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=236a47a1cc74721998f4de3eff5062efe8e73c56c05aa19e64fef2e5ee55700f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SERVICE_SCRIPT=("pueued" 'exec pueued 2>&1')

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/tempfile \
		-exec rm -rf '{}' \;

	local patch="$CLANDRO_PKG_BUILDER_DIR/tempfile-bump-rustix.diff"
	local dir="vendor/tempfile"
	echo "Applying patch: $patch"
	patch -p1 -d "$dir" < "${patch}"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo "tempfile = { path = \"./vendor/tempfile\" }" >> Cargo.toml

	cargo update
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pueue
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pueued
}

clandro_step_post_make_install() {
	# Make a placeholder for shell-completions (to be filled with postinst)
	mkdir -p "${CLANDRO_PREFIX}"/share/bash-completion/completions
	mkdir -p "${CLANDRO_PREFIX}"/share/elvish/lib
	mkdir -p "${CLANDRO_PREFIX}"/share/fish/vendor_completions.d
	mkdir -p "${CLANDRO_PREFIX}"/share/nushell/vendor/autoload
	mkdir -p "${CLANDRO_PREFIX}"/share/zsh/site-functions
	touch "${CLANDRO_PREFIX}"/share/bash-completion/completions/pueue
	touch "${CLANDRO_PREFIX}"/share/elvish/lib/pueue.elv
	touch "${CLANDRO_PREFIX}"/share/fish/vendor_completions.d/pueue.fish
	touch "${CLANDRO_PREFIX}"/share/nushell/vendor/autoload/pueue.nu
	touch "${CLANDRO_PREFIX}"/share/zsh/site-functions/_pueue
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh

		pueue completions bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/pueue
		pueue completions elvish > ${CLANDRO_PREFIX}/share/elvish/lib/pueue.elv
		pueue completions fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/pueue.fish
		pueue completions nushell > ${CLANDRO_PREFIX}/share/nushell/vendor/autoload/pueue.nu
		pueue completions zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_pueue
	EOF
	if [ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ]; then
		echo "post_install" > postupg
	fi
}
