CLANDRO_PKG_HOMEPAGE=https://github.com/go-jira/jira
CLANDRO_PKG_DESCRIPTION="Simple jira command line client written in Go"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.28
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/go-jira/jira/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=179abe90458281175a482cbd2e1ad662bdf563ef5acfc2cadf215ae32e0bd1e6
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin jira

	install -Dm644 /dev/null $CLANDRO_PREFIX/share/bash-completion/completions/jira-go
	install -Dm644 /dev/null $CLANDRO_PREFIX/share/zsh/site-functions/_jira_go
}

clandro_step_create_debscripts() {
	cat <<- EOF > postinst
		#!$CLANDRO_PREFIX/bin/sh
		# \`|| true\` is used since jira exits with non-zero code even if request succeedes.
		jira --completion-script-bash > $CLANDRO_PREFIX/share/bash-completion/completions/jira-go || true
		jira --completion-script-zsh > $CLANDRO_PREFIX/share/zsh/site-functions/_jira_go || true
	EOF
}
