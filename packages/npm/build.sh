CLANDRO_PKG_HOMEPAGE=https://docs.npmjs.com/cli/
CLANDRO_PKG_DESCRIPTION="The package manager for JavaScript"
CLANDRO_PKG_LICENSE="Artistic-License-2.0"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="11.14.1"
CLANDRO_PKG_SRCURL=git+https://github.com/npm/cli.git
CLANDRO_PKG_SHA256=a7bba8c40e179d3be92176026f6c29caf6a8c7b0fcae4eb71951a9e103ac6f9e
CLANDRO_PKG_DEPENDS="nodejs | nodejs-lts"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="nodejs, nodejs-lts"
# npm was earlier packaged with nodejs and nodejs-lts packages.
CLANDRO_PKG_CONFLICTS="nodejs (<= 25.3.0), nodejs-lts (<= 24.13.0)"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_pkg_auto_update() {
	local api_url="https://api.github.com/repos/npm/cli/git/refs/tags"
	local latest_refs_tags=$(curl -s "${api_url}" | jq .[].ref --raw-output | grep "^refs/tags/v${CLANDRO_PKG_VERSION%%.*}" | sed -e 's|refs/tags/v||g')
	if [[ -z "${latest_refs_tags}" ]]; then
		echo "WARN: Unable to get latest refs tags from upstream. Try again later." >&2
		return
	fi
	local latest_version=$(echo "${latest_refs_tags}" | sort -V | tail -n1)

	clandro_pkg_upgrade_version "${latest_version}"
}

clandro_step_configure() {
	:
}

clandro_step_make_install() {
	clandro_setup_nodejs

	node scripts/resetdeps.js
	node . run build -w docs

	# Install npm into $CLANDRO_PREFIX/lib/node_modules/npm
	rm -rf "$CLANDRO_PREFIX/lib/node_modules/npm"
	mkdir -p "$CLANDRO_PREFIX/lib/node_modules/npm"
	mapfile -t npm_files < <(node . pack --ignore-scripts --dry-run --json | \
		jq --raw-output '.[].files.[].path')
	cp --parents -a "${npm_files[@]}" "$CLANDRO_PREFIX/lib/node_modules/npm"

	# Install npm and npx binaries
	ln -srf "$CLANDRO_PREFIX/lib/node_modules/npm/bin/npm-cli.js" "$CLANDRO_PREFIX/bin/npm"
	ln -srf "$CLANDRO_PREFIX/lib/node_modules/npm/bin/npx-cli.js" "$CLANDRO_PREFIX/bin/npx"
	# Remove broken npm and npx binaries
	rm "$CLANDRO_PREFIX/lib/node_modules/npm/bin/"{npm,npx}{,.ps1,.cmd}

	# Install bash completion script
	mkdir -p "$CLANDRO_PREFIX/etc/bash_completion.d"
	node . completion >> "$CLANDRO_PREFIX/etc/bash_completion.d/npm"

	#	Install the manpages. Stolen from Arch Linux's PKGBUILD
	cd $CLANDRO_PREFIX/lib/node_modules/npm/man
	# Workaround for https://github.com/npm/cli/issues/780
	local name page sec title
	for page in man5/folders.5 man5/install.5 man7/*.7; do
		sec=${page##*.}
		name=$(basename "$page" ."$sec")
		title=${name@U}

		sed -Ei "s/^\.TH \"$title\"/.TH \"NPM-$title\"/" "$page"
		sed -Ei 's/^(\.TH "NPM-'"$title"'" "[^"]+") "[^"]+"/\1 ""/' "$page"

		mv "$page" "${page/\///npm-}"
	done
	gzip --no-name man?/*
	local dest sec_dir
	for sec_dir in man?; do
		dest="$CLANDRO_PREFIX/share/man/$sec_dir"
		install -d "$dest"
		ln -srf "$sec_dir"/* "$dest"
	done
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	echo "Earlier versions of npm bundled with nodejs and nodejs-lts used to set npm config foreground-scripts to true."
	echo "This is no longer the case. If you had set this config, you might want to unset it now."
	echo "You can do this by running: npm config delete foreground-scripts"
	EOF
}
