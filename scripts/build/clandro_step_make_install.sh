# shellcheck disable=SC2086
clandro_step_make_install() {
	[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return

	if test -f build.ninja; then
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES install
	elif test -f setup.py || test -f pyproject.toml || test -f setup.cfg; then
		pip install --no-deps . --prefix $CLANDRO_PREFIX
	elif ls ./*.cabal &>/dev/null || ls ./cabal.project &>/dev/null; then
		# Workaround until `cabal install` is fixed.
		while read -r bin; do
			[[ -f "$bin" ]] || clandro_error_exit "'$bin', no such file. Has build completed?"
			echo "INFO: Installing '$bin' component..."
			cp "$bin" "$CLANDRO_PREFIX/bin"
		done< <(cat ./dist-newstyle/cache/plan.json | jq -r '."install-plan"[]|select(."component-name"? and (."component-name"|test("exe:.*")) and (.style == "local") )|."bin-file"')
	elif ls ./*akefile &>/dev/null || [ -n "$CLANDRO_PKG_EXTRA_MAKE_ARGS" ]; then
		: "${CLANDRO_PKG_MAKE_INSTALL_TARGET:="install"}"
		# Some packages have problem with parallell install, and it does not buy much, so use -j 1.
		if [ -z "$CLANDRO_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j 1 ${CLANDRO_PKG_MAKE_INSTALL_TARGET}
		else
			make -j 1 ${CLANDRO_PKG_EXTRA_MAKE_ARGS} ${CLANDRO_PKG_MAKE_INSTALL_TARGET}
		fi
	elif test -f Cargo.toml; then
		if [[ -z "$(command -v cargo)" ]]; then
			clandro_error_exit "cargo command is not found! Please add clandro_setup_rust in package's build.sh!"
		fi
		cargo install \
			--jobs $CLANDRO_PKG_MAKE_PROCESSES \
			--path . \
			--force \
			--locked \
			--no-track \
			--target $CARGO_TARGET_NAME \
			--root $CLANDRO_PREFIX \
			$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	fi
}

clandro_step_make_install_multilib() {
	clandro_step_make_install
}
