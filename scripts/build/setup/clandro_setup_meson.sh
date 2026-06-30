clandro_setup_meson() {
	clandro_setup_ninja
	local MESON_VERSION=1.10.0
	local MESON_FOLDER

	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		MESON_FOLDER=${CLANDRO_SCRIPTDIR}/build-tools/meson-${MESON_VERSION}
	else
		MESON_FOLDER=${CLANDRO_COMMON_CACHEDIR}/meson-${MESON_VERSION}
	fi

	if [ ! -d "$MESON_FOLDER" ]; then
		local MESON_TAR_NAME=meson-$MESON_VERSION.tar.gz
		local MESON_TAR_FILE=$CLANDRO_PKG_TMPDIR/$MESON_TAR_NAME
		local MESON_TMP_FOLDER=$CLANDRO_PKG_TMPDIR/meson-$MESON_VERSION
		clandro_download \
			"https://github.com/mesonbuild/meson/releases/download/$MESON_VERSION/meson-$MESON_VERSION.tar.gz" \
			"$MESON_TAR_FILE" \
			8071860c1f46a75ea34801490fd1c445c9d75147a65508cd3a10366a7006cc1c
		tar xf "$MESON_TAR_FILE" -C "$CLANDRO_PKG_TMPDIR"
		shopt -s nullglob
		local f
		for f in "$CLANDRO_SCRIPTDIR"/scripts/build/setup/meson-*.patch; do
			echo "[${FUNCNAME[0]}]: Applying $(basename "$f")"
			patch --silent -p1 -d "$MESON_TMP_FOLDER" < "$f"
		done
		shopt -u nullglob
		mv "$MESON_TMP_FOLDER" "$MESON_FOLDER"
	fi
	CLANDRO_MESON="${MESON_FOLDER}/meson.py"
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		CLANDRO_MESON="/usr/bin/python3 ${CLANDRO_MESON}"
	fi
	CLANDRO_MESON_CROSSFILE=$CLANDRO_PKG_TMPDIR/meson-crossfile-$CLANDRO_ARCH.txt
	local MESON_CPU MESON_CPU_FAMILY
	if [ "$CLANDRO_ARCH" = "arm" ]; then
		MESON_CPU_FAMILY="arm"
		MESON_CPU="armv7"
	elif [ "$CLANDRO_ARCH" = "i686" ]; then
		MESON_CPU_FAMILY="x86"
		MESON_CPU="i686"
	elif [ "$CLANDRO_ARCH" = "x86_64" ]; then
		MESON_CPU_FAMILY="x86_64"
		MESON_CPU="x86_64"
	elif [ "$CLANDRO_ARCH" = "aarch64" ]; then
		MESON_CPU_FAMILY="aarch64"
		MESON_CPU="aarch64"
	else
		clandro_error_exit "Unsupported arch: $CLANDRO_ARCH"
	fi

	echo "[binaries]" > $CLANDRO_MESON_CROSSFILE
	echo "ar = '$AR'" >> $CLANDRO_MESON_CROSSFILE
	echo "c = '$CC'" >> $CLANDRO_MESON_CROSSFILE
	echo "cmake = 'cmake'" >> $CLANDRO_MESON_CROSSFILE
	echo "cpp = '$CXX'" >> $CLANDRO_MESON_CROSSFILE
	echo "ld = '$LD'" >> $CLANDRO_MESON_CROSSFILE
	echo "pkg-config = '$PKG_CONFIG'" >> $CLANDRO_MESON_CROSSFILE
	echo "strip = '$STRIP'" >> $CLANDRO_MESON_CROSSFILE
	if [[ -n "$(command -v rustc)" && -n "${CARGO_TARGET_NAME-}" ]]; then
		echo "rust = ['rustc', '--target', '$CARGO_TARGET_NAME']" >> $CLANDRO_MESON_CROSSFILE
	fi

	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		echo '' >> $CLANDRO_MESON_CROSSFILE
		echo "[properties]" >> $CLANDRO_MESON_CROSSFILE
		echo "needs_exe_wrapper = true" >> $CLANDRO_MESON_CROSSFILE
  	fi

	echo '' >> $CLANDRO_MESON_CROSSFILE
	echo "[built-in options]" >> $CLANDRO_MESON_CROSSFILE

	echo -n "c_args = [" >> $CLANDRO_MESON_CROSSFILE
	local word first=true
	for word in $CFLAGS $CPPFLAGS; do
		if [ "$first" = "true" ]; then
			first=false
		else
			echo -n ", " >> $CLANDRO_MESON_CROSSFILE
		fi
		echo -n "'$word'" >> $CLANDRO_MESON_CROSSFILE
	done
	echo ']' >> $CLANDRO_MESON_CROSSFILE

	echo -n "cpp_args = [" >> $CLANDRO_MESON_CROSSFILE
	local word first=true
	for word in $CXXFLAGS $CPPFLAGS; do
		if [ "$first" = "true" ]; then
			first=false
		else
			echo -n ", " >> $CLANDRO_MESON_CROSSFILE
		fi
		echo -n "'$word'" >> $CLANDRO_MESON_CROSSFILE
	done
	echo ']' >> $CLANDRO_MESON_CROSSFILE

	local property
	for property in c_link_args cpp_link_args fortran_link_args; do
		echo -n "$property = [" >> $CLANDRO_MESON_CROSSFILE
		first=true
		for word in $LDFLAGS; do
			if [ "$first" = "true" ]; then
				first=false
			else
				echo -n ", " >> $CLANDRO_MESON_CROSSFILE
			fi
			echo -n "'$word'" >> $CLANDRO_MESON_CROSSFILE
		done
		echo ']' >> $CLANDRO_MESON_CROSSFILE
	done

	echo '' >> $CLANDRO_MESON_CROSSFILE
	echo "[host_machine]" >> $CLANDRO_MESON_CROSSFILE
	echo "cpu_family = '$MESON_CPU_FAMILY'" >> $CLANDRO_MESON_CROSSFILE
	echo "cpu = '$MESON_CPU'" >> $CLANDRO_MESON_CROSSFILE
	echo "endian = 'little'" >> $CLANDRO_MESON_CROSSFILE
 	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		echo "system = 'android'" >> $CLANDRO_MESON_CROSSFILE
  	elif [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		echo "system = 'linux'" >> $CLANDRO_MESON_CROSSFILE
     	fi
}
