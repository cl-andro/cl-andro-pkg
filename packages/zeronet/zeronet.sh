#!@CLANDRO_PREFIX@/bin/bash
exec @CLANDRO_PREFIX@/opt/zeronet/zeronet.py \
	--config_file @CLANDRO_PREFIX@/etc/zeronet.conf \
	--data_dir @CLANDRO_PREFIX@/var/lib/zeronet \
	--log_dir @CLANDRO_PREFIX@/var/log/zeronet "$@"
