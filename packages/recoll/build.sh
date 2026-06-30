CLANDRO_PKG_HOMEPAGE=https://www.recoll.org/
CLANDRO_PKG_DESCRIPTION="Full-text search for your desktop"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.43.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://www.recoll.org/recoll-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=391e5c6edb78c6cd487d94c5abe44fe0c64f99f0acdab287d5821fd4e806f89b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="aspell, file, jsoncpp,  libc++, libiconv, libxapian, libxml2, libxslt, zlib"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
# -Dext4-birthtime=false disables the use of the statx syscall
# it is also set to false by default at time of writing,
# but set it explicitly because Termux previously
# had a patch forcibly disabling the use of the statx syscall in recoll
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dpython-chm=false
-Dpython-aspell=false
-Daspell=true
-Dx11mon=false
-Dqtgui=false
-Dsystemd=false
-Dext4-birthtime=false
"

clandro_step_pre_configure() {
	clandro_setup_python_pip
	rm -f CMakeLists.txt

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	CXXFLAGS+=" -fPIC"
	CPPFLAGS+=" -I${CLANDRO_PREFIX}/include/python${CLANDRO_PYTHON_VERSION}/"
}
