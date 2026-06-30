CLANDRO_PKG_HOMEPAGE=https://theunarchiver.com/command-line
CLANDRO_PKG_DESCRIPTION="Command line tools for archive and file unarchiving and extraction"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=()
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_VERSION+=(1.10.8)
CLANDRO_PKG_VERSION+=(1.1)
CLANDRO_PKG_SRCURL=(https://github.com/MacPaw/XADMaster/archive/refs/tags/v${CLANDRO_PKG_VERSION}/XADMaster-${CLANDRO_PKG_VERSION}.tar.gz
                   https://github.com/MacPaw/universal-detector/archive/refs/tags/${CLANDRO_PKG_VERSION[1]}/universal-detector-${CLANDRO_PKG_VERSION[1]}.tar.gz)
CLANDRO_PKG_SHA256=(652953d7988b3c33f4f52b61c357afd1a7c2fc170e5e6e2219f4432b0c4cd39f
                   8e8532111d0163628eb828a60d67b53133afad3f710b1967e69d3b8eee28a811)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libandroid-utimes, libbz2, libc++, libgnustep-base, libicu, libwavpack, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-e -f Makefile.linux"

clandro_step_post_get_source() {
	mv universal-detector-${CLANDRO_PKG_VERSION[1]} UniversalDetector
}

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -D__USE_BSD=1"
	CXXFLAGS+=" $CPPFLAGS"
	export OBJCC="$CC"
	export OBJCFLAGS="$CFLAGS -fobjc-nonfragile-abi"
	export LDFLAGS+=" -landroid-utimes"
	LD="$CXX"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin lsar unar
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 Extra/*.1
	mkdir -p $CLANDRO_PREFIX/share/bash-completion/completions
	for c in lsar unar; do
		install -Dm600 Extra/${c}.bash_completion \
			$CLANDRO_PREFIX/share/bash-completion/completions/${c}
	done
}
