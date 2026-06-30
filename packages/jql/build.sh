CLANDRO_PKG_HOMEPAGE="https://github.com/yamafaktory/jql"
CLANDRO_PKG_DESCRIPTION="A JSON Query Language CLI tool"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="../../LICENSE-APACHE, ../../LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="8.1.2"
CLANDRO_PKG_SRCURL=https://github.com/yamafaktory/jql/archive/refs/tags/jql-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a8d76cf0d6c15988034cb186975fb0da360041e59350b2abead52c7801747315
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	CLANDRO_PKG_SRCDIR+="/crates/jql"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"

	# ld.lld: error: undefined symbol: __atomic_load
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi
}
