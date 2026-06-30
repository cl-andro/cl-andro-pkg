CLANDRO_PKG_HOMEPAGE=https://mp3wrap.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A command-line utility that wraps quickly two or more mp3 files in one single large playable mp3"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/mp3wrap/mp3wrap-${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=1b4644f6b7099dcab88b08521d59d6f730fa211b5faf1f88bd03bf61fedc04e7

clandro_step_pre_configure() {
	rm -f config.status
	autoreconf -fi
}
