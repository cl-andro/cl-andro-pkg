# This script setups host python and crossenv for cross-compilation of python
# packages. Requires python package to be built before this script is called.
#
# It is highly recommended checking out documentation of
# clandro_setup_build_python before using this script
clandro_setup_python_pip() {
	clandro_setup_build_python
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' python-pip 2>/dev/null)" != "installed" ]] ||
		[[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q python-pip 2>/dev/null)" ]]; then
			echo "Package 'python-pip' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install python-pip"
			echo
			echo "  pacman -S python-pip"
			echo
			echo "Note that package 'python-pip' is known to be problematic for building on device."
			exit 1
		fi

		# Setup a virtual environment and do not mess the system site-packages
		local _VENV_DIR="${CLANDRO_PKG_TMPDIR}/venv-dir"

		mkdir -p "$_VENV_DIR"
		python${CLANDRO_PYTHON_VERSION} -m venv --system-site-packages "$_VENV_DIR"
		. "$_VENV_DIR/bin/activate"

		pip install 'setuptools==80.9.0' 'wheel==0.46.1'
	else
		local _CROSSENV_VERSION=1.6.1
		local _CROSSENV_TAR=crossenv-$_CROSSENV_VERSION.tar.gz
		local _CROSSENV_FOLDER

		if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
			_CROSSENV_FOLDER=${CLANDRO_SCRIPTDIR}/build-tools/crossenv-${_CROSSENV_VERSION}
		else
			_CROSSENV_FOLDER=${CLANDRO_COMMON_CACHEDIR}/crossenv-${_CROSSENV_VERSION}
		fi
		export CLANDRO_PYTHON_CROSSENV_SRCDIR=$_CROSSENV_FOLDER

		if [ ! -d "$_CROSSENV_FOLDER" ]; then
			clandro_download \
				https://github.com/benfogle/crossenv/archive/refs/tags/v$_CROSSENV_VERSION.tar.gz \
				$CLANDRO_PKG_TMPDIR/$_CROSSENV_TAR \
				f85bfbfbfea3567427daa56693c28c75e69fb6ae78c508565f7ae54a26fe407d

			rm -Rf "$CLANDRO_PKG_TMPDIR/crossenv-$_CROSSENV_VERSION"
			tar xf $CLANDRO_PKG_TMPDIR/$_CROSSENV_TAR -C $CLANDRO_PKG_TMPDIR
			mv "$CLANDRO_PKG_TMPDIR/crossenv-$_CROSSENV_VERSION" \
				$_CROSSENV_FOLDER
			shopt -s nullglob
			local f
			for f in "$CLANDRO_SCRIPTDIR"/scripts/build/setup/python-crossenv-*.patch; do
				echo "[${FUNCNAME[0]}]: Applying $(basename "$f")"
				cat "$f" | sed -e "s|@@CLANDRO_PKG_API_LEVEL@@|${CLANDRO_PKG_API_LEVEL}|g" | patch --silent -p1 -d "$_CROSSENV_FOLDER"
			done
			shopt -u nullglob
		fi

		if [ ! -d "$CLANDRO_PYTHON_CROSSENV_PREFIX" ]; then
			cd "$CLANDRO_PYTHON_CROSSENV_SRCDIR"
			"$CLANDRO_BUILD_PYTHON_DIR/host-build-prefix/bin/python${CLANDRO_PYTHON_VERSION}" -m crossenv \
                		"$CLANDRO_PREFIX/bin/python${CLANDRO_PYTHON_VERSION}" \
				"${CLANDRO_PYTHON_CROSSENV_PREFIX}"
		fi
		. "${CLANDRO_PYTHON_CROSSENV_PREFIX}/bin/activate"

		# Since 3.12, distutils is removed from python, but setuptools>=60 provides it
		# Since wheel 0.46, setuptools>=70 is required to provide bdist_wheel
		build-pip install 'setuptools==80.9.0' 'wheel==0.46.1'
		cross-pip install 'setuptools==80.9.0' 'wheel==0.46.1'

		export PATH="${CLANDRO_PYTHON_CROSSENV_PREFIX}/build/bin:${PATH}"
		local _CROSS_PATH="${CLANDRO_PYTHON_CROSSENV_PREFIX}/cross/bin"
		export PATH="${_CROSS_PATH}:$(echo -n $(tr ':' '\n' <<< "${PATH}" | grep -v "^${_CROSS_PATH}$") | tr ' ' ':')"

		local sysconfig_module=$(${CLANDRO_PYTHON_CROSSENV_PREFIX}/build/bin/python -c "import sysconfig; print(sysconfig.__file__)")
		if [[ ! -f "${CLANDRO_PYTHON_CROSSENV_BUILDHOME}/${sysconfig_module##*/}" ]]; then
			cp -r "${sysconfig_module}" "${CLANDRO_PYTHON_CROSSENV_BUILDHOME}"
			sed -i "s|os.path.normpath(sys.*prefix)|\"${CLANDRO_PREFIX}\"|g" "${CLANDRO_PYTHON_CROSSENV_BUILDHOME}/${sysconfig_module##*/}"
		fi
	fi
}
