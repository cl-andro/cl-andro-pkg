# cl-andro (alamgir-zk) — custom package
CLANDRO_PKG_HOMEPAGE=https://www.jefftk.com/icdiff
CLANDRO_PKG_DESCRIPTION="Improved colored diff (cl-andro custom build)"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.10
CLANDRO_PKG_SRCURL=https://github.com/jeffkaufman/icdiff/archive/refs/tags/release-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=SKIP_CHECKSUM
CLANDRO_PKG_DEPENDS="python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm700 icdiff "$CLANDRO_PREFIX/bin/icdiff"
	install -Dm600 icdiff.1 "$CLANDRO_PREFIX/share/man/man1/icdiff.1" 2>/dev/null || true
}
