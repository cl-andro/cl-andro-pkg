CLANDRO_PKG_HOMEPAGE=https://github.com/chipsenkbeil/distant
CLANDRO_PKG_DESCRIPTION="Library and tooling that supports remote filesystem and process"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.20.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/chipsenkbeil/distant/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=28044639adb3a7984a1c2e721debbaa472e6d826795c5d2f7c434c563e261007
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libssh2, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export OPENSSL_NO_VENDOR=1
	export OPENSSL_INCLUDE_DIR=$CLANDRO_PREFIX/include
	export OPENSSL_LIB_DIR=$CLANDRO_PREFIX/lib
	export LIBSSH2_SYS_USE_PKG_CONFIG=1

	sed -i "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" ${CLANDRO_PKG_SRCDIR}/src/constants.rs

	clandro_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target $CARGO_TARGET_NAME

	local d
	local p=termios-0.2.2.diff
	for d in $CARGO_HOME/registry/src/*/termios-0.2.2; do
		patch --silent -p1 -d ${d} \
			< "$CLANDRO_PKG_BUILDER_DIR/${p}" || :
	done
	p=service-manager-0.2.0.diff
	for d in $CARGO_HOME/registry/src/*/service-manager-*; do
		patch --silent -p1 -d ${d} \
			< "$CLANDRO_PKG_BUILDER_DIR/${p}" || :
	done
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/distant
}

clandro_step_post_massage() {
	mkdir -p ./share/bash-completion/completions
	mkdir -p ./share/zsh/site-functions
	mkdir -p ./share/fish/vendor_completions.d
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		${CLANDRO_PREFIX}/bin/distant generate completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/distant
		${CLANDRO_PREFIX}/bin/distant generate completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_distant
		${CLANDRO_PREFIX}/bin/distant generate completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/distant.fish
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${CLANDRO_PREFIX}/bin/sh
		rm -f ${CLANDRO_PREFIX}/share/bash-completion/completions/distant
		rm -f ${CLANDRO_PREFIX}/share/zsh/site-functions/_distant
		rm -f ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/distant.fish
		exit 0
	EOF
}
