CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/clandro-exec-package
CLANDRO_PKG_DESCRIPTION="Utils and libraries for Termux exec including a LD_PRELOAD shared library for proper functioning of the Termux execution environment"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:2.4.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/clandro-exec-package/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=fa948816c8f9fc321287056580607c560cfb026fe181c52f5c9595c073a4657b
CLANDRO_PKG_BUILD_DEPENDS="clandro-core-static"
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="CLANDRO_EXEC_PKG__VERSION=${CLANDRO_PKG_VERSION} CLANDRO_EXEC_PKG__ARCH=${CLANDRO_ARCH} \
CLANDRO__NAME=${CLANDRO__NAME} CLANDRO__LNAME=${CLANDRO__LNAME} \
CLANDRO__REPOS_HOST_ORG_NAME=${CLANDRO__REPOS_HOST_ORG_NAME} \
CLANDRO_APP__NAME=${CLANDRO_APP__NAME} \
CLANDRO_APP__PACKAGE_NAME=${CLANDRO_APP__PACKAGE_NAME} CLANDRO_APP__DATA_DIR=${CLANDRO_APP__DATA_DIR} \
CLANDRO__ROOTFS=${CLANDRO__ROOTFS} CLANDRO__PREFIX=${CLANDRO__PREFIX} \
CLANDRO_ENV__S_ROOT=${CLANDRO_ENV__S_ROOT} \
CLANDRO_ENV__SS_CLANDRO=${CLANDRO_ENV__SS_CLANDRO} CLANDRO_ENV__S_CLANDRO=${CLANDRO_ENV__S_CLANDRO} \
CLANDRO_ENV__SS_CLANDRO_APP=${CLANDRO_ENV__SS_CLANDRO_APP} CLANDRO_ENV__S_CLANDRO_APP=${CLANDRO_ENV__S_CLANDRO_APP} \
CLANDRO_ENV__SS_CLANDRO_ROOTFS=${CLANDRO_ENV__SS_CLANDRO_ROOTFS} CLANDRO_ENV__S_CLANDRO_ROOTFS=${CLANDRO_ENV__S_CLANDRO_ROOTFS} \
CLANDRO_ENV__SS_CLANDRO_EXEC=${CLANDRO_ENV__SS_CLANDRO_EXEC} CLANDRO_ENV__S_CLANDRO_EXEC=${CLANDRO_ENV__S_CLANDRO_EXEC} \
CLANDRO_ENV__SS_CLANDRO_EXEC__TESTS=${CLANDRO_ENV__SS_CLANDRO_EXEC__TESTS} CLANDRO_ENV__S_CLANDRO_EXEC__TESTS=${CLANDRO_ENV__S_CLANDRO_EXEC__TESTS}"

clandro_step_install_license() {
	mkdir -p "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/licenses"
	cp -af "$CLANDRO_PKG_SRCDIR/LICENSE" "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/copyright"
	cp -af "$CLANDRO_PKG_SRCDIR/licenses/"* "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/licenses/"
}

clandro_step_strip_elf_symbols() {
	clandro_step_strip_elf_symbols__from_paths . \
	\( \
		\( -path "./bin/*" -o -path "./lib/*" -o -path "./libexec/*" \) -a \
		\( ! -path "./libexec/installed-tests/clandro-exec/*" \) \
	\)
}

clandro_step_post_massage() {
	# Hack to compile `libclandro-exec_nos_c_tre_runtime-binary-tests` for api level 28 if default (currently 24) is less than it.
	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 28 ]]; then
		export CLANDRO_PKG_API_LEVEL=28
		clandro_step_setup_toolchain

		local QUIET_BUILD=
		if [ "$CLANDRO_QUIET_BUILD" = true ]; then
			QUIET_BUILD="-s"
		fi

		printf "\n%s\n" "Building libclandro-exec_nos_c_tre_runtime-binary-tests for CLANDRO_PKG_API_LEVEL '$CLANDRO_PKG_API_LEVEL'"
		cd "$CLANDRO_PKG_BUILDDIR"
		make $QUIET_BUILD $CLANDRO_PKG_EXTRA_MAKE_ARGS CLANDRO_EXEC_PKG__TESTS__API_LEVEL=28 build-libclandro-exec_nos_c_tre_runtime-binary-tests

		local CLANDRO_EXEC__TESTS__TESTS_PATH="$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/libexec/installed-tests/clandro-exec"
		local LIBCLANDRO_EXEC__NOS__C__TESTS_PATH="$CLANDRO_EXEC__TESTS__TESTS_PATH/lib/clandro-exec_nos_c/tre"

		install -m700 build/output/usr/libexec/installed-tests/clandro-exec/lib/clandro-exec_nos_c/tre/bin/libclandro-exec_nos_c_tre_runtime-binary-tests-fsanitize28 \
			"$LIBCLANDRO_EXEC__NOS__C__TESTS_PATH/bin/libclandro-exec_nos_c_tre_runtime-binary-tests-fsanitize28"
		$CLANDRO_ELF_CLEANER --api-level 28 "$LIBCLANDRO_EXEC__NOS__C__TESTS_PATH/bin/libclandro-exec_nos_c_tre_runtime-binary-tests-fsanitize28"

		install -m700 build/output/usr/libexec/installed-tests/clandro-exec/lib/clandro-exec_nos_c/tre/bin/libclandro-exec_nos_c_tre_runtime-binary-tests-nofsanitize28 \
			"$LIBCLANDRO_EXEC__NOS__C__TESTS_PATH/bin/libclandro-exec_nos_c_tre_runtime-binary-tests-nofsanitize28"
		$CLANDRO_ELF_CLEANER --api-level 28 "$LIBCLANDRO_EXEC__NOS__C__TESTS_PATH/bin/libclandro-exec_nos_c_tre_runtime-binary-tests-nofsanitize28"
		printf "%s\n\n" "Install libclandro-exec_nos_c_tre_runtime-binary-tests for CLANDRO_PKG_API_LEVEL '$CLANDRO_PKG_API_LEVEL' successful"
	fi
}

clandro_step_create_debscripts() {
	clandro_step_create_debscripts__copy_from_dir "$CLANDRO_PKG_SRCDIR/build/output/packaging/debian" .
}
