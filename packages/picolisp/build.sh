CLANDRO_PKG_HOMEPAGE="https://picolisp.com/wiki/?home"
CLANDRO_PKG_DESCRIPTION="Lisp interpreter and application server framework"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.3"
CLANDRO_PKG_SRCURL=https://software-lab.de/picoLisp-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=5e8e1d8ff08221c5229fdabe031a4fec161608521bcb377bb493e3fd8e073bca
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcrypt, libffi, openssl, readline"
CLANDRO_PKG_BUILD_IN_SRC=true
# For 32-bit archs we nees to build minipicolisp
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_make() {
	sed -i "s|/usr/lib/picolisp/lib.l|${CLANDRO_PREFIX}/lib/picolisp/lib.l|" $CLANDRO_PKG_SRCDIR/bin/pil
	sed -i "s|/usr/lib/picolisp/lib.l|${CLANDRO_PREFIX}/lib/picolisp/lib.l|" $CLANDRO_PKG_SRCDIR/bin/vip
	cd $CLANDRO_PKG_SRCDIR/src
	$CC -O3 -c -emit-llvm base.ll
	$CC -O3 -w -c -D_OS="\"Android\"" -D_CPU="\"$CLANDRO_ARCH\"" `$PKGCONFIG --cflags libffi` -emit-llvm lib.c
	mkdir -p ../bin ../lib
	$CC $CFLAGS $LDFLAGS base.bc lib.bc -o ../bin/picolisp -rdynamic -lutil -lm -ldl -lreadline -lffi
	$STRIP ../bin/picolisp

	$CC -O3 -c -emit-llvm ext.ll
	$CC $CFLAGS $LDFLAGS ext.bc -o ../lib/ext.so -shared
	$STRIP ../lib/ext.so

	$CC -O3 -c -emit-llvm ht.ll
	$CC $CFLAGS $LDFLAGS ht.bc -o ../lib/ht.so -shared
	$STRIP ../lib/ht.so

	$CC -O3 -w $CFLAGS -I$CLANDRO_PREFIX/include -L$CLANDRO_PREFIX/lib $LDFLAGS -o ../bin/balance balance.c
	$CC -O3 -w $CFLAGS -I$CLANDRO_PREFIX/include -L$CLANDRO_PREFIX/lib $LDFLAGS -o ../bin/ssl ssl.c -lssl -lcrypto
	$CC -O3 -w $CFLAGS -I$CLANDRO_PREFIX/include -L$CLANDRO_PREFIX/lib $LDFLAGS -o ../bin/httpGate httpGate.c -lssl -lcrypto

	$CC -O3 -w -D_OS="\"Android\"" -D_CPU="\"$CLANDRO_ARCH\"" $CFLAGS -I$CLANDRO_PREFIX/include -L$CLANDRO_PREFIX/lib $LDFLAGS sysdefs.c -o ../bin/sysdefs-gen

	$STRIP ../bin/balance
	$STRIP ../bin/httpGate
	$STRIP ../bin/ssl
	$STRIP ../bin/sysdefs-gen
	# psh, pty, vip, watchdog are not stripped as they are plaintext lisp files
}

clandro_step_make_install() {
	cd $CLANDRO_PKG_SRCDIR/src

	install -Dm755 -t $CLANDRO_PREFIX/bin ../bin/{picolisp,pil}
	install -Dm755 -t $CLANDRO_PREFIX/lib/picolisp/bin ../bin/{balance,httpGate,pty,psh,ssl,sysdefs-gen,vip,watchdog}
	install -Dm644 -t $CLANDRO_PREFIX/lib/picolisp ../{ext.l,lib.css,lib.l}
	install -Dm644 -t $CLANDRO_PREFIX/share/man/man1 ../man/man1/*.1

	install -d -m755 $CLANDRO_PREFIX/lib/picolisp/lib
	cp -r ../lib $CLANDRO_PREFIX/lib/picolisp
	cp -r ../loc $CLANDRO_PREFIX/lib/picolisp
	cp -r ../src $CLANDRO_PREFIX/lib/picolisp
	cp -r ../test $CLANDRO_PREFIX/lib/picolisp
	cp -r ../doc $CLANDRO_PREFIX/lib/picolisp
	cp -r ../img $CLANDRO_PREFIX/lib/picolisp

	install -Dm644 ../lib/bash_completion $CLANDRO_PREFIX/share/bash-completion/completions/pil
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	$CLANDRO_PREFIX/lib/picolisp/bin/sysdefs-gen > $CLANDRO_PREFIX/lib/picolisp/lib/sysdefs
	EOF

	cat <<- EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	rm -f $CLANDRO_PREFIX/lib/picolisp/lib/sysdefs
	EOF
}
