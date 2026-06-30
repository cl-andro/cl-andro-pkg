CLANDRO_PKG_HOMEPAGE=https://electrum.org
CLANDRO_PKG_DESCRIPTION="Electrum is a lightweight Bitcoin wallet"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.7.1"
CLANDRO_PKG_SRCURL="https://download.electrum.org/$CLANDRO_PKG_VERSION/Electrum-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=90ac633217e3175c1560388467ab7d3e00321502ee51e4beda566e944bf6051f
# The python dependency list should be compared to
# contrib/requirements/requirements.txt in upstream project on every
# update (or at least every major update).
# https://github.com/spesmilo/electrum/blob/master/contrib/requirements/requirements.txt
# Disable auto updates for now.
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="python, libsecp256k1, python-pip, python-cryptography"
CLANDRO_PKG_PYTHON_TARGET_DEPS="'qrcode', 'protobuf>=3.20', 'qdarkstyle>=3.2', 'aiorpcx>=0.25.0,<0.26', 'aiohttp>=3.11.0,<4.0.0', 'aiohttp_socks>=0.9.2', 'certifi', 'jsonpatch', 'electrum_ecc>=0.0.4,<0.1', 'electrum_aionostr>=0.1.0,<0.2', 'attrs>=20.1.0,<23', 'dnspython>=2.2,<2.5'"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
# asciinema previously contained some files that python packages have in common
CLANDRO_PKG_CONFLICTS="asciinema (<< 1.4.0-1)"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_SERVICE_SCRIPT=("electrum" 'exec electrum daemon 2>&1')
