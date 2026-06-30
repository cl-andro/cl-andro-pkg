CLANDRO_PKG_HOMEPAGE=https://github.com/letoams/hash-slinger
CLANDRO_PKG_DESCRIPTION="Various tools to generate special DNS records"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/letoams/hash-slinger/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=5a03bfeba39134773e0a98b1607521b5b70fba58173a20deb7e032cc7e949bcb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ca-certificates, gnupg, openssh, python, pyunbound, resolv-conf, swig, python-pip"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_TARGET_DEPS="dnspython, ipaddr, m2crypto, python-gnupg"

clandro_step_make() {
	:
}

clandro_step_make_install() {
	local f
	for f in openpgpkey sshfp tlsa; do
		install -Dm700 -t $CLANDRO_PREFIX/bin ${f}
		install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 ${f}.1
	done
}
