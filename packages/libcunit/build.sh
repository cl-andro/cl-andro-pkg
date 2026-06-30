CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/cunit/
CLANDRO_PKG_DESCRIPTION="C Unit Testing Framework"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.1.3
CLANDRO_PKG_REVISION=1
_VERSION=$(echo "$CLANDRO_PKG_VERSION" | sed -E 's/(.*)\./\1-/')
CLANDRO_PKG_SRCURL=https://github.com/Linaro/libcunit/releases/download/${_VERSION}/CUnit-${_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-automated
--enable-basic
--enable-console
"

clandro_step_pre_configure() {
	libtoolize --force --copy
	aclocal
	autoheader
	automake --add-missing --include-deps --copy
	autoconf
}
