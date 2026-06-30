# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/bwalex/tc-play
CLANDRO_PKG_DESCRIPTION="Free and simple TrueCrypt implementation based on dm-crypt."
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/bwalex/tc-play/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ad53cd814a23b4f61a1b2b6dc2539624ffb550504c400c45cbd8cd1da4c7d90a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libdevmapper, libuuid, libgcrypt"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DLIB_SUFFIX=
"
