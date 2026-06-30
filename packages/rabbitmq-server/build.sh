CLANDRO_PKG_HOMEPAGE=https://github.com/rabbitmq/rabbitmq-server
CLANDRO_PKG_DESCRIPTION="Feature rich, multi-protocol messaging and streaming broker"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3.0"
CLANDRO_PKG_SRCURL=https://github.com/rabbitmq/rabbitmq-server/releases/download/v${CLANDRO_PKG_VERSION}/rabbitmq-server-generic-unix-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=011f489260d6b9d1976451ddad7b3307d14bdea320e4d19ac0960beda8422126
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="erlang"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/rabbitmq-upgrade
bin/vmware-rabbitmq
lib/rabbitmq/lib/rabbitmq_server-${CLANDRO_PKG_VERSION}/escript/rabbitmq-upgrade
lib/rabbitmq/lib/rabbitmq_server-${CLANDRO_PKG_VERSION}/escript/vmware-rabbitmq
share/man/man8/rabbitmq-upgrade.8.gz
share/man/man8/rabbitmq-service.8.gz
share/man/man8/rabbitmq-echopid.8.gz
"
CLANDRO_PKG_SERVICE_SCRIPT=("rabbitmq-server")
CLANDRO_PKG_SERVICE_SCRIPT+=(
"if [ -f \"$CLANDRO_ANDROID_HOME/.config/rabbitmq/rabbitmq.conf\" ]; then
	CONFIG=\"$CLANDRO_ANDROID_HOME/.config/rabbitmq/rabbitmq.conf\"; else
	CONFIG=\"$CLANDRO_PREFIX/etc/rabbitmq/rabbitmq.conf\"; fi\n\
	exec rabbitmq-server \$CONFIG 2>&1")

clandro_step_make_install() {
	sed -i "s|RABBITMQ_HOME=.*|RABBITMQ_HOME=${CLANDRO_PREFIX}/lib/rabbitmq/lib/rabbitmq_server-${CLANDRO_PKG_VERSION}|g" sbin/rabbitmq-env
	sed -i "s|SYS_PREFIX=.*|SYS_PREFIX=${CLANDRO_PREFIX}|g" sbin/rabbitmq-defaults

	mkdir -p "${CLANDRO_PREFIX}"/lib/rabbitmq/lib/rabbitmq_server-"${CLANDRO_PKG_VERSION}"
	mkdir -p "${CLANDRO_PREFIX}"/etc/rabbitmq
	touch "${CLANDRO_PREFIX}"/etc/rabbitmq/enabled_plugins

	cp -r plugins "${CLANDRO_PREFIX}"/lib/rabbitmq/lib/rabbitmq_server-"${CLANDRO_PKG_VERSION}"
	cp -r escript "${CLANDRO_PREFIX}"/lib/rabbitmq/lib/rabbitmq_server-"${CLANDRO_PKG_VERSION}"
	cp sbin/* "${CLANDRO_PREFIX}"/bin
	cp -r share "${CLANDRO_PREFIX}"
}
