CLANDRO_PKG_HOMEPAGE=https://dirb.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Web Directory Fuzzer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.22
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/dirb/files/dirb/${CLANDRO_PKG_VERSION}/dirb${CLANDRO_PKG_VERSION/./}.tar.gz
CLANDRO_PKG_SHA256=f3748ade231ca211a01acbec31cc6a3b576f6c56c906d73329d7dbb79f60fc2c
CLANDRO_PKG_DEPENDS="libcurl"

clandro_step_post_get_source() {
	# dirb222.tar.gz has directory permission problem
	chmod +x -R "$CLANDRO_PKG_SRCDIR"
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/share/dirb
	cp -rf  "$CLANDRO_PKG_SRCDIR"/wordlists "$CLANDRO_PREFIX"/share/dirb/wordlists
	find "$CLANDRO_PREFIX"/share/dirb/wordlists -type f | xargs chmod 600
	mv -f "$CLANDRO_PREFIX"/bin/gendict "$CLANDRO_PREFIX"/bin/dirb-gendict
}
