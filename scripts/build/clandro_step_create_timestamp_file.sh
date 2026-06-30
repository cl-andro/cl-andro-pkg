clandro_step_create_timestamp_file() {
	# Keep track of when build started so we can see what files
	# have been created.  We start by sleeping/touching so that any
	# generated files ($CLANDRO_PREFIX/bin/llvm-config from
	# clandro_step_override_config_scripts()) get an older timestamp
	# than the CLANDRO_BUILD_TS_FILE.
	sleep 0.1
	CLANDRO_BUILD_TS_FILE=$CLANDRO_PKG_TMPDIR/timestamp_$CLANDRO_PKG_NAME
	touch "$CLANDRO_BUILD_TS_FILE"
}
