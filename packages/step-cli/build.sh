CLANDRO_PKG_HOMEPAGE=https://smallstep.com/cli
CLANDRO_PKG_DESCRIPTION="An easy-to-use CLI tool for building, operating, and automating Public Key Infrastructure (PKI) systems and workflows"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.30.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/smallstep/cli/releases/download/v${CLANDRO_PKG_VERSION}/step_${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=db62a88ebec709de591dd86eec9759e15bdff4c6b96f3d7db6f53b6cf86bd3ec
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="clandro-tools"

clandro_step_post_get_source() {
	# clandro_unpack_src_archive defaults to strip-components=1
	# which works for majority of archives with source code
	# in a subfolder
	# unfortunately this breaks archives with source code at
	# root level
	# manually extract without strip-components
	clandro_download_src_archive
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar xf "$file" -C "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make() {
	clandro_setup_golang

	local _DATE=$(date -u '+%Y-%m-%d %H:%M UTC')
	go build -v -ldflags "-X \"main.Version=$CLANDRO_PKG_VERSION\" -X \"main.BuildTime=$_DATE\"" \
		./cmd/step
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin step
}


clandro_step_post_massage() {
	mkdir -p ./share/bash-completion/completions
	mkdir -p ./share/zsh/site-functions
	mkdir -p ./share/fish/vendor_completions.d
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		${CLANDRO_PREFIX}/bin/step completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/step
		${CLANDRO_PREFIX}/bin/step completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_step
		${CLANDRO_PREFIX}/bin/step completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/step.fish
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${CLANDRO_PREFIX}/bin/sh
		rm -f ${CLANDRO_PREFIX}/share/bash-completion/completions/step
		rm -f ${CLANDRO_PREFIX}/share/zsh/site-functions/_step
		rm -f ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/step.fish
		exit 0
	EOF
}
