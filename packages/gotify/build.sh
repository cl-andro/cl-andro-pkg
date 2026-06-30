CLANDRO_PKG_HOMEPAGE=https://github.com/gotify/server
CLANDRO_PKG_DESCRIPTION="A simple server for sending and receiving messages in real-time per WebSocket."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Izumi Sena Sora <info@unordinary.eu.org>"
CLANDRO_PKG_VERSION="2.9.1"
CLANDRO_PKG_SRCURL="https://github.com/gotify/server/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=fcf3abc76d841f1a248272c20251ee6f2dc8ef2d6c21fda9f459f5c919389d15
CLANDRO_PKG_BUILD_DEPENDS="yarn"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	clandro_setup_nodejs

	export YARN_ENABLE_HARDENED_MODE=0

	local bin="$CLANDRO_PKG_BUILDDIR/_bin"
	mkdir -p "$bin"

	local yarn="$bin/yarn"
	cat > "$yarn" <<-EOF
		#!$(command -v sh)
		exec sh $CLANDRO_PREFIX/bin/yarn "\$@"
		EOF

	chmod 0755 "$yarn"

	export PATH="$bin:$PATH"

	npm install --global typescript

	(cd ui && yarn install && yarn build)

	export LD_FLAGS="-w -s -X main.Version=${CLANDRO_PKG_VERSION} -X main.BuildDate=$(date "+%F-%T") -X main.Commit=${CLANDRO_PKG_SHA256} -X main.Mode=prod";

	go build -ldflags="$LD_FLAGS" -o "${CLANDRO_PKG_NAME}"
}

clandro_step_make_install() {
	install -Dm700 "${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}/bin"
}
