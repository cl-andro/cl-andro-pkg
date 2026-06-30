CLANDRO_PKG_HOMEPAGE=https://github.com/doctest/doctest
CLANDRO_PKG_DESCRIPTION="The fastest feature-rich C++11/14/17/20 single-header testing framework"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.2"
CLANDRO_PKG_SRCURL=https://github.com/doctest/doctest/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9189960c2bbbc4f3382ce0773b2bb5f13e3afd8fed47f55f193e11e85a4f9854
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	CXXFLAGS+=" -Wno-error=unsafe-buffer-usage -Wno-error=nullable-to-nonnull-conversion"
}
