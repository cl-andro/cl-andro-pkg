CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/breeze-gtk"
CLANDRO_PKG_DESCRIPTION="Breeze widget theme for GTK 2 and 3"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/breeze-gtk-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=5ee332a31c5e86d6dd0a3bb7cd9a43e176adc2582f2e3b7d5e0c2fa9b90e9774
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="breeze, extra-cmake-modules, pycairo, sassc"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	local hostbuild_python_version
	hostbuild_python_version="$(python -c "import platform; print(platform.python_version())")"
	hostbuild_python_version="${hostbuild_python_version%.*}"

	clandro_download_ubuntu_packages \
		libpython3-dev \
		libpython"$hostbuild_python_version"-dev \
		python3-dev \
		python"$hostbuild_python_version"-dev

	local HOSTBUILD_PREFIX="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr"
	export PKG_CONFIG_PATH="$HOSTBUILD_PREFIX/lib/x86_64-linux-gnu/pkgconfig"
	export CFLAGS="-I$HOSTBUILD_PREFIX/include"
	CFLAGS+=" -I$HOSTBUILD_PREFIX/include/python$hostbuild_python_version"

	local hostbuild_venv_dir="${CLANDRO_PKG_HOSTBUILD_DIR}/venv-dir"
	mkdir -p "$hostbuild_venv_dir"
	python -m venv --system-site-packages "$hostbuild_venv_dir"
	. "$hostbuild_venv_dir/bin/activate"
	pip install pycairo
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		local SAVED_PATH="$PATH"
		local hostbuild_venv_dir="${CLANDRO_PKG_HOSTBUILD_DIR}/venv-dir"
		. "$hostbuild_venv_dir/bin/activate"
		export PATH="$PATH:$SAVED_PATH"
	fi
}
