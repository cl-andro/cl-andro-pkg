CLANDRO_PKG_HOMEPAGE=https://mruby.org/
CLANDRO_PKG_DESCRIPTION="Lightweight implementation of the Ruby language"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.0"
CLANDRO_PKG_SRCURL=https://github.com/mruby/mruby/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e2ea271dbed14e9f2b33df773ae447b747dbc242ce2675022c0a57efea85a7b4
CLANDRO_PKG_DEPENDS="libandroid-complex-math, readline"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology

clandro_step_make() {
	export CC_FOR_TARGET="$CC"
	export CFLAGS_FOR_TARGET="$CPPFLAGS $CFLAGS \
		-DMRB_USE_READLINE \
		-DMRB_READLINE_HEADER=\\<readline/readline.h\\> \
		-DMRB_READLINE_HISTORY=\\<readline/history.h\\> \
		"
	export LDFLAGS_FOR_TARGET="$LDFLAGS -lncurses -lreadline"
	LDFLAGS_FOR_TARGET+=" -landroid-complex-math"
	unset CPPFLAGS CFLAGS LDFLAGS
	export CC="$CC_FOR_BUILD"
	export LD="$CC_FOR_BUILD"

	export ANDROID_NDK_HOME="$NDK"
	export MRUBY_CONFIG=android-termux
	rake
}

clandro_step_make_install() {
	cd "$CLANDRO_PKG_BUILDDIR/build/android-termux"
	for f in bin/*; do
		install -Dm700 -t $CLANDRO_PREFIX/bin $f
	done
	for f in lib/*.a; do
		install -Dm600 -t $CLANDRO_PREFIX/lib $f
	done
	cp -a "$CLANDRO_PKG_SRCDIR/include" $CLANDRO_PREFIX/
}
