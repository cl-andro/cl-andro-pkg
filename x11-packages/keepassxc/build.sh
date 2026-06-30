CLANDRO_PKG_HOMEPAGE=https://keepassxc.org/
CLANDRO_PKG_DESCRIPTION="Cross-platform community-driven port of Keepass password manager"
# KeePassXC code is licensed under GPL-2 or GPL-3.
CLANDRO_PKG_LICENSE="BSD 3-Clause, CC0-1.0, GPL-2.0, GPL-3.0, LGPL-2.1, LGPL-3.0, MIT, OFL-1.1"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSE.BSD, LICENSE.CC0, LICENSE.GPL-2, LICENSE.GPL-3, LICENSE.LGPL-2.1, LICENSE.LGPL-3, LICENSE.MIT, LICENSE.NOKIA-LGPL-EXCEPTION, LICENSE.OFL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.12"
CLANDRO_PKG_SRCURL="https://github.com/keepassxreboot/keepassxc/releases/download/${CLANDRO_PKG_VERSION}/keepassxc-${CLANDRO_PKG_VERSION}-src.tar.xz"
CLANDRO_PKG_SHA256=c9f5c4fe4b93d232795a9d8bfb58d129a492fcaa79c846eb637399164bcdb2d8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="argon2, botan3, libc++, libminizip, libqrencode, libx11, libxtst, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, readline, zlib"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_XC_NETWORKING=ON
-DWITH_XC_SSHAGENT=ON
-DWITH_XC_UPDATECHECK=OFF
-DWITH_XC_BROWSER=ON
"
