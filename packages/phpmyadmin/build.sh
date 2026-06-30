CLANDRO_PKG_HOMEPAGE=https://www.phpmyadmin.net
CLANDRO_PKG_DESCRIPTION="A PHP tool for administering MySQL and MariaDB databases"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@williamdes"
CLANDRO_PKG_VERSION=5.2.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://files.phpmyadmin.net/phpMyAdmin/$CLANDRO_PKG_VERSION/phpMyAdmin-$CLANDRO_PKG_VERSION-all-languages.tar.xz
CLANDRO_PKG_SHA256=57881348297c4412f86c410547cf76b4d8a236574dd2c6b7d6a2beebe7fc44e3
CLANDRO_PKG_DEPENDS="apache2, php, php-apache"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_CONFFILES="etc/phpmyadmin/config.inc.php"

clandro_step_make_install() {
	rm -rf $CLANDRO_PREFIX/share/phpmyadmin
	mkdir -p $CLANDRO_PREFIX/share/phpmyadmin
	cp -a $CLANDRO_PKG_SRCDIR/* $CLANDRO_PREFIX/share/phpmyadmin/
	mkdir -p $CLANDRO_PREFIX/etc/phpmyadmin
	cp $CLANDRO_PKG_SRCDIR/config.sample.inc.php $CLANDRO_PREFIX/etc/phpmyadmin/config.inc.php
	ln -s $CLANDRO_PREFIX/etc/phpmyadmin/config.inc.php $CLANDRO_PREFIX/share/phpmyadmin
	mkdir -p $CLANDRO_PREFIX/etc/apache2/conf.d
	sed -e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" $CLANDRO_PKG_BUILDER_DIR/phpmyadmin.conf \
		> $CLANDRO_PREFIX/etc/apache2/conf.d/phpmyadmin.conf
	# Variable data folder
	mkdir -p $CLANDRO_PREFIX/var/lib/phpmyadmin/sessions
	touch "$CLANDRO_PREFIX/var/lib/phpmyadmin/sessions/.placeholder"
	mkdir -p $CLANDRO_PREFIX/var/lib/phpmyadmin/tmp
	touch "$CLANDRO_PREFIX/var/lib/phpmyadmin/tmp/.placeholder"
	mkdir -p $CLANDRO_PREFIX/var/lib/phpmyadmin/uploads
	touch "$CLANDRO_PREFIX/var/lib/phpmyadmin/uploads/.placeholder"
	# Custom settings
	sed -i "s,\$cfg\['UploadDir'\] = '';,\$cfg\['UploadDir'\] = '$CLANDRO_PREFIX/var/lib/phpmyadmin/uploads';," $CLANDRO_PREFIX/etc/phpmyadmin/config.inc.php
	sed -i "s,\$cfg\['SaveDir'\] = '';,\$cfg\['SaveDir'\] = '$CLANDRO_PREFIX/var/lib/phpmyadmin/uploads';," $CLANDRO_PREFIX/etc/phpmyadmin/config.inc.php
	echo "\$cfg['TempDir'] = '$CLANDRO_PREFIX/var/lib/phpmyadmin/tmp';" >> $CLANDRO_PREFIX/etc/phpmyadmin/config.inc.php
	# Check for syntax errors
	php -l $CLANDRO_PREFIX/etc/phpmyadmin/config.inc.php
}
