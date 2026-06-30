CLANDRO_PKG_HOMEPAGE=https://gitlab.com/volian/nala
CLANDRO_PKG_DESCRIPTION="Commandline frontend for the apt package manager"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://gitlab.com/volian/nala/-/archive/v${CLANDRO_PKG_VERSION}/nala-v${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=49e384aa3b94597d09c61b7accc41d1cf10cb6beea85d4620c80c28d7cdc4d5f
CLANDRO_PKG_DEPENDS="python-apt, python-pip"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="poetry"
CLANDRO_PKG_PYTHON_TARGET_DEPS="anyio, httpx, jsbeautifier, pexpect, python-debian, rich, tomli, typer, typing-extensions"
CLANDRO_PKG_PYTHON_RUNTIME_DEPS="nala, python-debian"

clandro_step_pre_configure() {
	rm -rf nala/__init__.py.orig
}

clandro_step_post_make_install() {
	# from nala_build.py
	for file in docs/*.rst; do
		pandoc "${file}" --output="${file%.*}" --standalone \
			--variable=header:"Nala User Manual" \
			--variable=footer:"${CLANDRO_PKG_VERSION}" \
			--variable=date:"$(date -d @${SOURCE_DATE_EPOCH})" \
			--variable=section:8 \
			--from rst --to man

		install -Dm600 -t "$CLANDRO_PREFIX"/share/man/man8/ "${file%.*}"
	done

	install -Dm600 -t $CLANDRO_PREFIX/etc/nala debian/nala.conf
	install -Dm600 debian/nala.fish "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/nala.fish
	install -Dm600 debian/bash-completion "$CLANDRO_PREFIX"/share/bash-completion/completions/nala
	install -Dm600 debian/_nala "$CLANDRO_PREFIX"/share/zsh/site-functions/_nala
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/lib/nala
	mkdir -p $CLANDRO_PREFIX/var/log/nala
	mkdir -p $CLANDRO_PREFIX/var/lock
	EOF
}
