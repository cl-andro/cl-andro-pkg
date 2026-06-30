CLANDRO_PKG_HOMEPAGE=https://wasmer.io/
CLANDRO_PKG_DESCRIPTION="A fast and secure WebAssembly runtime"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="ATTRIBUTIONS, LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.0.1"
CLANDRO_PKG_SRCURL=https://github.com/wasmerio/wasmer/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1cd67765b834dd509d29fd7420819af37af852b877bc32b31c07bf92d27ffd31
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_AUTO_UPDATE=true

# missing support in wasmer-emscripten, wasmer-vm
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_pre_configure() {
	# https://github.com/rust-lang/compiler-builtins#unimplemented-functions
	# https://github.com/rust-lang/rfcs/issues/2629
	# https://github.com/rust-lang/rust/issues/46651
	# https://github.com/termux/termux-packages/issues/8029
	local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	export WASMER_INSTALL_PREFIX="${CLANDRO_PREFIX}"
	clandro_setup_rust
}

clandro_step_make() {
	local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)

	# https://github.com/wasmerio/wasmer/blob/master/Makefile
	# Makefile only does host builds
	# Dropping host build due to https://github.com/wasmerio/wasmer/issues/2822

	local compilers="cranelift"

	# TODO llvm-sys.rs crate has issues with libLLVM*.so as static archive
	#compilers+=",llvm"
	#export LLVM_VERSION=$(${CLANDRO_PREFIX}/bin/llvm-config --version)
	#export LLVM_SYS_140_PREFIX=$(${CLANDRO_PREFIX}/bin/llvm-config --prefix)

	case "${CLANDRO_ARCH}" in
	aarch64) compilers+=",singlepass" ;;
	x86_64) compilers+=",singlepass" ;;
	esac

	local compiler_features="${compilers},wasmer-artifact-create,static-artifact-create,wasmer-artifact-load,static-artifact-load"
	local capi_compiler_features="${compilers/,llvm/},wasmer-artifact-create,static-artifact-create,wasmer-artifact-load,static-artifact-load"

	echo "make build-wasmer"
	# https://github.com/wasmerio/wasmer/blob/master/lib/cli/Cargo.toml
	cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path lib/cli/Cargo.toml \
		--no-default-features \
		--features "wat,wast,${compiler_features}" \
		--bin wasmer

	echo "make build-capi"
	cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path lib/c-api/Cargo.toml \
		--no-default-features \
		--features "wat,compiler,wasi,middlewares,webc_runner,${capi_compiler_features}"

	echo "make build-wasmer-headless-minimal"
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C panic=abort"
	cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path=lib/cli/Cargo.toml \
		--no-default-features \
		--features sys,headless-minimal,${compilers} \
		--bin wasmer-headless

	echo "make build-capi-headless"
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C panic=abort -C link-dead-code -C lto -O -C embed-bitcode=yes"
	cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release \
		--manifest-path lib/c-api/Cargo.toml \
		--no-default-features \
		--features compiler-headless,wasi,webc_runner,${compilers} \
		--target-dir target/headless
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/wasmer"
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/wasmer-headless"

	for h in lib/c-api/*.h; do
		install -Dm644 "${h}" "${CLANDRO_PREFIX}"/include/$(basename "${h}")
	done
	# copy to share/doc/wasmer instead of include
	install -Dm644 "lib/c-api/README.md" "${CLANDRO_PREFIX}/share/doc/wasmer/wasmer-README.md"

	local shortver="${CLANDRO_PKG_VERSION%.*}"
	local majorver="${shortver%.*}"
	install -Dm644 "target/${CARGO_TARGET_NAME}/release/libwasmer.so" "${CLANDRO_PREFIX}/lib/libwasmer.so.${CLANDRO_PKG_VERSION}"
	ln -sf "libwasmer.so.${CLANDRO_PKG_VERSION}" "${CLANDRO_PREFIX}/lib/libwasmer.so.${shortver}"
	ln -sf "libwasmer.so.${CLANDRO_PKG_VERSION}" "${CLANDRO_PREFIX}/lib/libwasmer.so.${majorver}"
	ln -sf "libwasmer.so.${CLANDRO_PKG_VERSION}" "${CLANDRO_PREFIX}/lib/libwasmer.so"
	install -Dm644 "target/${CARGO_TARGET_NAME}/release/libwasmer.a" "${CLANDRO_PREFIX}/lib/libwasmer.a"

	install -Dm644 "target/headless/${CARGO_TARGET_NAME}/release/libwasmer.so" "${CLANDRO_PREFIX}/lib/libwasmer-headless.so"
	install -Dm644 "target/headless/${CARGO_TARGET_NAME}/release/libwasmer.a" "${CLANDRO_PREFIX}/lib/libwasmer-headless.a"

	# https://github.com/wasmerio/wasmer/blob/master/lib/cli/src/commands/config.rs
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/lib/pkgconfig/wasmer.pc"
	cat <<- EOF > "${CLANDRO_PREFIX}/lib/pkgconfig/wasmer.pc"
	prefix=${CLANDRO_PREFIX}
	exec_prefix=${CLANDRO_PREFIX}/bin
	includedir=${CLANDRO_PREFIX}/include
	libdir=${CLANDRO_PREFIX}/lib

	Name: wasmer
	Description: The Wasmer library for running WebAssembly
	Version: ${CLANDRO_PKG_VERSION}
	Cflags: -I${CLANDRO_PREFIX}/include
	Libs: -L${CLANDRO_PREFIX}/lib -lwasmer
	EOF

	cp docs/ATTRIBUTIONS.md ATTRIBUTIONS

	unset LLVM_SYS_140_PREFIX LLVM_VERSION WASMER_INSTALL_PREFIX
}

clandro_step_create_debscripts() {
	cat <<- EOL > postinst
	#1${CLANDRO_PREFIX}/bin/sh
	if [ -n "\$(command -v wapm)" ]; then
	echo "
	===== Post-install notice =====

	Upstream has deprecated 'wapm' package.
	You may want to remove 'wapm' package.

	===== Post-install notice =====
	"
	fi
	EOL
}
