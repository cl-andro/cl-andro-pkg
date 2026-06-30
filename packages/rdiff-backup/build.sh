CLANDRO_PKG_HOMEPAGE=https://rdiff-backup.net
CLANDRO_PKG_DESCRIPTION="A utility for local/remote mirroring and incremental backups"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.2.6"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/rdiff-backup/rdiff-backup/releases/download/v${CLANDRO_PKG_VERSION/\~/}/rdiff-backup-${CLANDRO_PKG_VERSION/\~/}.tar.gz
CLANDRO_PKG_SHA256=d0778357266bc6513bb7f75a4570b29b24b2760348bbf607babfc3a6f09458cf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="librsync, python, python-pip"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	continue
}
