CLANDRO_PKG_HOMEPAGE=https://github.com/beanshell/beanshell
CLANDRO_PKG_DESCRIPTION="Small, free, embeddable, source level Java interpreter with object based scripting language features written in Java"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/beanshell/beanshell/releases/download/$CLANDRO_PKG_VERSION/bsh-$CLANDRO_PKG_VERSION.jar
CLANDRO_PKG_SHA256=71192cbbe49e7a269cfcba05dc5cb959c33b9b26dafcd6266ca3288b461f86a3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dash, clandro-tools"
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_download \
		"$CLANDRO_PKG_SRCURL" \
		"$CLANDRO_PKG_CACHEDIR/bsh-$CLANDRO_PKG_VERSION.jar" \
		"$CLANDRO_PKG_SHA256"
}

clandro_step_make() {
	$CLANDRO_D8 --output beanshell.jar \
		"$CLANDRO_PKG_CACHEDIR/bsh-$CLANDRO_PKG_VERSION.jar"
}

clandro_step_make_install() {
	install -Dm600 beanshell.jar "$CLANDRO_PREFIX/share/dex/beanshell.jar"

	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "dalvikvm -Xcompiler-option --compiler-filter=speed -cp $CLANDRO_PREFIX/share/dex/beanshell.jar bsh.Interpreter \"\$@\""
	} > "$CLANDRO_PREFIX"/bin/beanshell

	chmod 700 "$CLANDRO_PREFIX"/bin/beanshell
	ln -sfr "$CLANDRO_PREFIX"/bin/beanshell "$CLANDRO_PREFIX"/bin/bsh
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${CLANDRO_PREFIX}/bin/bash
	chmod -w $CLANDRO_PREFIX/share/dex/beanshell.jar
	rm -f $CLANDRO_PREFIX/share/dex/oat/*/beanshell.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}
