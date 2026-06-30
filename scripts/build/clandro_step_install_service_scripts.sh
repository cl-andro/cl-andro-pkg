clandro_step_install_service_scripts() {
	array_length=${#CLANDRO_PKG_SERVICE_SCRIPT[@]}
	if [ $array_length -eq 0 ]; then return; fi

	# CLANDRO_PKG_SERVICE_SCRIPT should have the structure =("daemon name" 'script to execute')
	if [ $(( $array_length & 1 )) -eq 1 ]; then
		clandro_error_exit "CLANDRO_PKG_SERVICE_SCRIPT has to be an array of even length"
	fi

	mkdir -p $CLANDRO_PREFIX/var/service
	cd $CLANDRO_PREFIX/var/service
	for ((i=0; i<${array_length}; i+=2)); do
		mkdir -p ${CLANDRO_PKG_SERVICE_SCRIPT[$i]}
		# We unlink ${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run if it exists to
		# allow it to be overwritten through CLANDRO_PKG_SERVICE_SCRIPT
		if [ -L "${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run" ]; then
			unlink "${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run"
		fi
		echo "#!$CLANDRO_PREFIX/bin/sh" > ${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run
		echo -e ${CLANDRO_PKG_SERVICE_SCRIPT[$((i + 1))]} >> ${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run

		# Do not add service script to CONFFILES if it already exists there
		if [[ $CLANDRO_PKG_CONFFILES != *${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run* ]]; then
			CLANDRO_PKG_CONFFILES+=" var/service/${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run"
		fi

		chmod +x ${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/run

		# Avoid creating service/<service>/log/log/
		if [ "${CLANDRO_PKG_SERVICE_SCRIPT[$i]: -4}" != "/log" ]; then
			touch ${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/down
			CLANDRO_PKG_CONFFILES+=" var/service/${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/down"
			local _log_run=${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/log/run
			rm -rf "${_log_run}"
			mkdir -p "$(dirname "${_log_run}")"
			cat <<-EOF > "${_log_run}"
				#!$CLANDRO_PREFIX/bin/sh
				svlogger="$CLANDRO_PREFIX/share/clandro-services/svlogger"
				exec "\${svlogger}" "\$@"
			EOF
			chmod 0700 "${_log_run}"

			CLANDRO_PKG_CONFFILES+="
			var/service/${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/log/run
			var/service/${CLANDRO_PKG_SERVICE_SCRIPT[$i]}/log/down
			"
		fi
	done
}
