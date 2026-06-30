CLANDRO_PKG_HOMEPAGE=http://www.clifford.at/stfl
CLANDRO_PKG_DESCRIPTION="Structured Terminal Forms Language/Library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.24
CLANDRO_PKG_REVISION=7
# Using newsboat patched fork:
# https://github.com/newsboat/stfl
# Awaiting newsboat switching away from stfl, after which this package can be dropped:
# https://github.com/newsboat/newsboat/issues/232
CLANDRO_PKG_SRCURL=https://github.com/newsboat/stfl/archive/c2c10b8a50fef613c0aacdc5d06a0fa610bf79e9.zip
CLANDRO_PKG_SHA256=dd912547e64f9fab5dab82731f4acea061f3bdc038dad374e0b82bf32722b729
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv, ncurses"
CLANDRO_PKG_BREAKS="stfl-dev"
CLANDRO_PKG_REPLACES="stfl-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure(){
	# mkmf.rb can't find header files for ruby at /usr/lib/ruby/include/ruby.h
	sed -i 's/FOUND_RUBY = 1/FOUND_RUBY = 0/g' Makefile.cfg

	# /usr/bin/ld: ../libstfl.a(public.o): Relocations in generic ELF (EM: 183)
	# /usr/bin/ld: ../libstfl.a: error adding symbols: file in wrong format
	sed -i 's/FOUND_PERL5 = 1/FOUND_PERL5 = 0/g' Makefile.cfg

	CPPFLAGS+=" -DNCURSES_WIDECHAR"
}

clandro_step_configure() {
	CC+=" $CPPFLAGS"
	export LDLIBS="-liconv"
}
