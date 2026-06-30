clandro_get_repo_files() {
	local PACKAGES_HASH RELEASE_FILE repo_base dl_prefix RELEASE_FILE_URL RELEASE_FILE_SIG_URL
	local -a pids=()
	# Not needed for on-device builds or when building
	# dependencies.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" = "true" || "$CLANDRO_INSTALL_DEPS" = "false" ]]; then
		return
	fi

	[[ "${CI-false}" == "true" ]] && echo "::group::INFO: Fetching repo metadata" || :

	for idx in "${!CLANDRO_REPO_URL[@]}"; do
		local CLANDRO_REPO_NAME="${CLANDRO_REPO_URL[$idx]#https://}"
		CLANDRO_REPO_NAME="${CLANDRO_REPO_NAME#http://}"
		CLANDRO_REPO_NAME="${CLANDRO_REPO_NAME//\//-}"
		case "$CLANDRO_REPO_PKG_FORMAT" in
		"debian")
			RELEASE_FILE="${CLANDRO_COMMON_CACHEDIR}/${CLANDRO_REPO_NAME}-${CLANDRO_REPO_DISTRIBUTION[$idx]}-Release"
			repo_base="${CLANDRO_REPO_URL[$idx]}/dists/${CLANDRO_REPO_DISTRIBUTION[$idx]}"
			dl_prefix="${CLANDRO_REPO_NAME}-${CLANDRO_REPO_DISTRIBUTION[$idx]}-${CLANDRO_REPO_COMPONENT[$idx]}"
			RELEASE_FILE_URL="${repo_base}/Release"
			RELEASE_FILE_SIG_URL="${RELEASE_FILE_URL}.gpg"
			;;
		"pacman")
			RELEASE_FILE="${CLANDRO_COMMON_CACHEDIR}-${CLANDRO_ARCH}/${CLANDRO_REPO_NAME}-json"
			repo_base="${CLANDRO_REPO_URL[$idx]}/${CLANDRO_ARCH}"
			RELEASE_FILE_URL="${repo_base}/${CLANDRO_REPO_DISTRIBUTION[$idx]}.json"
			RELEASE_FILE_SIG_URL="${RELEASE_FILE_URL}.sig"
			;;
		*) clandro_error_exit "Invalid package format: $CLANDRO_REPO_PKG_FORMAT"
			;;
		esac

		(
			local attempt delay=5
			if [[ "${CI-false}" == "true" ]]; then
				delay=30
			fi
			for attempt in {1..6}; do
				if clandro_download "${RELEASE_FILE_URL}" "${RELEASE_FILE}" SKIP_CHECKSUM \
						&& clandro_download "${RELEASE_FILE_SIG_URL}" "${RELEASE_FILE}.gpg" SKIP_CHECKSUM; then
					if ! gpg --verify "${RELEASE_FILE}.gpg" "${RELEASE_FILE}"; then
						echo "GPG verification failed, probably we downloaded corrupted metadata. Retrying in $delay seconds."
						sleep "$delay"
						continue
					fi

					if [[ "$CLANDRO_REPO_PKG_FORMAT" == "debian" ]]; then
						for arch in all "${CLANDRO_ARCH}"; do
							PACKAGES_HASH="$(./scripts/get_hash_from_file.py "${RELEASE_FILE}" "${arch}" "${CLANDRO_REPO_COMPONENT[$idx]}")"

							# If packages_hash = "" then the repo probably doesn't contain debs for $arch
							[[ -n "$PACKAGES_HASH" ]] && \
								clandro_download "${repo_base}/${CLANDRO_REPO_COMPONENT[$idx]}/binary-$arch/Packages" \
										"${CLANDRO_COMMON_CACHEDIR}-$arch/${dl_prefix}-Packages" "$PACKAGES_HASH" && \
								exit 0
						done
					fi
					exit 0
				fi
			done
			clandro_error_exit "Failed to download package repository metadata. Try to build without -i/-I option."
		) 2>&1 | (
			set +e
			# curl progress meter uses carriage return instead of newlines, fixing it
			sed -u 's/\r/\n/g' | while :; do
				local buffer=()
				# Half second buffer to prevent mixing lines and make output consistent.
				sleep 0.5;
				while :; do
					# read with 0 timeout does not read any data so giving minimal timeout
					IFS='' read -t 0.001 -r line; rc=$?
					# append job name to the start for tracking multiple jobs
					[[ $rc == 0 ]] && buffer+=( "[$CLANDRO_REPO_NAME]: $line" )
					# Probably EOF or timeout
					[[ $rc == 1 || $rc -ge 128 ]] && break
				done

				# prevent output garbling by using stdout as a lock file
				[[ "${#buffer[@]}" -ge 1 ]] && flock --no-fork . printf "%s\n" "${buffer[@]}"
				[[ $rc == 1 ]] && break # exit on EOF
			done
		) &
		pids+=( $! )
	done

	for _ in "${pids[@]}"; do
		if ! wait -n; then
			# One of jobs exited with non-zero status, we should return error too.
			kill "${pids[@]}" 2>/dev/null
			exit 1
		fi
	done
	[[ "${CI-false}" == "true" ]] && echo "::endgroup::" || :
}
