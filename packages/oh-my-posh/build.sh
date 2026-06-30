CLANDRO_PKG_HOMEPAGE=https://ohmyposh.dev
CLANDRO_PKG_DESCRIPTION="A prompt theme engine for any shell."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="29.13.1"
CLANDRO_PKG_SRCURL=https://github.com/JanDeDobbeleer/oh-my-posh/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4316d8a4316e06e9202f4ab62fd99fe56195e1f90e929537e5301e240094c35e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	cd "${CLANDRO_PKG_SRCDIR}/src/"

	clandro_setup_golang
	go mod tidy
}

clandro_step_make() {
	cd "${CLANDRO_PKG_SRCDIR}/src/"

	local ldflags=''
	ldflags+="-linkmode=external "
	ldflags+="-X github.com/jandedobbeleer/oh-my-posh/src/build.Version=${CLANDRO_PKG_VERSION} "
	ldflags+="-X github.com/jandedobbeleer/oh-my-posh/src/build.Date=$(date +%F)"
	go build -buildvcs=false -ldflags="${ldflags}" -o oh-my-posh
}

clandro_step_make_install() {
	cd "${CLANDRO_PKG_SRCDIR}/src/"

	install -Dm700 ./oh-my-posh "${CLANDRO_PREFIX}/bin/"

	install -d "${CLANDRO_PREFIX}/share/oh-my-posh/themes"
	install -m 600 ../themes/* -t "${CLANDRO_PREFIX}/share/oh-my-posh/themes"
}
