# Contributor: @Neo-Oli
CLANDRO_PKG_HOMEPAGE=https://otr.cypherpunks.ca
CLANDRO_PKG_DESCRIPTION="Off-the-Record (OTR) Messaging allows you to have private conversations over instant messaging by providing: Encryption, Authentication, Deniability, Perfect forward secrecy"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_VERSION=4.1.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
CLANDRO_PKG_SRCURL=https://otr.cypherpunks.ca/libotr-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8b3b182424251067a952fb4e6c7b95a21e644fbb27fbd5f8af2b2ed87ca419f5
CLANDRO_PKG_DEPENDS="libgcrypt"
CLANDRO_PKG_BREAKS="libotr-dev"
CLANDRO_PKG_REPLACES="libotr-dev"
CLANDRO_PKG_BUILD_DEPENDS="libgpg-error"
CLANDRO_PKG_BUILD_IN_SRC=true
