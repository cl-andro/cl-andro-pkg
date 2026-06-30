CLANDRO_PKG_HOMEPAGE=https://www.openssh.com/
CLANDRO_PKG_DESCRIPTION="Secure shell for logging into a remote machine"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="10.3p1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/openssh/openssh-portable/archive/refs/tags/V_$(sed 's/\./_/g; s/p/_P/g' <<< $CLANDRO_PKG_VERSION).tar.gz
CLANDRO_PKG_SHA256=c1a4420b1a25ba7336f62afd42ed5974d93455a2ab8c769b5e8e0c8ff8eedadc
CLANDRO_PKG_DEPENDS="krb5, ldns, libandroid-support, libedit, openssh-sftp-server, openssl, clandro-auth, zlib"
CLANDRO_PKG_SUGGESTS="clandro-services"
CLANDRO_PKG_CONFLICTS="dropbear"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/([0-9]+)_([0-9]+)_P([0-9]+)/\1.\2p\3/"
# Certain packages are not safe to build on device because their
# build.sh script deletes specific files in $CLANDRO_PREFIX.
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
# --disable-strip to prevent host "install" command to use "-s", which won't work for target binaries:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-etc-default-login
--disable-lastlog
--disable-libutil
--disable-pututline
--disable-pututxline
--disable-strip
--disable-utmp
--disable-utmpx
--disable-wtmp
--disable-wtmpx
--sysconfdir=$CLANDRO_PREFIX/etc/ssh
--with-cflags=-Dfd_mask=int
--with-ldns
--with-libedit
--with-mantype=man
--without-ssh1
--without-stackprotect
--with-pid-dir=$CLANDRO_PREFIX/var/run
--with-privsep-path=$CLANDRO_PREFIX/var/empty
--with-xauth=$CLANDRO_PREFIX/bin/xauth
--with-kerberos5
--with-default-path=$CLANDRO_PREFIX/bin
ac_cv_func_endgrent=yes
ac_cv_func_fmt_scaled=no
ac_cv_func_getlastlogxbyname=no
ac_cv_func_readpassphrase=no
ac_cv_func_strnvis=no
ac_cv_header_sys_un_h=yes
ac_cv_lib_crypt_crypt=no
ac_cv_search_getrrsetbyname=no
ac_cv_func_bzero=yes
ac_cv_member_struct_passwd_pw_gecos=no
"
# Configure script requires this variable to set prefixed path to program 'passwd'
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="PATH_PASSWD_PROG=${CLANDRO_PREFIX}/bin/passwd"

CLANDRO_PKG_MAKE_INSTALL_TARGET="install-nokeys"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/slogin share/man/man1/slogin.1"
CLANDRO_PKG_CONFFILES="etc/ssh/ssh_config etc/ssh/sshd_config"

clandro_step_pre_configure() {
	autoreconf

	CPPFLAGS+=" -DHAVE_ATTRIBUTE__SENTINEL__=1 -DBROKEN_SETRESGID"
	LD=$CC # Needed to link the binaries
}

clandro_step_post_configure() {
	# We need to remove this file before installing, since otherwise the
	# install leaves it alone which means no updated timestamps.
	rm -f "$CLANDRO_PREFIX/etc/ssh/moduli"
	rm -f "$CLANDRO_PREFIX/etc/ssh/ssh_config"
	rm -f "$CLANDRO_PREFIX/etc/ssh/sshd_config"
}

clandro_step_post_make_install() {
	install -Dm700 "$CLANDRO_PKG_BUILDER_DIR/source-ssh-agent.sh" "$CLANDRO_PREFIX/libexec/source-ssh-agent.sh"
	install -Dm700 "$CLANDRO_PKG_BUILDER_DIR/wrap-ssh-agent.sh"   "$CLANDRO_PREFIX/libexec/wrap-ssh-agent.sh"
	ln -s -f -T '../libexec/wrap-ssh-agent.sh'                   "$CLANDRO_PREFIX/bin/ssha"
	ln -s -f -T '../libexec/wrap-ssh-agent.sh'                   "$CLANDRO_PREFIX/bin/sftpa"
	ln -s -f -T '../libexec/wrap-ssh-agent.sh'                   "$CLANDRO_PREFIX/bin/scpa"

	mkdir -p "$CLANDRO_PREFIX/var/run"
	echo "OpenSSH needs this directory to put sshd.pid in" > "$CLANDRO_PREFIX/var/run/README.openssh"
	# Install ssh-copy-id:
	echo "#!$CLANDRO_PREFIX/bin/sh" > "$CLANDRO_PREFIX/bin/ssh-copy-id"
	tail -n+2 "$CLANDRO_PKG_SRCDIR/contrib/ssh-copy-id" >> "$CLANDRO_PREFIX/bin/ssh-copy-id"
	sed -i -e "s|SANE_SH:-.*|SANE_SH:-$CLANDRO_PREFIX/bin/bash}|g" "$CLANDRO_PREFIX/bin/ssh-copy-id"
	chmod 0700 "$CLANDRO_PREFIX/bin/ssh-copy-id"
	# Install ssh-copy-id's man page
	mkdir -p "$CLANDRO_PREFIX/share/man/man1"
	cp "$CLANDRO_PKG_SRCDIR/contrib/ssh-copy-id.1" "$CLANDRO_PREFIX/share/man/man1"

	mkdir -p "$CLANDRO_PREFIX/etc/ssh/"
	cp "$CLANDRO_PKG_SRCDIR/moduli" "$CLANDRO_PREFIX/etc/ssh/moduli"

	# Setup clandro-services scripts
	mkdir -p "$CLANDRO_PREFIX/var/service/sshd/log"
	ln -sf "$CLANDRO_PREFIX/share/clandro-services/svlogger" "$CLANDRO_PREFIX/var/service/sshd/log/run"
	sed "s%@CLANDRO_PREFIX@%$CLANDRO_PREFIX%g" "$CLANDRO_PKG_BUILDER_DIR/sv/sshd.run.in" > "$CLANDRO_PREFIX/var/service/sshd/run"
	chmod 700 "$CLANDRO_PREFIX/var/service/sshd/run"
	touch "$CLANDRO_PREFIX/var/service/sshd/down"

	mkdir -p "$CLANDRO_PREFIX/var/service/ssh-agent/log"
	ln -sf "$CLANDRO_PREFIX/share/clandro-services/svlogger" "$CLANDRO_PREFIX/var/service/ssh-agent/log/run"
	sed "s%@CLANDRO_PREFIX@%$CLANDRO_PREFIX%g" "$CLANDRO_PKG_BUILDER_DIR/sv/ssh-agent.run.in" > "$CLANDRO_PREFIX/var/service/ssh-agent/run"
	chmod 700 "$CLANDRO_PREFIX/var/service/ssh-agent/run"
	touch "$CLANDRO_PREFIX/var/service/ssh-agent/down"
}

clandro_step_post_massage() {
	# Directories referenced by Include in ssh_config and sshd_config.
	mkdir -p etc/ssh/ssh_config.d
	mkdir -p etc/ssh/sshd_config.d

	# Verify that we have man pages packaged.
	# https://github.com/termux/termux-packages/issues/1538
	local manpage
	local -a EXPECTED_MAN_PAGES=(
		'scp.1' 'ssh-add.1' 'ssh-agent.1' 'ssh-copy-id.1' 'ssh-keygen.1' 'ssh-keyscan.1' 'ssh.1'
		'moduli.5' 'ssh_config.5' 'sshd_config.5'
		'ssh-keysign.8' 'ssh-pkcs11-helper.8' 'ssh-sk-helper.8' 'sshd.8'
	)

	for manpage in "${EXPECTED_MAN_PAGES[@]}"; do
		[[ -f "share/man/man${manpage#*.}/$manpage.gz" ]] || clandro_error_exit "Missing man page $manpage in openssh"
	done

	cd "$CLANDRO_PKG_MASSAGEDIR/../subpackages/openssh-sftp-server/massage/$CLANDRO_PREFIX" || clandro_error_exit "Failed to check openssh-sftp-server man pages"
	for manpage in 'sftp.1' 'sftp-server.8'; do
		[[ -f "share/man/man${manpage#*.}/$manpage.gz" ]] || clandro_error_exit "Missing man page $manpage in openssh"
	done
}

clandro_step_create_debscripts() {
	{
	echo "#!$CLANDRO_PREFIX/bin/sh"
	echo "mkdir -p \"$CLANDRO_PREFIX/var/empty\""
	echo "mkdir -p \"\$HOME/.ssh\""
	echo "touch \"\$HOME/.ssh/authorized_keys\""
	echo "chmod 700 \"\$HOME/.ssh\""
	echo "chmod 600 \"\$HOME/.ssh/authorized_keys\""
	echo ""
	echo "for a in rsa ecdsa ed25519; do"
	echo "	KEYFILE=\"$CLANDRO_PREFIX/etc/ssh/ssh_host_\${a}_key\""
	echo "	test ! -f \"\$KEYFILE\" && ssh-keygen -N '' -t \$a -f \"\$KEYFILE\""
	echo "done"
	echo ""
	echo "echo \"\""
	echo "echo \"If you plan to use the 'ssh-agent'\""
	echo "echo \"it is recommended to run it as a service.\""
	echo "echo \"Run 'pkg i clandro-services'\""
	echo "echo \"to install the ('runit') service manager\""
	echo "echo \"\""
	echo "echo \"You can enable the ssh-agent service\""
	echo "echo \"using 'sv-enable ssh-agent'\""
	echo "echo \"You can also enable sshd to autostart\""
	echo "echo \"using 'sv-enable sshd'\""
	echo "exit 0"
	} > postinst
	chmod 0700 postinst
}
