CLANDRO_PKG_HOMEPAGE=https://bs2b.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Bauer stereophonic-to-binaural DSP"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/bs2b/libbs2b-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=4799974becdeeedf0db00115bc63f60ea3fe4b25f1dfdb6903505839a720e46f
CLANDRO_PKG_DEPENDS="libc++, libsndfile"

clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
