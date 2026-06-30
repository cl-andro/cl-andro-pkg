CLANDRO_PKG_HOMEPAGE=https://gitlab.com/gitlab-org/cli
CLANDRO_PKG_DESCRIPTION="A GitLab CLI tool bringing GitLab to your command line"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.95.0"
CLANDRO_PKG_SRCURL=https://gitlab.com/gitlab-org/cli/-/archive/v${CLANDRO_PKG_VERSION}/cli-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=ff417c5c7d86aa5f1e5ac1a0ea85ae753c79e8d1fea414ee5110a421bf7f8e7b
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="GLAB_VERSION=${CLANDRO_PKG_VERSION}"

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin bin/glab

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/glab.bash
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_glab
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/glab.fish
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		glab completion -s bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/glab.bash
		glab completion -s zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_glab
		glab completion -s fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/glab.fish
	EOF
}
