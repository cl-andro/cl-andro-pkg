CLANDRO_PKG_HOMEPAGE=https://sabnzbd.org/
CLANDRO_PKG_DESCRIPTION="Fully automated Usenet Binary Downloader"
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt, GPL2.txt, GPL3.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.0.1"
CLANDRO_PKG_SRCURL="https://github.com/sabnzbd/sabnzbd/releases/download/${CLANDRO_PKG_VERSION}/SABnzbd-${CLANDRO_PKG_VERSION}-src.tar.gz"
CLANDRO_PKG_SHA256=5db4871356b57e7e731304e03ceb8ac32971648110688d52e5ae1446e92c9d7b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="python, python-cryptography, python-sabyenc3, clandro-tools, par2, unrar, p7zip, unzip"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SERVICE_SCRIPT=("sabnzbd" 'exec sabnzbd -d 2>&1')

clandro_step_post_get_source() {
	export CLANDRO_PKG_PYTHON_TARGET_DEPS=""
	while IFS="" read -r dep
	do
		# only install main requirements
		if [ -z "$dep" ]; then
			break
		fi
		dep="${dep/[# ]*}"
		# https://github.com/termux/termux-packages/issues/20229
		if [ -z "$dep" ] || [ -z "${dep/sabctools*}" ]; then
			continue
		fi
		CLANDRO_PKG_PYTHON_TARGET_DEPS+="'$dep', "
	done < "$CLANDRO_PKG_SRCDIR/requirements.txt"
}

clandro_step_make_install() {
	local sabnzbd="${CLANDRO_PREFIX}/share/sabnzbd"
	mkdir -p "${sabnzbd}"
	cp -r email icons interfaces locale po sabnzbd scripts tools "${sabnzbd}"
	find "${sabnzbd}" -type d -exec chmod 700 {} \;
	find "${sabnzbd}" -type f -exec chmod 600 {} \;
	install -Dm700 SABnzbd.py "${CLANDRO_PREFIX}/bin/sabnzbd"
	install -Dm600 linux/sabnzbd.bash-completion "${CLANDRO_PREFIX}/share/bash-completion/completions/sabnzbd"
}
