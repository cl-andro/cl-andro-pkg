CLANDRO_PKG_HOMEPAGE=https://taskwarrior.org
CLANDRO_PKG_DESCRIPTION="Shell command wrapping Taskwarrior commands"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.2.0
CLANDRO_PKG_REVISION=11
CLANDRO_PKG_SRCURL=https://github.com/GothenburgBitFactory/taskshell/releases/download/v${CLANDRO_PKG_VERSION}/tasksh-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd
CLANDRO_PKG_DEPENDS="libc++, readline, taskwarrior, libandroid-glob"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
