sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
	${CLANDRO_SCRIPTDIR}/packages/golang/patch-script/remove-pidfd.diff \
	| patch --silent -p1
