CLANDRO_PKG_HOMEPAGE="https://github.com/jackett/jackett"
CLANDRO_PKG_DESCRIPTION="API Support for your favorite torrent trackers"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.24.1822"
CLANDRO_PKG_SRCURL="https://github.com/Jackett/Jackett/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=876fc1547a0bca8490c6a190acb8f67601918f4cedbb5cd5ce48f1f04fe3359d
CLANDRO_PKG_BUILD_DEPENDS="aspnetcore-targeting-pack-9.0, dotnet-targeting-pack-9.0"
CLANDRO_PKG_DEPENDS="aspnetcore-runtime-9.0, dotnet-host, dotnet-runtime-9.0"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SERVICE_SCRIPT=("jackett" "exec ${CLANDRO_PREFIX}/bin/jackett --DataFolder ${CLANDRO_ANDROID_HOME}/.config/jackett 2>&1")
CLANDRO_PKG_EXCLUDED_ARCHES="arm"
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/jackett/README.md
lib/jackett/LICENSE
lib/jackett/jackett.pdb
lib/jackett/Jackett.Common.pdb
lib/jackett/DateTimeRoutines.pdb
"

# This auto update function throttles the update frequency
# of the package to set `$update_interval`, this is useful
# for packages that make very frequent tags like `jackett`
# or `llama-cpp` to not spam the commit history, CI and repos.
clandro_pkg_auto_update() {
	local origin_url last_autoupdate
	# Throttle auto updates to once a week.
	local update_interval="$((7 * 86400))"

	# Get the git history
	if origin_url="$(git config --get remote.origin.url)"; then
		git fetch --quiet "${origin_url}" || {
			echo "WARN: Unable to fetch '${origin_url}'"
			echo "WARN: Skipping auto update for '$CLANDRO_PKG_NAME'"
			return
		}
	fi

	# When was `jackett` last autoupdated? (Unix epoch timestamp)
	last_autoupdate="$(
		git log \
		--author="Termux Github Actions <contact@clandro>" \
		-n1 \
		--pretty=format:%at \
		-- "$CLANDRO_PKG_BUILDER_DIR/build.sh"
	)"


	if (( last_autoupdate > EPOCHSECONDS - update_interval )); then
		local t days hrs mins secs
		(( t = EPOCHSECONDS - last_autoupdate, days = t/86400, t %= 86400, secs= t%60, t /= 60, mins = t%60, hrs = t/60 ))

		printf 'INFO: Last updated %dd%dh%02dm%02ds ago.\n' "$days" "$hrs" "$mins" "$secs"
		printf 'INFO: Which is less than the desired %sd minimum update interval.\n' "$(( update_interval / 86400 ))"
		return
	fi

	local latest_tag
	latest_tag="$(
		clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}" "${CLANDRO_PKG_UPDATE_TAG_TYPE}"
	)"

	if [[ -z "${latest_tag}" ]]; then
		clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	fi
	clandro_pkg_upgrade_version "${latest_tag}"
}

clandro_step_pre_configure() {
	CLANDRO_DOTNET_VERSION=9.0
	clandro_setup_dotnet
}

clandro_step_make() {
	dotnet publish src/Jackett.Server \
	--framework "net${CLANDRO_DOTNET_VERSION}" \
	--no-self-contained \
	--runtime "$DOTNET_TARGET_NAME" \
	--configuration Release \
	--output build/ \
	/p:AssemblyVersion="${CLANDRO_PKG_VERSION}" \
	/p:FileVersion="${CLANDRO_PKG_VERSION}" \
	/p:InformationalVersion="${CLANDRO_PKG_VERSION}" \
	/p:Version="${CLANDRO_PKG_VERSION}"
	dotnet build-server shutdown
}

clandro_step_make_install() {
	rm -fr "${CLANDRO_PREFIX}/lib/jackett"
	mkdir -p "${CLANDRO_PREFIX}/lib"
	cp -r build "${CLANDRO_PREFIX}/lib/jackett"
	cat > $CLANDRO_PREFIX/bin/jackett <<-HERE
	#!$CLANDRO_PREFIX/bin/sh
	exec dotnet $CLANDRO_PREFIX/lib/jackett/jackett.dll --NoUpdates "\$@"
	HERE
	chmod u+x $CLANDRO_PREFIX/bin/jackett
}
