CLANDRO_SUBPKG_INCLUDE="lib/python*"
CLANDRO_SUBPKG_DESCRIPTION="Python bindings for OpenCV"
CLANDRO_SUBPKG_DEPENDS="python, python-numpy"
CLANDRO_SUBPKG_RECOMMENDS="python-opencv-python"

clandro_step_create_subpkg_debscripts() {
	_NUMPY_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/python-numpy/build.sh; echo $CLANDRO_PKG_VERSION)

	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	INSTALLED_NUMPY_VERSION=\$(dpkg --list python-numpy | grep python-numpy | awk '{print \$3; exit;}')
	if [ "\${INSTALLED_NUMPY_VERSION%%-*}" != "$_NUMPY_VERSION" ]; then
		echo "WARNING: opencv-python is compiled with numpy $_NUMPY_VERSION, but numpy \${INSTALLED_NUMPY_VERSION%%-*} is installed. Please report it to https://github.com/termux/termux-packages if any bug happens."
	fi
	EOF
}
