CLANDRO_PKG_HOMEPAGE=https://include-what-you-use.org/
CLANDRO_PKG_DESCRIPTION="A tool to analyze #includes in C and C++ source files"
CLANDRO_PKG_LICENSE=NCSA
CLANDRO_PKG_MAINTAINER="@clandro"
# Update this and the clang version below when libllvm is updated:
CLANDRO_PKG_VERSION="0.25"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/include-what-you-use/include-what-you-use/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=2e8381368ec0a6ecb770834bce00fc62efa09a2b2f9710ed569acbb823ead9cc
CLANDRO_PKG_AUTO_UPDATE=false # can't be auto-updated since release correspond to clang version.
CLANDRO_PKG_DEPENDS="clang (>= 21), clang (<< 22), libc++, python"
CLANDRO_PKG_BUILD_DEPENDS="libllvm-static"
