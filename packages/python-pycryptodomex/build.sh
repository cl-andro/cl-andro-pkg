CLANDRO_PKG_HOMEPAGE=https://www.pycryptodome.org/
CLANDRO_PKG_DESCRIPTION="A self-contained Python package of low-level cryptographic primitives"
CLANDRO_PKG_LICENSE="BSD 2-Clause, Public Domain"
CLANDRO_PKG_LICENSE_FILE="LICENSE.rst"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.23.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/Legrandin/pycryptodome/archive/refs/tags/v${CLANDRO_PKG_VERSION}x.tar.gz"
CLANDRO_PKG_SHA256=d3e12d349f62a8c3bd2e7056e2eea925abcfcdd9e2b07bff091bcc05837ac869
CLANDRO_PKG_DEPENDS="python, python-pip"
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	LDFLAGS+=" -Wl,--no-as-needed -lpython${CLANDRO_PYTHON_VERSION}"
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	pip install . --prefix="$CLANDRO_PREFIX" -vv --no-build-isolation --no-deps
}
