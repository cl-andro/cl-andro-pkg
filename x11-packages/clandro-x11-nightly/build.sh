CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/clandro-x11
CLANDRO_PKG_DESCRIPTION="Termux X11 add-on."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Twaik Yont @twaik"
CLANDRO_PKG_VERSION="1.03.01"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/clandro-x11/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8626aab0900d208f2ca484b5053ae5b952eff55537a4424042a35d6e935c8c04
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="xkeyboard-config"
# We provide a clandro-x11-xfce4 service script, so let's suggest xfce4
CLANDRO_PKG_SUGGESTS="xfce4"
CLANDRO_PKG_BREAKS="clandro-x11"
CLANDRO_PKG_REPLACES="clandro-x11"
CLANDRO_PKG_PROVIDES="clandro-x11"

clandro_step_make() {
	:
}

clandro_step_make_install() {
	# Downloading full JDK to compile 7kb apk seems excessive, let's download a prebuilt.
	local LOADER_URL="https://github.com/termux/termux-x11/releases/download/nightly/termux-x11-nightly-1.03.01-0-any.pkg.tar.xz"
	install -t "$CLANDRO_PREFIX/bin" -m 755 clandro-x11 clandro-x11-preference
	mkdir -p "$CLANDRO_PREFIX/libexec/clandro-x11"
	wget -qO- "$LOADER_URL" | tar -OJxf - --wildcards "*loader.apk" > "$CLANDRO_PREFIX/libexec/clandro-x11/loader.apk"
}

clandro_step_post_make_install() {
	# Setup clandro-services scripts
	mkdir -p "$CLANDRO_PREFIX/var/service/tx11/log"
	ln -sf "$CLANDRO_PREFIX/share/clandro-services/svlogger" "$CLANDRO_PREFIX/var/service/tx11/log/run"
	sed -e "s%@CLANDRO_PREFIX@%$CLANDRO_PREFIX%g" \
		-e "s%@CLANDRO_HOME@%$CLANDRO_ANDROID_HOME%g" \
		"$CLANDRO_PKG_BUILDER_DIR/sv/tx11.run.in" > "$CLANDRO_PREFIX/var/service/tx11/run"
	chmod 700 "$CLANDRO_PREFIX/var/service/tx11/run"
	touch "$CLANDRO_PREFIX/var/service/tx11/down"

	mkdir -p "$CLANDRO_PREFIX/var/service/tx11-xfce4/log"
	ln -sf "$CLANDRO_PREFIX/share/clandro-services/svlogger" "$CLANDRO_PREFIX/var/service/tx11-xfce4/log/run"
	sed "s%@CLANDRO_PREFIX@%$CLANDRO_PREFIX%g" \
		"$CLANDRO_PKG_BUILDER_DIR/sv/tx11-xfce4.run.in" > "$CLANDRO_PREFIX/var/service/tx11-xfce4/run"
	chmod 700 "$CLANDRO_PREFIX/var/service/tx11-xfce4/run"
	touch "$CLANDRO_PREFIX/var/service/tx11-xfce4/down"
}

clandro_step_create_debscripts() {
	cat <<- EOF > postinst
		#!${CLANDRO_PREFIX}/bin/sh
		chmod -w $CLANDRO_PREFIX/libexec/clandro-x11/loader.apk
	EOF

	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
}
