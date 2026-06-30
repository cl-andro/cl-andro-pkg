CLANDRO_PKG_HOMEPAGE=http://www.mirbsd.org/mksh.htm
CLANDRO_PKG_DESCRIPTION="The MirBSD Korn Shell - an enhanced version of the public domain ksh"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=59c
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=http://download.openpkg.org/components/cache/mksh/mksh-R${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	sh Build.sh -r
}

clandro_step_make_install() {
	install -Dm700 mksh "$CLANDRO_PREFIX"/bin/mksh
	install -Dm600 mksh.1 "$CLANDRO_PREFIX"/share/man/man1/mksh.1
}
