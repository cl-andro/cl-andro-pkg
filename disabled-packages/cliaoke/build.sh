CLANDRO_PKG_HOMEPAGE=https://github.com/jessfraz/cliaoke
CLANDRO_PKG_DESCRIPTION="Command line karaoke"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2.4
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/jessfraz/cliaoke/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=df601b7d118acb8c0b7251c42b5b2623335bfc51f5dc94135fa6722850955f50
CLANDRO_PKG_RECOMMENDS="fluidsynth"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang
	go mod init || :
	go mod tidy
	go mod vendor
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin cliaoke
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" > postinst
	echo "if [ ! -e $CLANDRO_PREFIX/share/soundfonts/FluidR3_GM.sf2 ]; then" >> postinst
	echo "  echo" >> postinst
	echo "  echo You may need to get \\\`FluidR3_GM.sf2\\' from somewhere and put it into:" >> postinst
	echo "  echo" >> postinst
	echo "  echo '    '$CLANDRO_PREFIX/share/soundfonts/" >> postinst
	echo "  echo" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
