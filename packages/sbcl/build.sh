CLANDRO_PKG_HOMEPAGE="http://www.sbcl.org/"
CLANDRO_PKG_DESCRIPTION="A high performance Common Lisp compiler"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.4"
# sourceforge archive is a precompiled SBCL release for GNU/Linux to use as host Lisp for bootstrapping
CLANDRO_PKG_SRCURL=(
	https://github.com/sbcl/sbcl/archive/refs/tags/sbcl-${CLANDRO_PKG_VERSION}.tar.gz
	https://sourceforge.net/projects/sbcl/files/sbcl/${CLANDRO_PKG_VERSION}/sbcl-${CLANDRO_PKG_VERSION}-x86-64-linux-binary.tar.bz2
)
CLANDRO_PKG_SHA256=(
	15cc279326263bfba27d18a8a493ab1889d3178fa7c0c5b1a4a026a918401da1
	466933f9b4f403b6a49b2a7cc755fdd5d827c3b354aa3c8c0d96697e5da1e9fc
)
CLANDRO_PKG_DEPENDS="zstd"
# CLANDRO_ON_DEVICE_BUILD=true  build dependencies: ecl, strace
# CLANDRO_ON_DEVICE_BUILD=false build dependencies: aosp-libs, bash, coreutils, strace
# NOTE: if you are bootstrapping on-device, if either is desired, it is possible to manually
# implement both an on-device build and an x86 build of ecl, but those are currently
# unimplemented in termux-packages at time of writing.
# the build dependency is disabled to avoid dependency errors when cross-compiling in CI for x86.
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, bash, coreutils, strace"
# it is extremely difficult to port SBCL to 32-bit Android because of multiple severe
# incompatibilties, like the lack of support for a fully position-independent runtime executable.
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	cd "${CLANDRO_PKG_SRCDIR}/sbcl-${CLANDRO_PKG_VERSION}-x86-64-linux"
	export INSTALL_ROOT="$CLANDRO_PKG_HOSTBUILD_DIR"
	sh install.sh
}

clandro_step_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_setup_proot
	fi

	# See doc/PACKAGING-SBCL.txt
	echo "\"${CLANDRO_PKG_FULLVERSION}.termux\"" > version.lisp-expr
}

clandro_step_make() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		export LINKFLAGS="$LDFLAGS"
		sh make.sh \
			--xc-host="${CLANDRO_PREFIX}/bin/ecl --norc" \
			--prefix="$CLANDRO_PREFIX" \
			--with-android \
			--fancy \
			--without-gcc-tls

		pushd tests
		sh run-tests.sh
		popd
	else
		# if not appended to make.sh, the build fails with no error message
		# only after cross-compilation, not non-cross-compilation
		echo "exit 0" >> make.sh

		# build SBCL inside a proot that runs bionic-libc $CLANDRO_PREFIX/bin/uname,
		# some other bionic-libc commands, and bionic-libc build artifacts,
		# but runs the host cross-compiler and the host sbcl binary to compile
		# bootstrapping lisp code and compile the C-based runtime code.
		termux-proot-run env LD_PRELOAD= LD_LIBRARY_PATH= \
			CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS" LINKFLAGS="$LDFLAGS" \
			sh make.sh \
				--xc-host="${CLANDRO_PKG_HOSTBUILD_DIR}/bin/sbcl --norc" \
				--prefix="$CLANDRO_PREFIX" \
				--with-android \
				--fancy \
				--without-gcc-tls

		pushd tests
		# for passing some tests
		mkdir -p "$CLANDRO_ANDROID_HOME"

		# run test suite inside proot
		termux-proot-run env LD_PRELOAD= LD_LIBRARY_PATH= \
			CC="$CC" CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS" LINKFLAGS="$LDFLAGS" \
			TMPDIR="$CLANDRO_PREFIX/tmp" \
			sh run-tests.sh
		popd
	fi

	# docs fail to build even after trying to configure texinfo and texlive,
	# both on-device and after cross-compilation.
	# error:
	# texi2dvi -q -I "docstrings/" -I "../../contrib/" sbcl.texinfo
	# start-stop.texinfo:113: I can't find file `fun-sb-ext-exit.texinfo'.
	# texi2dvi: etex exited with bad status, quitting
	#if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
	#	make -C doc/manual
	#else
	#	# build docs inside proot because this step needs the newly compiled bionic-libc sbcl
	#	termux-proot-run env LD_PRELOAD= LD_LIBRARY_PATH= \
	#		make -C doc/manual
	#fi
	# however, at least the command "man sbcl" does work after installation despite this.
}

clandro_step_make_install() {
	INSTALL_ROOT="$CLANDRO_PREFIX" sh install.sh
}
