CLANDRO_PKG_HOMEPAGE=https://cooklang.org
CLANDRO_PKG_DESCRIPTION="A suite of tools to create shopping lists and maintain food recipes"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.29.1"
CLANDRO_PKG_SRCURL=https://github.com/cooklang/cookcli/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=20e7b60eb5d0a98ba182d8fadc6e95d70d99c9935a391313e532fa5f6619bff8
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_nodejs
	clandro_setup_rust

	# i686: __atomic_load
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi
}

clandro_step_make() {
	npm install
	npm run build-css

	cargo build --jobs "${CLANDRO_PKG_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/cook"
}
