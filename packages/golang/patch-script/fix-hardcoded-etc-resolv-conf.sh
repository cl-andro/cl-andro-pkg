for f in src/net/conf_android.go src/net/dnsclient_android.go; do
	if [ -e "${f}" ]; then
		clandro_error_exit "file ${f} already exists."
	fi
done

cp -T src/net/conf.go src/net/conf_android.go
cp -T src/net/dnsclient_unix.go src/net/dnsclient_android.go

sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" \
	${CLANDRO_SCRIPTDIR}/packages/golang/patch-script/fix-hardcoded-etc-resolv-conf.diff \
	| patch --silent -p1
