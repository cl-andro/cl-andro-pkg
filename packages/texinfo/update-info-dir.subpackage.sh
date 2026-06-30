CLANDRO_SUBPKG_DESCRIPTION="Update or create index file from all installed info files in directory"
CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=true
CLANDRO_SUBPKG_INCLUDE="
bin/update-info-dir
share/man/man8/update-info-dir.8.gz
share/libalpm/hooks/texinfo-update-info-dir.hook
"

clandro_step_create_subpkg_debscripts() {
	local INFODIR=$CLANDRO_PREFIX/share/info

	cat <<- EOF > ./triggers
	interest-noawait $INFODIR
	EOF

	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	if [ -d $INFODIR ]; then
	$CLANDRO_PREFIX/bin/update-info-dir
	fi
	exit
	EOF
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi

	cat <<- EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	rm -rf $INFODIR/dir
	exit
	EOF
}
