CLANDRO_PKG_HOMEPAGE=https://openvpn.net/easyrsa.html
CLANDRO_PKG_DESCRIPTION="Simple shell based CA utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.0.1
CLANDRO_PKG_DEPENDS="openssl-tool"
CLANDRO_PKG_SRCURL=https://github.com/OpenVPN/easy-rsa/releases/download/$CLANDRO_PKG_VERSION/EasyRSA-$CLANDRO_PKG_VERSION.tgz
CLANDRO_PKG_SHA256=dbdaf5b9444b99e0c5221fd4bcf15384c62380c1b63cea23d42239414d7b2d4e
CLANDRO_PKG_CONFFILES="etc/easy-rsa/openssl-1.0.cnf, etc/easy-rsa/vars"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
    install -D -m0755 easyrsa "${CLANDRO_PREFIX}"/bin/easyrsa

    install -D -m0644 openssl-1.0.cnf "${CLANDRO_PREFIX}"/etc/easy-rsa/openssl-1.0.cnf
    install -D -m0644 vars.example "${CLANDRO_PREFIX}"/etc/easy-rsa/vars
    install -d -m0755 "${CLANDRO_PREFIX}"/etc/easy-rsa/x509-types/
    install -m0644 x509-types/* "${CLANDRO_PREFIX}"/etc/easy-rsa/x509-types/
}
