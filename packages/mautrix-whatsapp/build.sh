CLANDRO_PKG_HOMEPAGE=https://maunium.net/go/mautrix-whatsapp/
CLANDRO_PKG_DESCRIPTION="A Matrix-WhatsApp puppeting bridge"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2604.0"
CLANDRO_PKG_SRCURL=https://github.com/mautrix/whatsapp/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a38a17802464ebc597db8cd579239d6bbd4dcd02f32147c5544364a35f1ee5df
CLANDRO_PKG_DEPENDS="libolm"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build \
	-ldflags "-X main.Tag=$CLANDRO_PKG_VERSION -X 'main.BuildTime=$(date -d @"$SOURCE_DATE_EPOCH" '+%b %_d %Y, %H:%M:%S')'" \
	./cmd/mautrix-whatsapp
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin mautrix-whatsapp
}
