CLANDRO_PKG_HOMEPAGE=https://garagehq.deuxfleurs.fr/
CLANDRO_PKG_DESCRIPTION="S3-compatible object store for small self-hosted geo-distributed deployments"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.0"
CLANDRO_PKG_SRCURL=https://git.deuxfleurs.fr/Deuxfleurs/garage/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b83a981677676b35400bbbaf20974c396f32da31c7c7630ce55fc3e62c0e2e01
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/garage.toml"
CLANDRO_PKG_DEPENDS="openssl-tool"

clandro_step_make() {
	clandro_setup_rust
	cargo build --package garage --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/garage"
	install -Dm644 "$CLANDRO_PKG_BUILDER_DIR/garage.toml" "$CLANDRO_PREFIX/share/garage/garage.toml.in"
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		if [ -e "$CLANDRO_PREFIX/etc/garage.toml" ]; then
			exit 0
		fi

		echo "[*] Generating default configuration file at $CLANDRO_PREFIX/etc/garage.toml"

		mkdir -p "$CLANDRO_PREFIX/etc"

		rpc_secret=\$(openssl rand -hex 32)
		admin_token=\$(openssl rand -hex 32)
		metrics_token=\$(openssl rand -hex 32)

		awk \
			-v prefix="$CLANDRO_PREFIX" \
			-v rpc_secret="\$rpc_secret" \
			-v admin_token="\$admin_token" \
			-v metrics_token="\$metrics_token" '
				{
					gsub(/@CLANDRO_PREFIX@/, prefix)
					gsub(/@GARAGE_RPC_SECRET@/, rpc_secret)
					gsub(/@GARAGE_ADMIN_TOKEN@/, admin_token)
					gsub(/@GARAGE_METRICS_TOKEN@/, metrics_token)
					print
				}
			' "$CLANDRO_PREFIX/share/garage/garage.toml.in" > "$CLANDRO_PREFIX/etc/garage.toml"
		chmod 0600 "$CLANDRO_PREFIX/etc/garage.toml"

		exit 0
	EOF

	chmod 0755 ./postinst
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/lib/garage/meta"
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/lib/garage/data"
}
