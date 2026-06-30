CLANDRO_PKG_HOMEPAGE=https://github.com/grame-cncm/faust
CLANDRO_PKG_DESCRIPTION="A functional programming language for signal processing and sound synthesis"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.85.5"
CLANDRO_PKG_SRCURL=https://github.com/grame-cncm/faust/releases/download/${CLANDRO_PKG_VERSION}/faust-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fc18bc2b1b31044d0bd2c35ee92d80d4428c9008ac6a03acf4163109803941d7
CLANDRO_PKG_AUTO_UPDATE=true
# Faust is licensed under LGPL 2.1
# The faustlibraries are licensed under the: STK 4.3.0 License
CLANDRO_PKG_LICENSE="LGPL-2.1, custom"
CLANDRO_PKG_LICENSE_FILE="COPYING.txt, libraries/licenses/stk-4.3.0.md"
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	cd $CLANDRO_PKG_SRCDIR/build
	mkdir faustdir && cd faustdir
	clandro_setup_cmake

	# Build the faust compiler with backends for various language + faust API libraries
	# these values are copied from build/Makefile:323
	cmake -C ../backends/light.cmake \
		-C ../targets/all.cmake \
		-DCMAKE_BUILD_TYPE=Release \
		"-DWORKLET=off" \
		-DINCLUDE_LLVM=OFF \
		-DUSE_LLVM_CONFIG=ON \
		-DLLVM_PACKAGE_VERSION= \
		-DLLVM_LIBS="" \
		-DLLVM_LIB_DIR="" \
		-DLLVM_INCLUDE_DIRS="" \
		-DLLVM_DEFINITIONS="" \
		-DLLVM_LD_FLAGS="" \
		-DLIBSDIR=lib \
		-DBUILD_HTTP_STATIC=OFF \
		-DCMAKE_FIND_ROOT_PATH=$CLANDRO_PREFIX \
		-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX \
		-DCMAKE_INSTALL_LIBDIR=$CLANDRO_PREFIX/lib \
		-DCMAKE_C_FLAGS="-DANDROID $CFLAGS $CPPFLAGS" \
		-DCMAKE_CXX_FLAGS="-DANDROID $CXXFLAGS $CPPFLAGS" \
		-DCMAKE_SKIP_INSTALL_RPATH=ON \
		-DCMAKE_USE_SYSTEM_LIBRARIES=True \
		-DDOXYGEN_EXECUTABLE= \
		-DBUILD_TESTING=OFF \
		-G 'Unix Makefiles' ..
}

clandro_step_make() {
	cd $CLANDRO_PKG_SRCDIR
	make -C build PREFIX=$CLANDRO_PREFIX
}

clandro_step_make_install() {
	make -C build install PREFIX=$CLANDRO_PREFIX
	cd libraries
	cp *.lib old/*.lib $CLANDRO_PREFIX/share/faust
}

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/bin

	# these are pretty much unusable inside Termux; requiring QT/Jack/Unity
	for i in alqt caqt jackserver jaqtchain lv2 netjackqt paqt cagtk dummymem rosgtk \
		raqt linuxunity jack jaqt jackrust jackconsole dummy; do
		rm faust2${i}
	done

	mv usage.sh faustusage.sh
	# find all ASCII scripts
	local faustscripts=$(find . -type f -exec grep -Iq . {} \; -print)

	sed -i 's/usage.sh/faustusage.sh/g' $faustscripts

	# We need to replace all instance of "/usr" with $CLANDRO_PREFIX but we can't do it
	# in one go since $CLANDRO_PREFIX also contain "/usr" so we risk doubling the prefix:
	# "/data/data/com.zk.clandro/files/data/data/com.zk.clandro/files/usr"

	sed -i "s@$CLANDRO_PREFIX@\$CLANDRO_PREFIX@g" $faustscripts
	sed -i "s@/usr/local@\$CLANDRO_PREFIX@g" $faustscripts
	sed -i "s@/usr@\$CLANDRO_PREFIX@g" $faustscripts

	# turns /tmp and /var with $CLANDRO_PREFIX_{tmp,var}
	for i in tmp var; do
		sed -i "s@\$CLANDRO_PREFIX/${i}/@\$CLANDRO_PREFIX_${i}@g" $faustscripts
		perl -pi -e 's@(?<=("|[^[:alnum:]_\.]))/'${i}'(?=(/|\s))@\$CLANDRO_PREFIX_'${i}'@g' \
			$faustscripts
	done

	# restore
	for i in tmp var; do
		sed -i "s@\$CLANDRO_PREFIX_${i}@\$CLANDRO_PREFIX/${i}@g" $faustscripts
	done
	sed -i "s@\$CLANDRO_PREFIX@$CLANDRO_PREFIX@g" $faustscripts

	cd $CLANDRO_PREFIX/share/faust
	rm jack-*.cpp && rm *-gtk.{c,cpp} *-qt.cpp
}
