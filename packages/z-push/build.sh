CLANDRO_PKG_HOMEPAGE=https://z-push.org/
CLANDRO_PKG_DESCRIPTION="An open-source application to synchronize ActiveSync compatible devices and Outlook"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.6"
CLANDRO_PKG_SRCURL=https://github.com/Z-Hub/Z-Push/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=71c6ba3bc1dfcf3819dc5741454eea58db13967cc813497f60fef542e1d87091
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="apache2, php"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	cp -rT src $CLANDRO_PREFIX/share/z-push
	local f
	for f in z-push-{admin,top}; do
		ln -sfr $CLANDRO_PREFIX/share/z-push/${f}.php $CLANDRO_PREFIX/bin/${f}
		install -Dm600 -t $CLANDRO_PREFIX/share/man/man8 man/${f}.8
	done
	install -Dm600 -t $CLANDRO_PREFIX/etc/apache2/conf.d config/apache2/*.conf
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/lib/z-push
	mkdir -p $CLANDRO_PREFIX/var/log/z-push
	EOF
}
