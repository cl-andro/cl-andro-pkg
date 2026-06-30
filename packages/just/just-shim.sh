#!/usr/bin/env sh

# For further details see:
# https://github.com/casey/just/issues/1492#issuecomment-3231502973
# https://github.com/casey/just/pull/2870
JUST_CEILING="${JUST_CEILING:-@CLANDRO_HOME@}" exec "@CLANDRO_PREFIX@/libexec/just/just" "$@"
