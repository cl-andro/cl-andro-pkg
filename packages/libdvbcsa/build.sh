CLANDRO_PKG_HOMEPAGE="https://www.videolan.org/developers/libdvbcsa.html"
CLANDRO_PKG_DESCRIPTION="An implementation of the DVB Common Scrambling Algorithm - DVB/CSA - with encryption and decryption capabilities"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Aditya Alok <alok@termux.org> & @clandro"
CLANDRO_PKG_VERSION=1.1.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://download.videolan.org/pub/videolan/libdvbcsa/${CLANDRO_PKG_VERSION}/libdvbcsa-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=4db78af5cdb2641dfb1136fe3531960a477c9e3e3b6ba19a2754d046af3f456d
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure(){
	autoreconf -fvi
}
