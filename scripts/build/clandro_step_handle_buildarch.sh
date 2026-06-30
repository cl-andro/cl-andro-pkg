clandro_step_handle_buildarch() {
	[ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] && return

	# If $CLANDRO_PREFIX already exists, it may have been built for a different arch
	local CLANDRO_ARCH_FILE=/data/CLANDRO_ARCH
	if [ -f "${CLANDRO_ARCH_FILE}" ]; then
		local CLANDRO_PREVIOUS_ARCH
		CLANDRO_PREVIOUS_ARCH=$(cat $CLANDRO_ARCH_FILE)
		if [ "$CLANDRO_PREVIOUS_ARCH" != "$CLANDRO_ARCH" ]; then
			local CLANDRO_DATA_BACKUPDIRS=$CLANDRO_TOPDIR/_databackups
			mkdir -p "$CLANDRO_DATA_BACKUPDIRS"
			local CLANDRO_DATA_PREVIOUS_BACKUPDIR=$CLANDRO_DATA_BACKUPDIRS/$CLANDRO_PREVIOUS_ARCH
			local CLANDRO_DATA_CURRENT_BACKUPDIR=$CLANDRO_DATA_BACKUPDIRS/$CLANDRO_ARCH
			# Save current /data (removing old backup if any)
			if test -e "$CLANDRO_DATA_PREVIOUS_BACKUPDIR"; then
				clandro_error_exit "Directory already exists"
			fi
			if [ -d /data/data ]; then
				mv /data/data "$CLANDRO_DATA_PREVIOUS_BACKUPDIR"
				if [ -d "${CLANDRO_DATA_PREVIOUS_BACKUPDIR}/${CLANDRO_APP_PACKAGE}/cgct" ]; then
					mkdir -p "/data/data/${CLANDRO_APP_PACKAGE}"
					mv "${CLANDRO_DATA_PREVIOUS_BACKUPDIR}/${CLANDRO_APP_PACKAGE}/cgct" "/data/data/${CLANDRO_APP_PACKAGE}"
				fi
			fi
			# Restore new one (if any)
			if [ -d "$CLANDRO_DATA_CURRENT_BACKUPDIR" ]; then
				mv "$CLANDRO_DATA_CURRENT_BACKUPDIR" /data/data
			fi
		fi
	fi

	# Keep track of current arch we are building for.
	echo "$CLANDRO_ARCH" > $CLANDRO_ARCH_FILE
}
