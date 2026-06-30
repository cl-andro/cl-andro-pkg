CLANDRO_SUBPKG_DESCRIPTION="A native debugger extension for code-oss based on LLDB"
CLANDRO_SUBPKG_INCLUDE="share/doc/code-oss-extension-codelldb"
CLANDRO_SUBPKG_DEPENDS="code-oss, vsix-package-codelldb"
# depends on vsix-package-codelldb,
# which depends on codelldb,
# which does not work properly on 32-bit Android
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=false

clandro_step_create_subpkg_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		code-oss --install-extension "$CLANDRO_PREFIX/opt/vsix-packages/codelldb-$CLANDRO_PKG_FULLVERSION.vsix"
		exit 0
	EOF
	cat <<-EOF >./prerm
		#!${CLANDRO_PREFIX}/bin/sh
		if [ "$CLANDRO_PACKAGE_FORMAT" = "debian" ] && [ "\$1" != "remove" ]; then
			exit 0
		fi
		code-oss --uninstall-extension vadimcn.vscode-lldb
		exit 0
	EOF
	chmod +x ./postinst ./prerm
}
