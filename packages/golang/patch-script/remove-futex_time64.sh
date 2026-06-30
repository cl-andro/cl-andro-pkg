sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
	${CLANDRO_SCRIPTDIR}/packages/golang/patch-script/remove-futex_time64.diff \
	| patch --silent -p1
