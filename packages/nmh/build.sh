CLANDRO_PKG_HOMEPAGE=http://www.nongnu.org/nmh/
CLANDRO_PKG_DESCRIPTION="Powerful electronic mail handling system"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download-mirror.savannah.gnu.org/releases/nmh/nmh-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=366ce0ce3f9447302f5567009269c8bb3882d808f33eefac85ba367e875c8615
CLANDRO_PKG_DEPENDS="gdbm, libcurl, libiconv, libsasl, ncurses, openssl, readline"
CLANDRO_PKG_BUILD_IN_SRC=true

# We don't have complete sendmail utility.
# Using here a one from busybox, even if it may not work.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_sendmailpath=$CLANDRO_PREFIX/bin/applets/sendmail
--with-cyrus-sasl
--with-tls"

CLANDRO_PKG_CONFFILES="
etc/nmh/MailAliases
etc/nmh/components
etc/nmh/digestcomps
etc/nmh/distcomps
etc/nmh/forwcomps
etc/nmh/mhl.body
etc/nmh/mhl.digest
etc/nmh/mhl.format
etc/nmh/mhl.forward
etc/nmh/mhl.headers
etc/nmh/mhl.reply
etc/nmh/mhn.defaults
etc/nmh/mts.conf
etc/nmh/rcvdistcomps
etc/nmh/rcvdistcomps.outbox
etc/nmh/replcomps
etc/nmh/replgroupcomps
etc/nmh/scan.MMDDYY
etc/nmh/scan.YYYYMMDD
etc/nmh/scan.default
etc/nmh/scan.mailx
etc/nmh/scan.nomime
etc/nmh/scan.size
etc/nmh/scan.time
etc/nmh/scan.timely
etc/nmh/scan.unseen"

clandro_step_pre_configure() {
	CLANDRO_PKG_MAKE_PROCESSES=1
	autoreconf -fi
}

clandro_step_post_make_install() {
	# We disabled hardlinks with a patch. Replace them with
	# symlinks here.
	ln -sfr "$CLANDRO_PREFIX"/bin/flist "$CLANDRO_PREFIX"/bin/flists
	ln -sfr "$CLANDRO_PREFIX"/bin/folder "$CLANDRO_PREFIX"/bin/folders
	ln -sfr "$CLANDRO_PREFIX"/bin/new "$CLANDRO_PREFIX"/bin/fnext
	ln -sfr "$CLANDRO_PREFIX"/bin/new "$CLANDRO_PREFIX"/bin/fprev
	ln -sfr "$CLANDRO_PREFIX"/bin/new "$CLANDRO_PREFIX"/bin/unseen
	ln -sfr "$CLANDRO_PREFIX"/bin/show "$CLANDRO_PREFIX"/bin/prev
	ln -sfr "$CLANDRO_PREFIX"/bin/show "$CLANDRO_PREFIX"/bin/next
}
