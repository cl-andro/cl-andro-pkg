CLANDRO_PKG_HOMEPAGE=https://www.terraform.io
CLANDRO_PKG_DESCRIPTION="A tool for building, changing, and versioning infrastructure safely and efficiently"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.4"
CLANDRO_PKG_SRCURL=https://github.com/hashicorp/terraform/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ab9e6d743c0a00be8c6c1a2723f39191e3cbd14517acbc3e6ff2baa753865074
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="git"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH="${CLANDRO_PKG_BUILDDIR}"

	mkdir -p "${GOPATH}"/src/github.com/hashicorp
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}"/src/github.com/hashicorp/terraform

	cd "${GOPATH}"/src/github.com/hashicorp/terraform || exit 1

	go mod init || :
	go mod tidy

	# Backport of https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c
	clandro_download "https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c.patch" \
		"${CLANDRO_PKG_TMPDIR}"/patch1 \
		2812df1db9e42473c30cdbc1f42ae4555027a1e56321189be9f50f52125c146c

	for f in "${GOPATH}"/pkg/mod/github.com/lib/pq@*/user_posix.go; do
		chmod 0755 "$(dirname "$f")"
		chmod 0644 "${f}"
		patch --silent -p1 -d "$(dirname "$f")" <"${CLANDRO_PKG_TMPDIR}"/patch1
		# The patch above does not fix build issue for some reason.
		# Alternative workaround:
		rm -f "${f}"
		echo "package pq" > "${f}"
	done

	local GO_LDFLAGS="-X 'github.com/hashicorp/terraform/version.Prerelease='"
	GO_LDFLAGS="${GO_LDFLAGS} -X 'github.com/hashicorp/terraform/version.Version=${CLANDRO_PKG_VERSION}'"

	go build -ldflags "${GO_LDFLAGS}" -o terraform .
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "${GOPATH}"/src/github.com/hashicorp/terraform/terraform
}
