CLANDRO_PKG_HOMEPAGE=https://github.com/svend/cuetools
CLANDRO_PKG_DESCRIPTION="A set of utilities for working with Cue Sheet (cue) and Table of Contents (toc) files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.4.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/svend/cuetools/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=24a2420f100c69a6539a9feeb4130d19532f9f8a0428a8b9b289c6da761eb107
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	autoreconf -fi
}
