CLANDRO_PKG_HOMEPAGE=http://developer.android.com/tools/help/index.html
CLANDRO_PKG_DESCRIPTION="Command which takes in Java class files and converts them to format executable by Dalvik VM"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:1.16
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/termux/distfiles/releases/download/2021.01.04/dx-android-${CLANDRO_PKG_VERSION:2}.jar
CLANDRO_PKG_SHA256=b9b7917267876b74c8ff6707e7a576c93b6dfe8cacc4f1cc791d606bcbbb7bd5
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	clandro_download "$CLANDRO_PKG_SRCURL" \
		"$CLANDRO_PKG_CACHEDIR/dx-${CLANDRO_PKG_VERSION:2}.jar" \
		"$CLANDRO_PKG_SHA256"

	install -Dm600 "$CLANDRO_PKG_CACHEDIR/dx-${CLANDRO_PKG_VERSION:2}.jar" \
		"$CLANDRO_PREFIX"/share/dex/dx.jar

	cat <<- EOF > "$CLANDRO_PREFIX"/bin/dx
	#!${CLANDRO_PREFIX}/bin/sh
	exec dalvikvm \
		-Xcompiler-option --compiler-filter=speed \
		-Xmx256m \
		-cp ${CLANDRO_PREFIX}/share/dex/dx.jar \
		dx.dx.command.Main "\$@"
	EOF
	chmod 700 "$CLANDRO_PREFIX"/bin/dx

	cat <<- EOF > "$CLANDRO_PREFIX"/bin/dx-merge
	#!${CLANDRO_PREFIX}/bin/sh
	exec dalvikvm \
		-Xcompiler-option --compiler-filter=speed \
		-Xmx256m \
		-cp ${CLANDRO_PREFIX}/share/dex/dx.jar \
		dx.dx.merge.DexMerger "\$@"
	EOF
	chmod 700 "$CLANDRO_PREFIX"/bin/dx-merge
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${CLANDRO_PREFIX}/bin/bash
	rm -f $CLANDRO_PREFIX/share/dex/oat/*/dx.{art,oat,odex,vdex} >/dev/null 2>&1
	chmod -w $CLANDRO_PREFIX/share/dex/dx.jar
	exit 0
	EOF
}
