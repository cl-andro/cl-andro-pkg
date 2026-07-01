# shellcheck shell=bash
# shellcheck disable=SC2034

# XXX: This file is sourced by repology-updater script
# So avoid doing things like executing commands except of those available in
# coreutils and are clearly not a default part of most Linux installations,
# or sourcing any other script in our build directories.

if [ -z "${BASH_VERSION:-}" ]; then
    echo "The 'properties.sh' script must be run from a 'bash' shell."; return 64 2>/dev/null|| exit 64 # EX__USAGE
fi



###
# Variables for validation of Clandro properties variables.
# Validation is done to ensure packages are not compiled for invalid
# values that are not supported, and values are as per Clandro file
# path limits.
#
# Additionally, the Clandro packages build system is an unsafe mess of
# unquoted variables in shell scripts, and so validation is necessary
# for important variables, especially specific path variables against
# `CLANDRO_REGEX__SAFE_*_PATH` regexes to reduce any potential damage.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
###

##
# The map of variable names to their space separated list of validator
# actions to perform.
#
# Following are the supported validator actions.
# - `allow_unset_value`: Allow variable to be defined but unset, and
#    skip other validations.
# - `app_package_name`: Variable must match `CLANDRO_REGEX__APP_PACKAGE_NAME`.
# - `invalid_clandro_rootfs_paths`: Path variable must not match
#   `CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS`.
# - `invalid_clandro_home_paths`: Path variable must not match
#   `CLANDRO_REGEX__INVALID_CLANDRO_HOME_PATHS`.
# - `invalid_clandro_prefix_paths`: Path variable must not match
#   `CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS`.
# - `path_equal_to_or_under_clandro_rootfs`: Path variable must be equal
#   to or be under `CLANDRO__ROOTFS`.
# - `path_under_clandro_rootfs`:Path variable must be under `CLANDRO__ROOTFS`.
# - `safe_absolute_path`: Path variable must match
#   `CLANDRO_REGEX__SAFE_ABSOLUTE_PATH` and must not match
#   `CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH`.
# - `safe_relative_path`: Path variable must match
#   `CLANDRO_REGEX__SAFE_RELATIVE_PATH` and must not match
#   `CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH`.
# - `safe_rootfs_or_absolute_path`: Path variable must match
#   `CLANDRO_REGEX__SAFE_ROOTFS_OR_ABSOLUTE_PATH` and must not match
#   `CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH`.
# - `apps_api_socket__server_parent_dir`: Path variable must have max
#    length `<= CLANDRO__APPS_API_SOCKET__SERVER_PARENT_DIR___MAX_LEN`
#    including the null `\0` terminator.
# - `unix_path_max`: Path variable must have max length `<= CLANDRO__UNIX_PATH_MAX`
#    including the null `\0` terminator.
# - `unsigned_int`: Variable must match `CLANDRO_REGEX__UNSIGNED_INT`.
##
unset __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_MAP; declare -A __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_MAP=()

##
# The list of variable names added to `__CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_MAP`
# that maintains insertion order.
##
unset __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_VARIABLE_NAMES; declare -a __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_VARIABLE_NAMES=()

##
# Whether to validate max lengths of Clandro paths. Set to `false` to skip validation.
##
__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN="true"

##
# Whether to validate `usr` merge format for `CLANDRO__PREFIX`. Set to `false` to skip validation.
# Check `CLANDRO__PREFIX` variable docs for more info.
##
__CLANDRO_BUILD_PROPS__VALIDATE_CLANDRO_PREFIX_USR_MERGE_FORMAT="true"



##
# `__clandro_build_props__add_variables_validator_actions` `<variable_name>` `<validator_actions>`
##
__clandro_build_props__add_variables_validator_actions() {

    if [ $# -ne 2 ]; then
        echo "Invalid argument count '$#' to '__clandro_build_props__add_variables_validator_actions'." 1>&2
        return 1
    fi

    local variable_name="$1"
    local validator_actions="$2"

    if [[ ! "$variable_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "The variable_name '$variable_name' passed to '__clandro_build_props__add_variables_validator_actions' is not a valid shell variable name." 1>&2
        return 1
    fi

    if [[ " ${__CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_VARIABLE_NAMES[*]} " != *" $variable_name "* ]]; then
        __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_VARIABLE_NAMES+=("$variable_name")
    fi

    __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_MAP["$variable_name"]+="$validator_actions"

}





####
# Variables for validating Clandro variables.
####

##
# Regex that matches an absolute path that starts with a `/` with at
# least one characters under rootfs `/`. Duplicate or trailing path
# separators `/` are not allowed.
##
CLANDRO_REGEX__ABSOLUTE_PATH='^(/[^/]+)+$'

##
# Regex that matches a relative path that does not start with a `/`.
# Duplicate or trailing path separators `/` are not allowed.
##
CLANDRO_REGEX__RELATIVE_PATH='^[^/]+(/[^/]+)*$'

##
# Regex that matches (rootfs `/`) or (an absolute path that starts
# with a `/`). Duplicate or trailing path separators `/` are not
# allowed.
##
CLANDRO_REGEX__ROOTFS_OR_ABSOLUTE_PATH='^((/)|((/[^/]+)+))$'


##
# Regex that matches a safe absolute path that starts with a `/` with
# at least one characters under rootfs `/`. Duplicate or trailing path
# separators `/` are not allowed. The path component characters must
# be in the range `[a-zA-Z0-9+,.=_-]`.
#
# The path must also be validated against
# `CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH`.
##
CLANDRO_REGEX__SAFE_ABSOLUTE_PATH='^(/[a-zA-Z0-9+,.=_-]+)+$'

##
# Regex that matches a safe relative path that does not start with a
# `/`. Duplicate or trailing path separators `/` are not allowed. The
# path component characters must be in the range `[a-zA-Z0-9+,.=_-]`.
#
# The path must also be validated against
# `CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH`.
##
CLANDRO_REGEX__SAFE_RELATIVE_PATH='^[a-zA-Z0-9+,.=_-]+(/[a-zA-Z0-9+,.=_-]+)*$'

##
# Regex that matches (rootfs `/`) or (a safe absolute path that starts
# with a `/`). Duplicate or trailing path separators `/` are not
# allowed. The path component characters must be in the range
# `[a-zA-Z0-9+,.=_-]`.
#
# The path must also be validated against
# `CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH`.
##
CLANDRO_REGEX__SAFE_ROOTFS_OR_ABSOLUTE_PATH='^((/)|((/[a-zA-Z0-9+,.=_-]+)+))$'


##
# Regex that matches a path containing single `/./` or double `/../` dot components.
##
CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH='((^\./)|(^\.\./)|(/\.$)|(/\.\.$)|(/\./)|(/\.\./))'


##
# Regex that matches invalid Clandro rootfs paths.
#
# The Clandro rootfs or prefix paths must not be equal to or be under
# specific Filesystem Hierarchy Standard paths or paths used by Clandro
# docker image/host OS for its own files, as Clandro packages files
# must be kept separate from the build host. The Clandro app data/prefix
# directories are also wiped by `clean.sh` when not running on-device,
# which wouldn't be possible if Clandro and host directories are shared.
#
# The invalid paths list does not include the `/data` and `/mnt/expand`
# paths under which private app data directories are assigned to
# Android apps, or the `/data/local/tmp` directory assigned to `adb`
# `shell` user, or the `/system` directory for the Android system.
#
# - https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html
# - https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-private-app-data-directory
##
CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS='^((/bin(/.*)?)|(/boot(/.*)?)|(/dev(/.*)?)|(/etc(/.*)?)|(/home)|(/lib(/.*)?)|(/lib[^/]+(/.*)?)|(/media)|(/mnt)|(/opt)|(/proc(/.*)?)|(/root)|(/run(/.*)?)|(/sbin(/.*)?)|(/srv(/.*)?)|(/sys(/.*)?)|(/tmp(/.*)?)|(/usr)|(/usr/local)|(((/usr/)|(/usr/local/))((bin)|(games)|(include)|(lib)|(libexec)|(lib[^/]+)|(sbin)|(share)|(src)|(X11R6))(/.*)?)|(/var(/.*)?)|(/bin.usr-is-merged)|(/lib.usr-is-merged)|(/sbin.usr-is-merged)|(/.dockerinit)|(/.dockerenv))$'

##
# Regex that matches invalid Clandro home paths.
#
# Same reasoning as `CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS`,
# and invalid paths are the same as well except that `/home` is
# allowed, and `/` and all paths under `/usr` are not allowed.
#
# `/home` is allowed as package data files are not packaged from there.
##
CLANDRO_REGEX__INVALID_CLANDRO_HOME_PATHS='^((/)|(/bin(/.*)?)|(/boot(/.*)?)|(/dev(/.*)?)|(/etc(/.*)?)|(/lib(/.*)?)|(/lib[^/]+(/.*)?)|(/media)|(/mnt)|(/opt)|(/proc(/.*)?)|(/root)|(/run(/.*)?)|(/sbin(/.*)?)|(/srv(/.*)?)|(/sys(/.*)?)|(/tmp(/.*)?)|(/usr(/.*)?)|(/var(/.*)?)|(/bin.usr-is-merged)|(/lib.usr-is-merged)|(/sbin.usr-is-merged)|(/.dockerinit)|(/.dockerenv))$'

##
# Regex that matches invalid Clandro prefix paths.
#
# Same reasoning as `CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS`,
# and invalid paths are the same as well except that `/` is not
# allowed.
##
CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS='^((/)|(/bin(/.*)?)|(/boot(/.*)?)|(/dev(/.*)?)|(/etc(/.*)?)|(/home)|(/lib(/.*)?)|(/lib[^/]+(/.*)?)|(/media)|(/mnt)|(/opt)|(/proc(/.*)?)|(/root)|(/run(/.*)?)|(/sbin(/.*)?)|(/srv(/.*)?)|(/sys(/.*)?)|(/tmp(/.*)?)|(/usr)|(/usr/local)|(((/usr/)|(/usr/local/))((bin)|(games)|(include)|(lib)|(libexec)|(lib[^/]+)|(sbin)|(share)|(src)|(X11R6))(/.*)?)|(/var(/.*)?)|(/bin.usr-is-merged)|(/lib.usr-is-merged)|(/sbin.usr-is-merged)|(/.dockerinit)|(/.dockerenv))$'


##
# Regex that matches an unsigned integer `>= 0`.
##
CLANDRO_REGEX__UNSIGNED_INT='^[0-9]+$'


##
# Regex to match an android app package name.
#
# The package name must have at least two segments separated by a dot
# `.`, where each segment must start with at least one character in
# the range `[a-zA-Z]`, followed by zero or more characters in the
# range `[a-zA-Z0-9_]`. The package name length must also be
# `<= 255` (`NAME_MAX` for ext4 partitions). The length is not checked
# by this regex and it must be checked with `CLANDRO__NAME_MAX`, as
# `bash` `=~` regex conditional does not support lookaround.
#
# Unlike Android, the Clandro app package name max length is not `255`
# as its limited by `CLANDRO__APPS_DIR___MAX_LEN` and `CLANDRO__ROOTFS_DIR___MAX_LEN`.
#
# - https://developer.android.com/build/configure-app-module#set-application-id
# - https://cs.android.com/android/platform/superproject/+/android-14.0.0_r1:frameworks/base/core/java/android/content/pm/parsing/ApkLiteParseUtils.java;l=669-677
# - https://cs.android.com/android/platform/superproject/+/android-14.0.0_r1:frameworks/base/core/java/android/content/pm/parsing/FrameworkParsingPackageUtils.java;l=63-103
# - https://cs.android.com/android/platform/superproject/+/android-14.0.0_r1:frameworks/base/core/java/android/os/FileUtils.java;l=954-994
# - https://cs.android.com/android/platform/superproject/+/android-14.0.0_r1:frameworks/base/core/java/android/content/pm/PackageManager.java;l=2147-2155
##
CLANDRO_REGEX__APP_PACKAGE_NAME="^[a-zA-Z][a-zA-Z0-9_]*(\.[a-zA-Z][a-zA-Z0-9_]*)+$"

##
# Regex to match an android app data path.
#
# The supported formats are:
# - `/data/data/<package_name>` (for primary user `0`) if app is to be
#   installed on internal sd.
# - `/data/user/<user_id>/<package_name>` (for all users) if app is to
#   be installed on internal sd.
# `/mnt/expand/<volume_uuid>/user/<user_id>/<package_name>` if app is
#  to be installed on a removable/portable volume/sd card being used as
#  adoptable storage.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-private-app-data-directory
##
CLANDRO_REGEX__APP_DATA_DIR_PATH='^(((/data/data)|(/data/user/[0-9]+)|(/mnt/expand/[^/]+/user/[0-9]+))/[^/]+)$'





###
# Variables for the Clandro build tools.
###

##
# The path to the `clandro-packages` repo root directory.
##
CLANDRO_PKGS__BUILD__REPO_ROOT_DIR="${CLANDRO_PKGS__BUILD__REPO_ROOT_DIR:-}"

__clandro_build_props__set_clandro_builder__repo_root_dir() {

    local relative_path="${1:-}"
    local return_value=0
    if [[ -z "${CLANDRO_PKGS__BUILD__REPO_ROOT_DIR:-}" ]]; then
        if [[ "$(readlink --help 2>&1 || true)" =~ [\ ]-f[,\ ] ]]; then
            CLANDRO_PKGS__BUILD__REPO_ROOT_DIR="$(file="$(readlink -f -- "${BASH_SOURCE[0]}")" && \
                parent="$(dirname -- "$file")" && \
                readlink -f -- "${parent}${relative_path}")" || return_value=$?
        else
            CLANDRO_PKGS__BUILD__REPO_ROOT_DIR="$(pwd)" || return_value=$? # macOS `< 12.3` compatibility.
        fi
    fi
    if [ $return_value -ne 0 ] || [[ ! "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR" =~ ^(/[a-zA-Z0-9+,.=_-]+)+$ ]] || \
            [[ ! -f "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/scripts/properties.sh" ]]; then
        echo "The CLANDRO_PKGS__BUILD__REPO_ROOT_DIR '$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR' not found or is not valid." 1>&2
        return 1;
    fi

}
__clandro_build_props__set_clandro_builder__repo_root_dir "/.." || exit $?
unset __clandro_build_props__set_clandro_builder__repo_root_dir
CLANDRO_SCRIPTDIR="${CLANDRO_SCRIPTDIR:-CLANDRO_PKGS__BUILD__REPO_ROOT_DIR}" # Deprecated alternative variable for `CLANDRO_PKGS__BUILD__REPO_ROOT_DIR`



CLANDRO_SDK_REVISION=9123335
CLANDRO_ANDROID_BUILD_TOOLS_VERSION=33.0.1
# when changing the above:
# change CLANDRO_PKG_VERSION (and remove CLANDRO_PKG_REVISION if necessary) in:
#   apksigner, d8
# and trigger rebuild of them
: "${CLANDRO_NDK_VERSION_NUM:="29"}"
: "${CLANDRO_NDK_REVISION:=""}"
CLANDRO_NDK_VERSION="${CLANDRO_NDK_VERSION_NUM}${CLANDRO_NDK_REVISION}"
# when changing the above:
# update version and hashsum in packages
#   libandroid-stub, libc++, ndk-multilib, ndk-sysroot, vulkan-loader-android
# and update SHA256 sums in scripts/setup-android-sdk.sh
# check all packages build and run correctly and bump if needed

: "${CLANDRO_HOST_LLVM_MAJOR_VERSION:="20"}"
: "${CLANDRO_HOST_LLVM_BASE_DIR:="/usr/lib/llvm-${CLANDRO_HOST_LLVM_MAJOR_VERSION}"}"

: "${CLANDRO_JAVA_HOME:=/usr/lib/jvm/java-17-openjdk-amd64}"
export JAVA_HOME="${CLANDRO_JAVA_HOME}"

if [[ "${CLANDRO_PACKAGES_OFFLINE-false}" == "true" ]]; then
    export ANDROID_HOME="${CLANDRO_PKGS__BUILD__REPO_ROOT_DIR}/build-tools/android-sdk-${CLANDRO_SDK_REVISION}"
    export NDK="${CLANDRO_PKGS__BUILD__REPO_ROOT_DIR}/build-tools/android-ndk-r${CLANDRO_NDK_VERSION}"
else
    : "${ANDROID_HOME:="${HOME}/lib/android-sdk-$CLANDRO_SDK_REVISION"}"
    : "${NDK:="${HOME}/lib/android-ndk-r${CLANDRO_NDK_VERSION}"}"
fi



###
# Variables for the Clandro apps and packages for which to compile packages.
#
# Variables defined in this file need to be in sync with `clandro-app`
# (`TermuxConstants` and `TermuxCoreConstants`), termux site and `clandro-exec`.
# - https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/clandro/shared/clandro/TermuxConstants.java
# - https://github.com/termux/termux-app/blob/master/termux-shared/src/main/java/com/clandro/shared/clandro/core/TermuxCoreConstants.java
#
# Following is a list of `CLANDRO_` variables that are safe to modify when forking.
# **DO NOT MODIFY ANY OTHER VARIABLE UNLESS YOU KNOW WHAT YOU ARE DOING.**
#
# - `CLANDRO__NAME`, `CLANDRO__LNAME` and `CLANDRO__UNAME`.
# - `CLANDRO__REPOS_HOST_ORG_NAME` and `CLANDRO__REPOS_HOST_ORG_URL`.
# - `CLANDRO_*__REPO_NAME` and `CLANDRO_*__REPO_URL`.
# - `CLANDRO_APP__PACKAGE_NAME`.
# - `CLANDRO_APP__DATA_DIR`.
# - `CLANDRO__PROJECT_SUBDIR`.
# - `CLANDRO__ROOTFS_SUBDIR`.
# - `CLANDRO__ROOTFS` and alternates.
# - `CLANDRO__PREFIX` and alternates.
# - `CLANDRO_ANDROID_HOME` and alternates.
# - `CLANDRO_APP__NAME` and `CLANDRO_APP__LNAME`.
# - `CLANDRO_APP__APP_IDENTIFIER`.
# - `CLANDRO_APP__NAMESPACE`.
# - `CLANDRO_APP__SHELL_API__SHELL_API_ACTIVITY__*`.
# - `CLANDRO_APP__SHELL_API__SHELL_API_SERVICE__*`.
# - `CLANDRO_APP__RUN_COMMAND_API__RUN_COMMAND_API_SERVICE__*`.
# - `CLANDRO_APP__DATA_SENDER_API__DATA_SENDER_API_RECEIVER__*`.
# - `CLANDRO_API_APP__PACKAGE_NAME`.
# - `CLANDRO_API_APP__NAME`.
# - `CLANDRO_API_APP__APP_IDENTIFIER`.
# - `CLANDRO_API_APP__NAMESPACE`.
# - `CLANDRO_API_APP__ANDROID_API__ANDROID_API_RECEIVER__*`.
# - `CLANDRO_AM_APP__NAMESPACE`.
###

##
# Clandro project name.
#
# Default value: `Clandro`
##
CLANDRO__NAME="Clandro"

##
# The lower case value for `CLANDRO__NAME`.
#
# Default value: `termux`
##
CLANDRO__LNAME="${CLANDRO__NAME,,}"

##
# The upper case value for `CLANDRO__NAME`.
#
# Default value: `TERMUX`
##
CLANDRO__UNAME="${CLANDRO__NAME^^}"



##
# Clandro internal project name.
#
# This is used internally for paths, filenames, and other internal use
# cases and must match the `CLANDRO__INTERNAL_NAME_REGEX` regex and
# have max length `CLANDRO__INTERNAL_NAME___MAX_LEN`.
#
# **This must not be changed unless doing a full fork of Clandro where
# all Clandro references are changed instead of just changing the
# `CLANDRO__NAME`, `CLANDRO_APP__PACKAGE_NAME` and urls.**
#
# Default value: `termux`
##
CLANDRO__INTERNAL_NAME="clandro"

##
# The regex to validate `CLANDRO__INTERNAL_NAME`.
#
# The internal name must start with characters in the range
# `[a-z0-9]`, followed by at least one character in the range
# `[a-z0-9_-]`, and end with characters in the range `[a-z0-9]`. The
# min length is `3`. The max length `7` as per
# `CLANDRO__INTERNAL_NAME___MAX_LEN` is not checked by this regex and
# must be checked separately.
#
#
# Constant value: `^[a-z0-9][a-z0-9_-]+[a-z0-9]$`
##
CLANDRO__INTERNAL_NAME_REGEX="^[a-z0-9][a-z0-9_-]+[a-z0-9]$"

##
# The max length for the `CLANDRO__INTERNAL_NAME`.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `7` is chosen.
#
# Constant value: `7`
##
CLANDRO__INTERNAL_NAME___MAX_LEN=7



##
# Clandro repositories host organization name.
#
# Default value: `termux`
##
CLANDRO__REPOS_HOST_ORG_NAME="clandro"

##
# Clandro repositories host organization url.
#
# Default value: `https://github.com/termux`
##
CLANDRO__REPOS_HOST_ORG_URL="https://github.com/$CLANDRO__REPOS_HOST_ORG_NAME"



##
# Clandro app package name used for `CLANDRO_APP__DATA_DIR` and
# `CLANDRO_APP__*_(ACTIVITY|RECEIVER|SERVICE)__*` variables.
#
# Ideally package name should be `<= 21` characters and max `33`
# characters. If package name has not yet been chosen, then it would
# be best to keep it to `<= 10` characters. Check
# https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why.
#
# **See Also:**
# - `CLANDRO_APP__NAMESPACE`.
# - https://developer.android.com/build/configure-app-module#set-application-id
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-private-app-data-directory
#
# Default value: `com.zk.clandro`
##
CLANDRO_APP__PACKAGE_NAME="com.zk.clandro"
CLANDRO_APP_PACKAGE="$CLANDRO_APP__PACKAGE_NAME" # Deprecated alternative variable for `CLANDRO_APP__PACKAGE_NAME`

__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__PACKAGE_NAME" "app_package_name"

##
# Clandro app data directory path that is expected to be assigned by
# Android to the Clandro app with `CLANDRO_APP__PACKAGE_NAME` for all
# its app data, that will contain the Clandro project directory
# (`CLANDRO__PROJECT_DIR`), and optionally the Clandro rootfs directory
# (`CLANDRO__ROOTFS`).
#
# The path must match `CLANDRO_REGEX__APP_DATA_DIR_PATH`.
#
# The directory set will be deleted by `clean.sh` if `CLANDRO__PREFIX`
# is under `CLANDRO_APP__DATA_DIR` and not running on-device, so make
# sure a safe path is set if running `clean.sh` in Clandro docker or
# host OS build environment.
#
# Default value: `/data/data/com.zk.clandro`
##
CLANDRO_APP__DATA_DIR="/data/data/$CLANDRO_APP__PACKAGE_NAME"
__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__DATA_DIR" "safe_absolute_path"

##
# The max length for the `CLANDRO_APP__DATA_DIR` including the null '\0'
# terminator.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `69` is chosen.
#
# Constant value: `69`
##
CLANDRO_APP__DATA_DIR___MAX_LEN=69





##
# Clandro subdirectory path for `CLANDRO__PROJECT_DIR`.
#
# Default value: `termux`
##
CLANDRO__PROJECT_SUBDIR="$CLANDRO__INTERNAL_NAME"
__clandro_build_props__add_variables_validator_actions "CLANDRO__PROJECT_SUBDIR" "safe_relative_path"

##
# Clandro project directory path under `CLANDRO_APP__DATA_DIR`.
#
# This is an exclusive directory for all Clandro files that includes
# Clandro core directory (`CLANDRO__CORE_DIR`), Clandro apps directory
# (`CLANDRO__APPS_DIR`), and optionally the Clandro rootfs directory
# (`CLANDRO__ROOTFS`).
#
# Currently, the default Clandro rootfs directory is not under it and
# is at the `/files`  subdirectory but there are plans to move it to
# `termux/rootfs/II` in future where `II` refers to rootfs id starting
# at `0` for multi-rootfs support.
#
# An exclusive directory is required so that all Clandro files exist
# under a single directory, especially for when Clandro is provided as
# a library, so that Clandro files do not interfere with other files
# of Clandro app forks or apps that may use the Clandro library.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-project-directory
#
# Default value: `/data/data/com.zk.clandro/termux`
##
CLANDRO__PROJECT_DIR="$CLANDRO_APP__DATA_DIR/$CLANDRO__PROJECT_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__PROJECT_DIR" "safe_absolute_path"





##
# Clandro subdirectory path for `CLANDRO__CORE_DIR`.
#
# Constant value: `core`
##
CLANDRO__CORE_SUBDIR="core"

##
# Clandro core directory path under `CLANDRO__PROJECT_DIR`.
#
# This contains Clandro core files for the Clandro app, like user settings and configs for the app,
# which and are independent of any specific rootfs.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#clandro-core-directory
#
# Default value: `/data/data/com.zk.clandro/clandro/core`
##
CLANDRO__CORE_DIR="$CLANDRO__PROJECT_DIR/$CLANDRO__CORE_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__CORE_DIR" "safe_absolute_path"






##
# Clandro subdirectory path for `CLANDRO__APPS_DIR`.
#
# Constant value: `app`
##
CLANDRO__APPS_SUBDIR="app"

##
# Clandro apps directory path under `CLANDRO__PROJECT_DIR`.
#
# This contains app specific files for the Clandro app, its plugin
# apps, and third party apps, like used for app APIs and
# filesystem/pathname socket files of servers created by the apps.
# - https://man7.org/linux/man-pages/man7/unix.7.html
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-apps-directory
#
# Default value: `/data/data/com.zk.clandro/clandro/app`
##
CLANDRO__APPS_DIR="$CLANDRO__PROJECT_DIR/$CLANDRO__APPS_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__APPS_DIR" "safe_absolute_path"

##
# The max length for the `CLANDRO__APPS_DIR` including the null '\0'
# terminator.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `84` is chosen.
#
# Constant value: `84`
##
CLANDRO__APPS_DIR___MAX_LEN=84

##
# The max length for the Clandro apps api socket server parent directory
# including the null '\0' terminator.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `98` is chosen.
#
# Constant value: `98`
##
CLANDRO__APPS_API_SOCKET__SERVER_PARENT_DIR___MAX_LEN=98



##
# Clandro subdirectory path for `CLANDRO__APPS_DIR_BY_IDENTIFIER`.
#
# Constant value: `i`
##
CLANDRO__APPS_DIR_BY_IDENTIFIER_SUBDIR="i"

##
# Clandro apps directory path by app identifier under `CLANDRO__APPS_DIR`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/i`
##
CLANDRO__APPS_DIR_BY_IDENTIFIER="$CLANDRO__APPS_DIR/$CLANDRO__APPS_DIR_BY_IDENTIFIER_SUBDIR"

##
# The regex to validate a subdirectory name under the
# `CLANDRO__APPS_DIR_BY_IDENTIFIER` excluding the null '\0' terminator
# that represents an app identifier.
#
# The app identifier must only contain characters in the range
# `[a-zA-Z0-9]` as segments, with `[._-]` as separators between
# segments, and with the first segment containing at least `3`
# characters. The max length `10` as per
# `CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN` is not checked by this regex
# and must be checked separately.
#
# Constant value: `^[a-zA-Z0-9]{3,}([._-][a-zA-Z0-9]+)*$`
##
CLANDRO__APPS_APP_IDENTIFIER_REGEX="^[a-zA-Z0-9]{3,}([._-][a-zA-Z0-9]+)*$"

##
# The max length for a subdirectory name under the
# `CLANDRO__APPS_DIR_BY_IDENTIFIER` excluding the null '\0' terminator
# that represents an app identifier.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `10` is chosen.
#
# Constant value: `10`
##
CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN=10





##
# Clandro subdirectory path for `CLANDRO__APPS_DIR_BY_UID`.
#
# Constant value: `u`
##
CLANDRO__APPS_DIR_BY_UID_SUBDIR="u"

##
# Clandro apps directory path by app uid (user_id + app_id) under
# `CLANDRO__APPS_DIR`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/u`
##
CLANDRO__APPS_DIR_BY_UID="$CLANDRO__APPS_DIR/$CLANDRO__APPS_DIR_BY_UID_SUBDIR"

##
# The regex to validate a  subdirectory name under the
# `CLANDRO__APPS_DIR_BY_UID` excluding the null '\0' terminator that
# represents an app uid.
#
# The app uid must only contains `5` to `9` characters that are
# numbers and must not start with a `0`.
#
# Constant value: `^[1-9][0-9]{4,8}$`
##
CLANDRO__APPS_APP_UID_REGEX="^[1-9][0-9]{4,8}$"

##
# The max length for a subdirectory name under the
# `CLANDRO__APPS_DIR_BY_UID` excluding the null '\0' terminator that
# represents an app uid.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `9` is chosen.
#
# Constant value: `9`
##
CLANDRO__APPS_APP_UID___MAX_LEN=9





##
# Clandro apps info environment subfile path under an app directory of
# `CLANDRO__APPS_DIR_BY_IDENTIFIER`.
#
# Default value: `clandro-apps-info.env`
##
CLANDRO_CORE__APPS_INFO_ENV_SUBFILE="$CLANDRO__INTERNAL_NAME-apps-info.env"

##
# Clandro apps info json subfile path under an app directory of
# `CLANDRO__APPS_DIR_BY_IDENTIFIER`.
#
# Default value: `clandro-apps-info.json`
##
CLANDRO_CORE__APPS_INFO_JSON_SUBFILE="$CLANDRO__INTERNAL_NAME-apps-info.json"



##
# `clandro-am-socket` server subfile path under an app directory of
# `CLANDRO__APPS_DIR_BY_IDENTIFIER`.
#
# Default value: `termux-am`
##
CLANDRO_AM_SOCKET__SERVER_SOCKET_SUBFILE="$CLANDRO__INTERNAL_NAME-am"





##
# Clandro `CLANDRO__ROOTFS` id.
#
# Default value: `0`
##
CLANDRO__ROOTFS_ID="0"
__clandro_build_props__add_variables_validator_actions "CLANDRO__ROOTFS_ID" "unsigned_int"

##
# Clandro subdirectory path for `CLANDRO__ROOTFS`.
#
# Default value: `files`
##
CLANDRO__ROOTFS_SUBDIR="files"
__clandro_build_props__add_variables_validator_actions "CLANDRO__ROOTFS_SUBDIR" "allow_unset_value safe_relative_path"

###########
# Uncomment if to place `CLANDRO__ROOTFS`  under `CLANDRO__PROJECT_DIR`
# instead of at `files`. This may be used for future multi-rootfs
# design. Make sure to update `CLANDRO__CACHE_SUBDIR` above as well.

##
# Clandro subdirectory path for parent directory of all Clandro rootfses
# including `CLANDRO__ROOTFS`.
#
# Default value: `termux/rootfs`
##
#CLANDRO__ROOTFSES_SUBDIR="$CLANDRO__PROJECT_SUBDIR/rootfs"
###########

##
# Clandro subdirectory path for `CLANDRO__ROOTFS`.
#
# Default value: `termux/rootfs/0`
##
#CLANDRO__ROOTFS_SUBDIR="$CLANDRO__ROOTFSES_SUBDIR/$CLANDRO__ROOTFS_ID"
###########


##
# Clandro rootfs directory path under `CLANDRO_APP__DATA_DIR` that
# contains the Linux environment rootfs provided by Clandro.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-rootfs-directory
# - https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03.html
#
# The Clandro rootfs must not be set to path in
# `CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS`. It can exist outside
# the `CLANDRO_APP__DATA_DIR` if compiling packages for the Android
# system or `adb` `shell` user.
#
# Default value: `/data/data/com.zk.clandro/files`
##
CLANDRO__ROOTFS="$CLANDRO_APP__DATA_DIR/$CLANDRO__ROOTFS_SUBDIR"
CLANDRO_BASE_DIR="$CLANDRO__ROOTFS" # Deprecated alternative variable for `CLANDRO__ROOTFS`

__clandro_build_props__add_variables_validator_actions "CLANDRO__ROOTFS" "safe_rootfs_or_absolute_path invalid_clandro_rootfs_paths"

# FIXME: Remove after updating Clandro app and `clandro-am-socket`
# package sources and use `CLANDRO__APPS_DIR`.
CLANDRO_APPS_DIR="$CLANDRO__ROOTFS/apps"

##
# The max length for the `CLANDRO__ROOTFS` including the null '\0'
# terminator.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `86` is chosen.
#
# Constant value: `86`
##
CLANDRO__ROOTFS_DIR___MAX_LEN=86





####
# Variables for the Clandro home.
####

##
# Clandro subdirectory path for `CLANDRO__HOME`.
#
# Default value: `home`
##
CLANDRO__HOME_SUBDIR="home"
__clandro_build_props__add_variables_validator_actions "CLANDRO__HOME_SUBDIR" "safe_relative_path"

##
# Clandro home directory path under `CLANDRO__ROOTFS` used for `$HOME`.
#
# It serves the same purpose as the `/home` directory on Linux distros.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-home-directory
# - https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s08.html
#
# Check `CLANDRO__PREFIX` variable docs for rules that apply depending
# on if `CLANDRO__ROOTFS` is equal to Android/Linux rootfs `/` or not.
# The Clandro home must not be set to Android/Linux rootfs `/` or any
# other path in `CLANDRO_REGEX__INVALID_CLANDRO_HOME_PATHS`.
#
# Default value: `/data/data/com.zk.clandro/files/home`
##
[[ "$CLANDRO__ROOTFS" != "/" ]] && CLANDRO__HOME="$CLANDRO__ROOTFS/$CLANDRO__HOME_SUBDIR" || \
    CLANDRO__HOME="/$CLANDRO__HOME_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__HOME" "safe_absolute_path invalid_clandro_home_paths path_under_clandro_rootfs"

CLANDRO_ANDROID_HOME="$CLANDRO__HOME" # Deprecated alternative variable for `CLANDRO__HOME`

##
# Clandro legacy project user config directory path under `CLANDRO__HOME`.
#
# Default value: `/data/data/com.zk.clandro/files/home/.cl-andro`
##
CLANDRO__LEGACY_PROJECT_USER_CONFIG_DIR="$CLANDRO__HOME/.cl-andro"





####
# Variables for the Clandro prefix.
####

##
# Clandro subdirectory path for `CLANDRO__PREFIX`.
#
# Default value: `usr`
##
CLANDRO__PREFIX_SUBDIR="usr"
__clandro_build_props__add_variables_validator_actions "CLANDRO__PREFIX_SUBDIR" "allow_unset_value safe_relative_path"

##
# Clandro prefix directory path under or equal to `CLANDRO__ROOTFS`
# where all Clandro packages data is installed.
#
# It serves the same purpose as the `/usr` directory on Linux distros
# and contains the `bin`, `etc`, `include`, `lib`, `libexec`, `opt`,
# `share`, `tmp` and `var` sub directories.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-prefix-directory
# - https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04.html
#
# If `CLANDRO__ROOTFS` is not equal to `/`, then by default Clandro
# uses `usr` merge format, like used by `debian`, as per
# `__CLANDRO_BUILD_PROPS__VALIDATE_CLANDRO_PREFIX_USR_MERGE_FORMAT`
# being enabled by default. In the `usr` merge format, all packages
# are installed under the `usr` subdirectory under rootfs, like under
# `$CLANDRO__ROOTFS/usr/bin` and `$CLANDRO__ROOTFS/usr/lib`,
# instead of under `$CLANDRO__ROOTFS/bin` and `$CLANDRO__ROOTFS/lib`.
# So if `usr` merge format is enabled, then DO NOT change the default
# value of `CLANDRO__PREFIX_SUBDIR` from `usr`.
# The `$CLANDRO__ROOTFS/usr-staging` directory is also used as a
# temporary directory for extracting bootstrap zip by the Clandro app,
# before its renamed to `$CLANDRO__ROOTFS/usr`.
# Additionally, `CLANDRO__PREFIX` must not be equal to `CLANDRO__HOME`
# and they must not be under each other, as Clandro app requires that
# prefix and home are separate directories as prefix gets wiped during
# bootstrap installation or if `termux-reset` is run, and backup
# scripts require the same. Package data also needs to be kept
# separate from `home`, so it does not make sense for them to be
# equal to or be under each other.
# However, if a Clandro app fork is using a modified bootstrap
# installation that does not use the `usr` merge format, then
# `__CLANDRO_BUILD_PROPS__VALIDATE_CLANDRO_PREFIX_USR_MERGE_FORMAT` can
# be set to `false` and `CLANDRO__PREFIX_SUBDIR` could optionally be
# set to an empty string if `CLANDRO__ROOTFS` should be equal to
# `CLANDRO__PREFIX`, or a custom directory other than `usr`. In this
# case `CLANDRO__HOME` can optionally be under `CLANDRO__PREFIX`, but
# not be equal to it.
#
# - https://wiki.debian.org/UsrMerge
# - https://lists.debian.org/debian-devel-announce/2019/03/msg00001.html
# - https://dep-team.pages.debian.net/deps/dep17/
#
# If `CLANDRO__ROOTFS` is equal to Android/Linux rootfs `/`, then
# `CLANDRO__PREFIX_SUBDIR` must not be set to an empty string as
# `CLANDRO__PREFIX` must be a subdirectory under rootfs `/`, and must
# not be set to `usr` either or or any other path in
# `CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS`. Check the
# `CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS` variable docs for why
# some paths like `/usr`, etc are now allowed.
#
# Basically, the following rules apply for `CLANDRO__PREFIX`.
# - If `CLANDRO__ROOTFS` is not equal to `/`:
#     - If `usr` merge format is enabled:
#         - `CLANDRO__PREFIX` must be equal to `$CLANDRO__ROOTFS/usr`.
#         - `CLANDRO__PREFIX` must not be equal to `CLANDRO__HOME` and
#            they must not be under each other.
#     - If `usr` merge format is disabled:
#         - `CLANDRO__PREFIX` must be equal to or be under `$CLANDRO__ROOTFS`.
#         - `CLANDRO__PREFIX` must not be equal to or be under `CLANDRO__HOME`.
# - If `CLANDRO__ROOTFS` is equal to `/`:
#     - If `usr` merge format is enabled or disabled:
#         - `CLANDRO__PREFIX` must be under `$CLANDRO__ROOTFS` and not
#           equal to `/usr` or other paths in `CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS`.
#         - `CLANDRO__PREFIX` must not be equal to or be under `CLANDRO__HOME`.
#
# The directory set will be deleted by `clean.sh` if not running
# on-device, so make sure a safe path is set if running `clean.sh` in
# Clandro docker or host OS build environment.
#
# At runtime, `CLANDRO__PREFIX` may be overridden and set to
# `CLANDRO__PREFIX_GLIBC` when compiling `glibc` packages by calling
# `clandro_build_props__set_clandro_prefix_dir_and_sub_variables` in
# `clandro_step_setup_variables` if `CLANDRO_PACKAGE_LIBRARY` equals `glibc`.
# However, `CLANDRO__PREFIX_CLASSICAL` retains the original value
# set below for `CLANDRO__PREFIX`.
# - https://github.com/termux/termux-packages/pull/16901
# - https://github.com/termux/termux-packages/pull/20864
#
# Default value: `/data/data/com.zk.clandro/files/usr`
##
[[ "$CLANDRO__ROOTFS" != "/" ]] && CLANDRO__PREFIX="$CLANDRO__ROOTFS${CLANDRO__PREFIX_SUBDIR:+"/$CLANDRO__PREFIX_SUBDIR"}" || \
    CLANDRO__PREFIX="/$CLANDRO__PREFIX_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__PREFIX" "safe_absolute_path invalid_clandro_prefix_paths"

if [[ "$CLANDRO__ROOTFS" != "/" ]] && [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_CLANDRO_PREFIX_USR_MERGE_FORMAT" != "true" ]]; then
    __clandro_build_props__add_variables_validator_actions "CLANDRO__PREFIX" " path_equal_to_or_under_clandro_rootfs"
else
    __clandro_build_props__add_variables_validator_actions "CLANDRO__PREFIX" " path_under_clandro_rootfs"
fi

CLANDRO_PREFIX="$CLANDRO__PREFIX" # Deprecated alternative variable for `CLANDRO__PREFIX`



##
# The original value for `CLANDRO__PREFIX` set above, as `CLANDRO__PREFIX`
# can be overridden at runtime, like when compiling `glibc` packages.
# Checks variable docs of `CLANDRO__PREFIX` for more info.
#
# Default value: `/data/data/com.zk.clandro/files/usr`
##
CLANDRO__PREFIX_CLASSICAL="$CLANDRO__PREFIX"
CLANDRO_PREFIX_CLASSICAL="$CLANDRO__PREFIX" # Deprecated alternative variable for `CLANDRO__PREFIX_CLASSICAL`



##
# Clandro subdirectory path for `CLANDRO__PREFIX_GLIBC`.
#
# Default value: `glibc`
##
CLANDRO__PREFIX_GLIBC_SUBDIR="glibc"

##
# Clandro `glibc` prefix directory path under `CLANDRO__PREFIX`
# where all Clandro `glibc` packages data is installed.
#
# **See Also:**
# - https://github.com/termux-pacman/glibc-packages
# - https://github.com/termux/glibc-packages (mirror)
#
# Default value: `/data/data/com.zk.clandro/files/usr/glibc`
##
CLANDRO__PREFIX_GLIBC="$CLANDRO__PREFIX/$CLANDRO__PREFIX_GLIBC_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__PREFIX_GLIBC" "safe_absolute_path invalid_clandro_prefix_paths path_under_clandro_rootfs"



##
# The max length for the `CLANDRO__PREFIX` including the null '\0'
# terminator.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `90` is chosen.
#
# Constant value: `90`
##
CLANDRO__PREFIX_DIR___MAX_LEN="$((CLANDRO__ROOTFS_DIR___MAX_LEN + 1 + 3))" # "/usr" (90)


##
# The max length for the `CLANDRO__BIN_DIR` including the null '\0' terminator.
#
# Constant value: `94`
##
CLANDRO__PREFIX__BIN_DIR___MAX_LEN="$((CLANDRO__PREFIX_DIR___MAX_LEN + 1 + 3))" # "/bin" (94)

##
# The max safe length for a sub file path under the `CLANDRO__BIN_DIR`
# including the null '\0' terminator.
#
# This allows for a filename with max length `33` so that the path
# length is under `128` (`BINPRM_BUF_SIZE`) for Linux kernel `< 5.1`,
# and ensures `argv[0]` length is `< 128` on Android `< 6`, otherwise
# commands will fail with exit code 1 without any error on `stderr`,
# but with the `library name "<library_name>" too long` error in
# `logcat` if linker debugging is enabled.
#
# **See Also:**
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# - https://github.com/cl-andro/clandro-core-package/blob/master/lib/clandro-core_nos_c/tre/include/clandro/clandro_core__nos__c/v1/clandro/file/TermuxFile.h
# - https://github.com/cl-andro/clandro-exec-package/blob/master/lib/clandro-exec_nos_c/tre/include/clandro/clandro_exec__nos__c/v1/clandro/api/clandro_exec/service/ld_preload/direct/exec/ExecIntercept.h
#
# Constant value: `127`
##
CLANDRO__PREFIX__BIN_FILE___SAFE_MAX_LEN="$((CLANDRO__PREFIX__BIN_DIR___MAX_LEN + 1 + 33))" # "/<filename_with_len_33>" (127)

##
# The max length for entire shebang line for `clandro-exec`.
#
# **See Also:**
# - https://github.com/cl-andro/clandro-exec-package/blob/master/lib/clandro-exec_nos_c/tre/include/clandro/clandro_exec__nos__c/v1/clandro/api/clandro_exec/service/ld_preload/direct/exec/ExecIntercept.h
#
# Default value: `340`
##
CLANDRO__FILE_HEADER__BUFFER_SIZE="340"




##
# `clandro_build_props__set_clandro_prefix_dir_and_sub_variables` `<clandro__prefix>` [`<skip_validation>`]
##
clandro_build_props__set_clandro_prefix_dir_and_sub_variables() {

local clandro__prefix="${1:-}"
local skip_validation="${2:-}"

if [[ "$skip_validation" != "true" ]]; then
    if [[ ! "$clandro__prefix" =~ ${CLANDRO_REGEX__SAFE_ABSOLUTE_PATH:?} ]] || \
            [[ "$clandro__prefix" =~ ${CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH:?} ]]; then
        echo "The clandro__prefix '$clandro__prefix' passed to 'clandro_build_props__set_clandro_prefix_dir_and_sub_variables' with length ${#clandro__prefix} is invalid." 1>&2
        echo "The clandro__prefix must match a safe absolute path that starts with a \`/\` with at least one \
characters under rootfs \`/\`. Duplicate or trailing path separators \`/\` are not allowed. \
The path component characters must be in the range \`[a-zA-Z0-9+,.=_-]\`. The path must not contain single \`/./\` or \
double \`/../\` dot components." 1>&2
        return 1
    fi

    if [[ "$clandro__prefix" =~ ${CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS:?} ]]; then
        echo "The clandro__prefix '$clandro__prefix' passed to 'clandro_build_props__set_clandro_prefix_dir_and_sub_variables' with length ${#clandro__prefix} is invalid." 1>&2
        echo "The clandro__prefix must not match one of the invalid paths \
in CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS \`$CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS\`." 1>&2
        return 1
    fi
fi


# Override `CLANDRO__PREFIX`, but keep original value in `CLANDRO__PREFIX_CLASSICAL`.
CLANDRO__PREFIX="$clandro__prefix"
CLANDRO_PREFIX="$clandro__prefix"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__BIN_DIR`.
#
# Constant value: `bin`
##
CLANDRO__PREFIX__BIN_SUBDIR="bin"

##
# Clandro bin directory path under `CLANDRO__PREFIX`.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-bin-directory
#
# Default value: `/data/data/com.zk.clandro/files/usr/bin`
##
CLANDRO__PREFIX__BIN_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__BIN_SUBDIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__ETC_DIR`.
#
# Constant value: `etc`
##
CLANDRO__PREFIX__ETC_SUBDIR="etc"

##
# Clandro etc directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/etc`
##
CLANDRO__PREFIX__ETC_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__ETC_SUBDIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__BASE_INCLUDE_DIR`.
#
# Constant value: `include`
##
CLANDRO__PREFIX__BASE_INCLUDE_SUBDIR="include"

##
# Clandro base include directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/include`
##
CLANDRO__PREFIX__BASE_INCLUDE_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__BASE_INCLUDE_SUBDIR"


##
# Clandro subdirectory path for `CLANDRO__PREFIX__MULTI_INCLUDE_DIR`.
#
# Constant value: `include32`
##
CLANDRO__PREFIX__MULTI_INCLUDE_SUBDIR="include32"

##
# Clandro multi include directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/include32`
##
CLANDRO__PREFIX__MULTI_INCLUDE_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__MULTI_INCLUDE_SUBDIR"


##
# Clandro include subdirectory path under `CLANDRO__PREFIX`.
#
# Default value: `include`
##
CLANDRO__PREFIX__INCLUDE_SUBDIR="$CLANDRO__PREFIX__BASE_INCLUDE_SUBDIR"

##
# Clandro include directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/include` (`$CLANDRO__PREFIX__BASE_INCLUDE_DIR`)
##
CLANDRO__PREFIX__INCLUDE_DIR="$CLANDRO__PREFIX__BASE_INCLUDE_DIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__BASE_LIB_DIR`.
#
# Constant value: `lib`
##
CLANDRO__PREFIX__BASE_LIB_SUBDIR="lib"

##
# Clandro base lib directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/lib`
##
CLANDRO__PREFIX__BASE_LIB_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__BASE_LIB_SUBDIR"


##
# Clandro subdirectory path for `CLANDRO__PREFIX__MULTI_LIB_DIR`.
#
# Constant value: `lib32`
##
CLANDRO__PREFIX__MULTI_LIB_SUBDIR="lib32"

##
# Clandro multi lib directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/lib32`
##
CLANDRO__PREFIX__MULTI_LIB_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__MULTI_LIB_SUBDIR"


##
# Clandro lib subdirectory path under `CLANDRO__PREFIX`.
#
# Default value: `lib`
##
CLANDRO__PREFIX__LIB_SUBDIR="$CLANDRO__PREFIX__BASE_LIB_SUBDIR"

##
# Clandro lib directory path under `CLANDRO__PREFIX`.
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-lib-directory
#
# Default value: `/data/data/com.zk.clandro/files/usr/lib` (`$CLANDRO__PREFIX__BASE_LIB_DIR`)
##
CLANDRO__PREFIX__LIB_DIR="$CLANDRO__PREFIX__BASE_LIB_DIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__LIBEXEC_DIR`.
#
# Constant value: `libexec`
##
CLANDRO__PREFIX__LIBEXEC_SUBDIR="libexec"

##
# Clandro libexec directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/libexec`
##
CLANDRO__PREFIX__LIBEXEC_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__LIBEXEC_SUBDIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__OPT_DIR`.
#
# Constant value: `opt`
##
CLANDRO__PREFIX__OPT_SUBDIR="opt"

##
# Clandro opt directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/opt`
##
CLANDRO__PREFIX__OPT_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__OPT_SUBDIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__SHARE_DIR`.
#
# Constant value: `share`
##
CLANDRO__PREFIX__SHARE_SUBDIR="share"

##
# Clandro share directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/share`
##
CLANDRO__PREFIX__SHARE_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__SHARE_SUBDIR"



##
# Clandro subdirectory path for `CLANDRO__PREFIX__VAR_DIR`.
#
# Constant value: `var`
##
CLANDRO__PREFIX__VAR_SUBDIR="var"

##
# Clandro var directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/var`
##
CLANDRO__PREFIX__VAR_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__VAR_SUBDIR"

}

# Set Clandro prefix sub variables to be under the original value of
# `CLANDRO__PREFIX` set in `CLANDRO__PREFIX_CLASSICAL` by default,
# which is set earlier in this file.
# Skip validation as it will be done below by `__clandro_build_props__validate_variables`.
clandro_build_props__set_clandro_prefix_dir_and_sub_variables "$CLANDRO__PREFIX" "true" || exit $?





# The following variables must always be under the original value of
# `CLANDRO__PREFIX` set in `CLANDRO__PREFIX_CLASSICAL` by default.

##
# Clandro subdirectory path for `CLANDRO__PREFIX__TMP_DIR`.
#
# Constant value: `tmp`
##
CLANDRO__PREFIX__TMP_SUBDIR="tmp"

##
# Clandro tmp directory path under `CLANDRO__PREFIX`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/tmp`
##
CLANDRO__PREFIX__TMP_DIR="$CLANDRO__PREFIX/$CLANDRO__PREFIX__TMP_SUBDIR"

##
# The max length for the `CLANDRO__PREFIX__TMP_DIR` including the null
# '\0' terminator.
#
# Check https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#file-path-limits
# for why the value `94` is chosen.
#
# Constant value: `94`
##
CLANDRO__PREFIX__TMP_DIR___MAX_LEN=94



##
# Clandro `profile.d` directory path under `CLANDRO__PREFIX__ETC_DIR`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/etc/profile.d`
##
CLANDRO__PREFIX__PROFILE_D_DIR="$CLANDRO__PREFIX__ETC_DIR/profile.d"


##
# Clandro project system config directory path under `CLANDRO__PREFIX__ETC_DIR`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/etc/clandro`
##
CLANDRO__PROJECT_SYSTEM_CONFIG_DIR="$CLANDRO__PREFIX__ETC_DIR/$CLANDRO__INTERNAL_NAME"





####
# Variables for the Clandro cache.
####

##
# Clandro subdirectory path for `CLANDRO__CACHE_DIR`.
#
# Constant value: `cache`
##
CLANDRO__CACHE_SUBDIR="cache"

###########
# Uncomment if to place `CLANDRO__ROOTFS`  under `CLANDRO__PROJECT_DIR`
# instead of at `files`. This may be used for future multi-rootfs
# design. This will also ensure `termux` files are not mixed with
# other cached files of an app, especially if Clandro is forked or
# used as a library in other apps. Make sure to update
# `CLANDRO__ROOTFS_SUBDIR` above as well.

##
# Clandro subdirectory path for `CLANDRO__CACHE_DIR`.
#
# Default value: `cache/clandro/rootfs/0`
##
#CLANDRO__CACHE_SUBDIR="cache/$CLANDRO__INTERNAL_NAME/rootfs/$CLANDRO__ROOTFS_ID"
###########

##
# Clandro app cache directory path under `CLANDRO_APP__DATA_DIR`
# contains cache files that are safe to be deleted by Android or
# Clandro if required.
#
# The `cache` subdirectory is hardcoded in Android and must not be
# changed.
#
# Currently this is primarily used for packages cache files of package
# managers (`apt`/`pacman`).
#
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-app-cache-directory
#
# Default value: `/data/data/com.zk.clandro/cache`
##
CLANDRO__CACHE_DIR="$CLANDRO_APP__DATA_DIR/$CLANDRO__CACHE_SUBDIR"
__clandro_build_props__add_variables_validator_actions "CLANDRO__CACHE_DIR" "safe_absolute_path"

CLANDRO_CACHE_DIR="$CLANDRO__CACHE_DIR" # Deprecated alternative variable for `CLANDRO__CACHE_DIR`





####
# Variables for the Clandro bootstrap.
####

##
# Clandro bootstrap system config directory path under `CLANDRO__PROJECT_SYSTEM_CONFIG_DIR`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/etc/clandro/clandro-bootstrap`
##
CLANDRO_BOOTSTRAP__BOOTSTRAP_SYSTEM_CONFIG_DIR="$CLANDRO__PROJECT_SYSTEM_CONFIG_DIR/clandro-bootstrap"


##
# Clandro subdirectory path for `CLANDRO_BOOTSTRAP__BOOTSTRAP_SECOND_STAGE_DIR`.
#
# Constant value: `second-stage`
##
CLANDRO_BOOTSTRAP__BOOTSTRAP_SECOND_STAGE_SUBDIR="second-stage"

##
# Clandro bootstrap second stage directory path under `CLANDRO_BOOTSTRAP__BOOTSTRAP_SYSTEM_CONFIG_DIR`.
#
# Default value: `/data/data/com.zk.clandro/files/usr/etc/clandro/clandro-bootstrap/second-stage`
##
CLANDRO_BOOTSTRAP__BOOTSTRAP_SECOND_STAGE_DIR="$CLANDRO_BOOTSTRAP__BOOTSTRAP_SYSTEM_CONFIG_DIR/$CLANDRO_BOOTSTRAP__BOOTSTRAP_SECOND_STAGE_SUBDIR"


##
# Clandro bootstrap second stage entry point subfile path path under `CLANDRO_BOOTSTRAP__BOOTSTRAP_SECOND_STAGE_DIR`.
#
# Default value: `clandro-bootstrap-second-stage.sh`
##
CLANDRO_BOOTSTRAP__BOOTSTRAP_SECOND_STAGE_ENTRY_POINT_SUBFILE="clandro-bootstrap-second-stage.sh"





##
# Max size in bytes for a path component or file name without the
# terminating `null` byte `\0`.
#
# On unix systems, any path component length of a path cannot be
# greater than what is supported by the filesystem under which the
# path is mounted.
#
# The common filesystems like `ext4`/`f2fs`/`btrfs`/`erofs`/`fat32`/`exfat`/`ntfs`
# all support max path component length of `255`. Check
# [filesystems limits wiki page] for more info on limits.
#
# The [POSIX standard requires `NAME_MAX` to be defined in `limits.h`] (not `c` standard).
#
# [`NAME_MAX`]: https://cs.android.com/android/platform/superproject/+/android-13.0.0_r18:bionic/libc/kernel/uapi/linux/limits.h;l=27
# [`readdir`]: https://www.man7.org/linux/man-pages/man3/readdir.3.html
# [`readdir_r`]: https://www.man7.org/linux/man-pages/man3/readdir_r.3.html
# [filesystems limits wiki page]: https://en.wikipedia.org/wiki/Comparison_of_file_systems#Limits
# [POSIX standard requires `NAME_MAX` to be defined in `limits.h`]: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/limits.h.html
# [path component length greater than `NAME_MAX` should be considered an error]: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#4.13
# [`NAME_MAX` value should normally be set to `255`]: https://cs.android.com/android/platform/superproject/+/android-13.0.0_r18:bionic/libc/kernel/uapi/linux/limits.h;l=27
# [the `NAME_MAX` value may not always be enforced, like by the GNU C library]: https://www.gnu.org/software/libc/manual/html_node/Limits-for-Files.html
# [`_PC_NAME_MAX` defined by POSIX]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/pathconf.html
# [`glibc` `_PC_NAME_MAX` source]: https://github.com/bminor/glibc/blob/569cfcc6/sysdeps/posix/fpathconf.c#L65
# [`bionic` `_PC_NAME_MAX` source]: https://cs.android.com/android/platform/superproject/+/android-13.0.0_r18:bionic/libc/bionic/pathconf.cpp;l=91
# [`pathconf`]: https://man7.org/linux/man-pages/man3/pathconf.3.html
# [`statvfs.f_namemax`]: https://man7.org/linux/man-pages/man3/statvfs.3.html
# [`realpath(1)`]: https://man7.org/linux/man-pages/man1/realpath.1.html
# [`realpath(3)`]: https://man7.org/linux/man-pages/man3/realpath.3.html
# [To what extent does Linux support file names longer than 255 bytes?]: https://unix.stackexchange.com/questions/619625/to-what-extent-does-linux-support-file-names-longer-than-255-bytes
# [Extending ext4 File system's filename size limit to 1012 characters]: https://stackoverflow.com/questions/34980895/extending-ext4-file-systems-filename-size-limit-to-1012-characters
# [Limit on file name length in bash]: https://stackoverflow.com/questions/6571435/limit-on-file-name-length-in-bash
#
# Constant value: `255`
##
CLANDRO__NAME_MAX=255

##
# The max length for a filesystem socket file path (pathanme UNIX domain socket)
# for the `sockaddr_un.sun_path` field including the null `\0`
# terminator as per `UNIX_PATH_MAX`.
#
# All filesystem socket path lengths created by Clandro apps and packages must be `< 108`.
#
# - https://man7.org/linux/man-pages/man7/unix.7.html
# - https://cs.android.com/android/platform/superproject/+/android-13.0.0_r18:bionic/libc/kernel/uapi/linux/un.h;l=22
#
# Constant value: `108`
##
CLANDRO__UNIX_PATH_MAX=108





##
# Clandro environment variables root scope.
#
# The name of this variable `CLANDRO_ENV__S_ROOT` is considered a
# constant for Clandro execution environment that's exported by Clandro
# app containing the root scope and **must not be changed even for
# forks**. It can be used to check if running under Clandro or any of
# its forks, and should be used to generate all Clandro variable names
# that may need to be read, since Clandro app forks may not export
# variables under the `CLANDRO_` root scope and may do it under a
# different root scope like `FOO_`, so the `CLANDRO__PREFIX` variable
# would be `FOO__PREFIX` instead.
#
# The `CLANDRO_ENV__S_APP` environment variable will be exported at
# runtime for the scope of the current Clandro app running the shell.
#
# Clandro packages and external programs can use the
# `termux-scoped-env-variable` util from the `clandro-core`
# package to get variable names and values for Clandro. It uses the
# root scope from the `$CLANDRO_ENV__S_ROOT` environment variable
# exported by the Clandro app to dynamically generate the Clandro
# variable names and/or get their values, with support for fallback
# to the build values defined here if `$CLANDRO_ENV__S_ROOT` variable
# is not exported.**
# - https://github.com/cl-andro/clandro-core-package/blob/master/site/pages/en/projects/docs/usage/utils/clandro/shell/command/environment/termux-scoped-env-variable.md
#
# The value of this variable `CLANDRO_ENV__S_ROOT` may be modified,
# although not advisable since external programs would be using
# hardcoded `CLANDRO_` value for reading Clandro environment variables,
# and so changing variable names to say `FOO_*` would result in
# `CLANDRO_*` ones being unset during execution, which would change
# external programs behaviour and may break them.
# **If the value is changed here, it must also be set to the same
# value in Clandro app that is exported.**
#
# Moreover, currently, only `clandro-exec` supports modifying this, all
# other termux (internal) packages, like `clandro-tools`, etc do not.
# So forks should not modify it at least until all termux packages
# support modifying it.
#
# Default value: `CLANDRO_`
##
CLANDRO_ENV__S_ROOT="CLANDRO_"



##
# Clandro environment variables Clandro sub scope for primary variables
# or variables for currently running Clandro config.
#
# **Do not modify this!** This is considered a constant Clandro sub
# scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO` and variable names under it.**
#
# Default value: `_`
##
CLANDRO_ENV__SS_CLANDRO="_"

##
# Clandro environment variables Clandro scope for primary variables or
# variables for currently running Clandro config.
#
# **Do not modify this!**
#
# Default value: `CLANDRO__`
##
CLANDRO_ENV__S_CLANDRO="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO}"



##
# Clandro environment variables Clandro app sub scope.
#
# **Do not modify this!** This is considered a constant Clandro app sub
# scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_APP` and variable names under it.**
#
# Default value: `APP__`
##
CLANDRO_ENV__SS_CLANDRO_APP="APP__"

##
# Clandro environment variables Clandro app scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_APP__`
##
CLANDRO_ENV__S_CLANDRO_APP="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_APP}"



##
# Clandro environment variables Clandro:API sub scope.
#
# **Do not modify this!** This is considered a constant Clandro:API
# sub scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_API` and variable names under it.**
#
# Default value: `API__`
##
CLANDRO_ENV__SS_CLANDRO_API="API__"

##
# Clandro environment variables Clandro:API scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_API__`
##
CLANDRO_ENV__S_CLANDRO_API="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_API}"



##
# Clandro environment variables Clandro:API app sub scope.
#
# This may be allowed to be modified, in case APIs are provided under
# a different app name or under the main Clandro app itself by a fork.
# Consequences for changing this haven't been fully looked at yet.
#
# Default value: `API_APP__`
##
CLANDRO_ENV__SS_CLANDRO_API_APP="API_APP__"

##
# Clandro environment variables Clandro:API app scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_API_APP__`
##
CLANDRO_ENV__S_CLANDRO_API_APP="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_API_APP}"



##
# Clandro environment variables Clandro rootfs sub scope.
#
# **Do not modify this!** This is considered a constant Clandro rootfs
# sub scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_ROOTFS` and variable names under it.**
#
# Default value: `ROOTFS__`
##
CLANDRO_ENV__SS_CLANDRO_ROOTFS="ROOTFS__"

##
# Clandro environment variables Clandro rootfs scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_ROOTFS__`
##
CLANDRO_ENV__S_CLANDRO_ROOTFS="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_ROOTFS}"



##
# Clandro environment variables `clandro-core` sub scope.
#
# **Do not modify this!** This is considered a constant `clandro-core`
# sub scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_CORE` and variable names under it.**
#
# Default value: `CORE__`
##
CLANDRO_ENV__SS_CLANDRO_CORE="CORE__"

##
# Clandro environment variables `clandro-core` scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_CORE__`
##
CLANDRO_ENV__S_CLANDRO_CORE="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_CORE}"


##
# Clandro environment variables `clandro-core-tests` sub scope.
#
# **Do not modify this!** This is considered a constant
# `clandro-core-tests` sub scope for Clandro execution environment
#  that's used by `clandro-core` package to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_CORE__TESTS` and variable names under it.**
#
# Default value: `CLANDRO_CORE__TESTS__`
##
CLANDRO_ENV__SS_CLANDRO_CORE__TESTS="CORE__TESTS__"

##
# Clandro environment variables `clandro-core-tests` scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_CORE__TESTS__`
##
CLANDRO_ENV__S_CLANDRO_CORE__TESTS="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_CORE__TESTS}"



##
# Clandro environment variables `clandro-exec` sub scope.
#
# **Do not modify this!** This is considered a constant `clandro-exec`
# sub scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_EXEC` and variable names under it.**
#
# Default value: `EXEC__`
##
CLANDRO_ENV__SS_CLANDRO_EXEC="EXEC__"

##
# Clandro environment variables `clandro-exec` scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_EXEC__`
##
CLANDRO_ENV__S_CLANDRO_EXEC="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_EXEC}"


##
# Clandro environment variables `clandro-exec-tests` sub scope.
#
# **Do not modify this!** This is considered a constant
# `clandro-exec-tests` sub scope for Clandro execution environment
#  that's used by `clandro-exec` package to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_EXEC__TESTS` and variable names under it.**
#
# Default value: `CLANDRO_EXEC__TESTS__`
##
CLANDRO_ENV__SS_CLANDRO_EXEC__TESTS="EXEC__TESTS__"

##
# Clandro environment variables `clandro-exec-tests` scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_EXEC__TESTS__`
##
CLANDRO_ENV__S_CLANDRO_EXEC__TESTS="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_EXEC__TESTS}"



##
# Clandro environment variables `clandro-am-socket` sub scope.
#
# **Do not modify this!** This is considered a constant `clandro-am-socket`
# sub scope for Clandro execution environment that's used by external
# programs that do not use the termux packages building infrastructure
# and rely on `$CLANDRO_ENV__S_ROOT` environment variable exported by
# Clandro app containing the root scope to generate the value for
# `$CLANDRO_ENV__S_CLANDRO_AM_SOCKET` and variable names under it.**
#
# Default value: `AM_SOCKET__`
##
CLANDRO_ENV__SS_CLANDRO_AM_SOCKET="AM_SOCKET__"

##
# Clandro environment variables `clandro-am-socket` scope.
#
# **Do not modify this!**
#
# Default value: `CLANDRO_AM_SOCKET__`
##
CLANDRO_ENV__S_CLANDRO_AM_SOCKET="${CLANDRO_ENV__S_ROOT}${CLANDRO_ENV__SS_CLANDRO_AM_SOCKET}"





####
# Variables for the Clandro packages.
#
# - https://github.com/termux/termux-packages
####

##
# Clandro packages repo name.
#
# Default value: `clandro-packages`
##
CLANDRO_PKGS__REPO_NAME="clandro-packages"

##
# Clandro packages repo url.
#
# Default value: `https://github.com/termux/termux-packages`
##
CLANDRO_PKGS__REPO_URL="$CLANDRO__REPOS_HOST_ORG_URL/$CLANDRO_PKGS__REPO_NAME"





####
# Variables for the Clandro app that hosts the packages.
#
# - https://github.com/termux/termux-app
####

##
# Clandro app name.
#
# Default value: `Clandro`
##
CLANDRO_APP__NAME="$CLANDRO__NAME"


##
# The lower case value for `CLANDRO_APP__NAME`.
#
# Default value: `termux`
##
CLANDRO_APP__LNAME="${CLANDRO_APP__NAME,,}"

##
# Clandro app identifier for `CLANDRO__APPS_DIR_BY_IDENTIFIER` subdirectory.
#
# Default value: `termux`
# Validation regex: `CLANDRO__APPS_APP_IDENTIFIER_REGEX`
# Max length: `CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN`
##
CLANDRO_APP__APP_IDENTIFIER="clandro"



##
# Clandro app repo name.
#
# Default value: `termux-app`
##
CLANDRO_APP__REPO_NAME="clandro-app"

##
# Clandro app repo url.
#
# Default value: `https://github.com/termux/termux-app`
##
CLANDRO_APP__REPO_URL="$CLANDRO__REPOS_HOST_ORG_URL/$CLANDRO_APP__REPO_NAME"



##
# Clandro app namespace, i.e the Java package name under which Clandro
# classes exists used for `CLANDRO_APP__*_CLASS__*` and
# `CLANDRO_APP__*_(ACTIVITY|RECEIVER|SERVICE)__*` variables.
#
# **See Also:**
# - `CLANDRO_APP__PACKAGE_NAME`.
# - https://developer.android.com/build/configure-app-module#set-namespace
# - https://github.com/termux/termux-app/tree/master/app/src/main/java/com/termux
#
# Default value: `com.zk.clandro`
##
CLANDRO_APP__NAMESPACE="com.zk.clandro"

__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__NAMESPACE" "app_package_name"



##
# Clandro app apps directory path under `CLANDRO__APPS_DIR_BY_IDENTIFIER`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/i/termux`
##
CLANDRO_APP__APP_DIR="$CLANDRO__APPS_DIR_BY_IDENTIFIER/$CLANDRO_APP__APP_IDENTIFIER"
__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__APP_DIR" "safe_absolute_path"



##
# Clandro app shell API `Activity` class name that hosts the
# shell/terminal views.
#
# **See Also:**
# - https://github.com/termux/termux-app/blob/master/app/src/main/java/com/clandro/app/TermuxActivity.java
#
# Default value: `com.zk.clandro.app.TermuxActivity`
##
CLANDRO_APP__SHELL_API__SHELL_API_ACTIVITY__CLASS_NAME="$CLANDRO_APP__NAMESPACE.app.TermuxActivity"



##
# Clandro app shell API `Service` class name that hosts the
# shell/terminal sessions.
#
# **See Also:**
# - https://github.com/termux/termux-app/blob/master/app/src/main/java/com/clandro/app/TermuxService.java
#
# Default value: `com.zk.clandro.app.TermuxService`
##
CLANDRO_APP__SHELL_API__SHELL_API_SERVICE__CLASS_NAME="$CLANDRO_APP__NAMESPACE.app.TermuxService"



##
# Clandro app `RUN_COMMAND` API `Service` class name that receives
# commands sent by 3rd party apps via intents.
#
# **See Also:**
# - https://github.com/termux/termux-app/blob/master/app/src/main/java/com/clandro/app/RunCommandService.java
# - https://github.com/termux/termux-app/wiki/RUN_COMMAND-Intent
#
# Default value: `com.zk.clandro.app.RunCommandService`
##
CLANDRO_APP__RUN_COMMAND_API__RUN_COMMAND_API_SERVICE__CLASS_NAME="$CLANDRO_APP__NAMESPACE.app.RunCommandService"



##
# Clandro app data sender API `BroadcastReceiver` class name that
# receives data view broadcasts and sends the data with `ACTION_SEND`
# and `ACTION_VIEW` intents to other apps, like by `termux-open`.
#
# **See Also:**
# - https://github.com/termux/termux-app/blob/master/app/src/main/java/com/clandro/app/TermuxOpenReceiver.java
# - https://github.com/termux/clandro-tools/blob/master/scripts/termux-open.in
#
# Default value: `com.zk.clandro.app.TermuxOpenReceiver`
##
CLANDRO_APP__DATA_SENDER_API__DATA_SENDER_API_RECEIVER__CLASS_NAME="$CLANDRO_APP__NAMESPACE.app.TermuxOpenReceiver"





##
# Clandro apps info environment file path for the Clandro app under `CLANDRO_APP__APP_DIR`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/i/clandro/clandro-apps-info.env`
##
CLANDRO_APP__CORE__APPS_INFO_ENV_FILE="$CLANDRO_APP__APP_DIR/$CLANDRO_CORE__APPS_INFO_ENV_SUBFILE"
__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__CORE__APPS_INFO_ENV_FILE" "safe_absolute_path"

##
# Clandro apps info json file path for the Clandro app under `CLANDRO_APP__APP_DIR`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/i/clandro/clandro-apps-info.json`
##
CLANDRO_APP__CORE__APPS_INFO_JSON_FILE="$CLANDRO_APP__APP_DIR/$CLANDRO_CORE__APPS_INFO_JSON_SUBFILE"
__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__CORE__APPS_INFO_JSON_FILE" "safe_absolute_path"

##
# `clandro-am-socket` server file path for the Clandro app under `CLANDRO_APP__APP_DIR`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/i/clandro/termux-am`
##
CLANDRO_APP__AM_SOCKET__SERVER_SOCKET_FILE="$CLANDRO_APP__APP_DIR/$CLANDRO_AM_SOCKET__SERVER_SOCKET_SUBFILE"
__clandro_build_props__add_variables_validator_actions "CLANDRO_APP__AM_SOCKET__SERVER_SOCKET_FILE" "safe_absolute_path unix_path_max"





####
# Variables for the Clandro:API app that hosts the packages.
#
# - https://github.com/termux/termux-api
####

##
# Clandro:API app package name used for
# `CLANDRO_API_APP__*_(ACTIVITY|RECEIVER|SERVICE)__*` variables.
#
# **See Also:**
# - `CLANDRO_API_APP__NAMESPACE`.
# - https://developer.android.com/build/configure-app-module#set-application-id
# - https://github.com/termux/termux-packages/wiki/Clandro-file-system-layout#termux-private-app-data-directory
#
# Default value: `com.zk.clandro.api`
##
CLANDRO_API_APP__PACKAGE_NAME="com.zk.clandro.api"

__clandro_build_props__add_variables_validator_actions "CLANDRO_API_APP__PACKAGE_NAME" "app_package_name"



##
# Clandro:API app name.
#
# Default value: `Clandro:API`
##
CLANDRO_API_APP__NAME="$CLANDRO__NAME:API"

##
# Clandro:API app identifier for `CLANDRO__APPS_DIR_BY_IDENTIFIER` subdirectory.
#
# Default value: `termuxapi`
# Validation regex: `CLANDRO__APPS_APP_IDENTIFIER_REGEX`
# Max length: `CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN`
##
CLANDRO_API_APP__APP_IDENTIFIER="clandroapi"



##
# Clandro:API app repo name.
#
# Default value: `termux-api`
##
CLANDRO_API_APP__REPO_NAME="clandro-api"

##
# Clandro:API app repo url.
#
# Default value: `https://github.com/termux/termux-api`
##
CLANDRO_API_APP__REPO_URL="$CLANDRO__REPOS_HOST_ORG_URL/$CLANDRO_API_APP__REPO_NAME"



##
# Clandro:API app namespace, i.e the Java package name under which
# Clandro:API classes exists used for `CLANDRO_API_APP__*_CLASS__*` and
# `CLANDRO_API_APP__*_(ACTIVITY|RECEIVER|SERVICE)__*` variables.
#
# **See Also:**
# - `CLANDRO_API_APP__PACKAGE_NAME`.
# - https://developer.android.com/build/configure-app-module#set-namespace
# - https://github.com/termux/termux-api/tree/master/app/src/main/java/com/clandro/api
#
# Default value: `com.zk.clandro.api`
##
CLANDRO_API_APP__NAMESPACE="com.zk.clandro.api"

__clandro_build_props__add_variables_validator_actions "CLANDRO_API_APP__NAMESPACE" "app_package_name"



##
# Clandro:API app apps directory path under `CLANDRO__APPS_DIR_BY_IDENTIFIER`.
#
# Default value: `/data/data/com.zk.clandro/clandro/app/i/termuxapi`
##
CLANDRO_API_APP__APP_DIR="$CLANDRO__APPS_DIR_BY_IDENTIFIER/$CLANDRO_API_APP__APP_IDENTIFIER"
__clandro_build_props__add_variables_validator_actions "CLANDRO_API_APP__APP_DIR" "safe_absolute_path"



##
# Clandro:API app Android API `BroadcastReceiver` class name that
# receives and processes API requests from command line via `termux-api`
# native exec entry point.
#
# **See Also:**
# - https://github.com/termux/termux-api/blob/master/app/src/main/java/com/clandro/api/TermuxApiReceiver.java
# - https://github.com/cl-andro/clandro-api-package/blob/master/termux-api.c
#
# Default value: `com.zk.clandro.api.TermuxApiReceiver`
##
CLANDRO_API_APP__ANDROID_API__ANDROID_API_RECEIVER__CLASS_NAME="$CLANDRO_API_APP__NAMESPACE.TermuxApiReceiver"





####
# Variables for the `termux-api` package.
#
# - https://github.com/cl-andro/clandro-api-package
####

##
# The `termux-api` package repo name.
#
# Default value: `clandro-api-package`
##
CLANDRO_API_PKG__REPO_NAME="clandro-api-package"

##
# The `termux-api` package repo url.
#
# Default value: `https://github.com/cl-andro/clandro-api-package`
##
CLANDRO_API_PKG__REPO_URL="$CLANDRO__REPOS_HOST_ORG_URL/$CLANDRO_API_PKG__REPO_NAME"










####
# Variables for the `clandro-core` package.
#
# - https://github.com/cl-andro/clandro-core-package
####

##
# The `clandro-core` package repo name.
#
# Default value: `clandro-core-package`
##
CLANDRO_CORE_PKG__REPO_NAME="clandro-core-package"

##
# The `clandro-core` package repo url.
#
# Default value: `https://github.com/cl-andro/clandro-core-package`
##
CLANDRO_CORE_PKG__REPO_URL="$CLANDRO__REPOS_HOST_ORG_URL/$CLANDRO_CORE_PKG__REPO_NAME"





####
# Variables for the `termux-am` package.
#
# - https://github.com/cl-andro/ClandroAm
####

##
# The `termux-am` package repo name.
#
# Default value: `TermuxAm`
##
CLANDRO_AM_PKG__REPO_NAME="ClandroAm"

##
# The `termux-am` package repo url.
#
# Default value: `https://github.com/cl-andro/ClandroAm`
##
CLANDRO_AM_PKG__REPO_URL="$CLANDRO__REPOS_HOST_ORG_URL/$CLANDRO_AM_PKG__REPO_NAME"



##
# TermuxAm namespace, i.e the Java package name under which Clandro
# classes exists used for `CLANDRO_AM__*_CLASS__*` variables.
#
# This must not be changed unless the classes in the `TermuxAm` repo
# are moved to a different Java package name (in forks).
#
# **See Also:**
# - https://developer.android.com/build/configure-app-module#set-namespace
# - https://github.com/cl-andro/ClandroAm/tree/master/app/src/main/java/com/clandro/termuxam
#
# Constant value: `com.zk.clandro.termuxam`
##
CLANDRO_AM_APP__NAMESPACE="com.zk.clandro.clandroam"

__clandro_build_props__add_variables_validator_actions "CLANDRO_AM_APP__NAMESPACE" "app_package_name"



##
# TermuxAm main class that is passed as `start-class-name` to
# `/system/bin/app_process` when running `am.apk` set in `$CLASSPATH`.
#
# - https://github.com/cl-andro/ClandroAm/blob/master/app/src/main/java/com/clandro/termuxam/Am.java
# - https://github.com/cl-andro/ClandroAm/blob/v0.8.0/am-libexec-packaged#L30
# - https://cs.android.com/android/platform/superproject/+/android-14.0.0_r1:frameworks/base/cmds/app_process/app_main.cpp;l=31
#
# Default value: `com.zk.clandro.termuxam.Am`
##
CLANDRO_AM_APP__AM_CLASS__CLASS_NAME="$CLANDRO_AM_APP__NAMESPACE.Am"





###
# Variables for the Clandro package repositories.
###

# The core variable values for which the packages hosted on the
# package repos defined in `repo.json` are compiled for.
# If a custom repo is not being hosted, and official Clandro repos are
# still defined in `repo.json`, then DO NOT change these values. If a
# custom repo is being hosted whose variable values equal
# `CLANDRO_APP__PACKAGE_NAME`, `CLANDRO_APP__DATA_DIR`,
# `CLANDRO__CORE_DIR`, `CLANDRO__APPS_DIR`, `CLANDRO__ROOTFS`,
# `CLANDRO__HOME`, and `CLANDRO__PREFIX` values defined above, then
# update these values respectively to the same values.
# These values are used for the `-i/-I` flags to `build-package.sh`,
# and if respective values do not match, then those flags are ignored
# and dependency packages are not downloaded from the package repos
# and are compiled locally.
# FIXME: Checking for all variables will be added later in repo
# changes pull, currently only `CLANDRO_REPO_APP__PACKAGE_NAME` is checked.
CLANDRO_REPO_APP__PACKAGE_NAME="com.zk.clandro"
CLANDRO_REPO_APP__DATA_DIR="/data/data/com.zk.clandro"
CLANDRO_REPO__CORE_DIR="/data/data/com.zk.clandro/clandro/core"
CLANDRO_REPO__APPS_DIR="/data/data/com.zk.clandro/clandro/app"
CLANDRO_REPO__ROOTFS="/data/data/com.zk.clandro/files"
CLANDRO_REPO__HOME="/data/data/com.zk.clandro/files/home"
CLANDRO_REPO__PREFIX="/data/data/com.zk.clandro/files/usr"



####
# Variables loaded from `repo.json` file for Clandro package repositories.
####

CLANDRO_REPO_URL=()
CLANDRO_REPO_DISTRIBUTION=()
CLANDRO_REPO_COMPONENT=()

# FIXME: Move `repo.json` file to under `scripts/` directory and COPY it to `/tmp/clandro-packages` in `Dockerfile`.
if [[ ! -f "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/repo.json" ]]; then
    if [[ "${CLANDRO_PKGS__BUILD__IS_DOCKER_BUILD:-}" != "true" ]]; then
        echo "The 'repo.json' file not found at the '$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/repo.json' path." 1>&2
        exit 1
    fi
else
    export CLANDRO_PACKAGES_DIRECTORIES
    CLANDRO_PACKAGES_DIRECTORIES=$(jq --raw-output 'del(.pkg_format) | keys | .[]' "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/repo.json")

    for url in $(jq -r 'del(.pkg_format) | .[] | .url' "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/repo.json"); do
        CLANDRO_REPO_URL+=("$url")
    done
    for distribution in $(jq -r 'del(.pkg_format) | .[] | .distribution' "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/repo.json"); do
        CLANDRO_REPO_DISTRIBUTION+=("$distribution")
    done
    for component in $(jq -r 'del(.pkg_format) | .[] | .component' "$CLANDRO_PKGS__BUILD__REPO_ROOT_DIR/repo.json"); do
        CLANDRO_REPO_COMPONENT+=("$component")
    done
fi





###
# Misc
###

CLANDRO_CLEANUP_BUILT_PACKAGES_THRESHOLD="$(( 5 * 1024 ** 3 ))" # 5 GiB
__clandro_build_props__add_variables_validator_actions "CLANDRO_CLEANUP_BUILT_PACKAGES_THRESHOLD" "unsigned_int"

# Path to CGCT tools
CGCT_DEFAULT_PREFIX="/data/data/com.zk.clandro/files/usr/glibc"
__clandro_build_props__add_variables_validator_actions "CGCT_DEFAULT_PREFIX" "safe_absolute_path invalid_clandro_prefix_paths"

export CGCT_DIR="/data/data/com.zk.clandro/cgct"
__clandro_build_props__add_variables_validator_actions "CGCT_DIR" "safe_absolute_path invalid_clandro_prefix_paths"

# Allow to override setup.
for f in "${HOME}/.config/clandro/termuxrc.sh" "${HOME}/.clandro/clandrorc.sh" "${HOME}/.termuxrc"; do
    if [ -f "$f" ]; then
        echo "Using builder configuration from '$f'..."
        # shellcheck source=/dev/null
        . "$f"
        break
    fi
done
unset f





###
# Run Clandro properties variable values validation.
###

# Uncomment to print `CLANDRO_` variables set
#compgen -v CLANDRO_ | while read v; do echo "${v}=${!v}"; done

##
# `__clandro_build_props__validate_variables`
##
__clandro_build_props__validate_variables() {

    local is_value_defined
    local validator_action
    local validator_actions
    local variable_name
    local variable_value

    if [[ ! "$CLANDRO__INTERNAL_NAME" =~ ${CLANDRO__INTERNAL_NAME_REGEX:?} ]]; then
        echo "The CLANDRO__INTERNAL_NAME '$CLANDRO__INTERNAL_NAME' with length ${#CLANDRO__INTERNAL_NAME} is invalid." 1>&2
        echo "Check 'CLANDRO__INTERNAL_NAME_REGEX' variable docs for info on what is a valid internal name." 1>&2
        return 1
    fi

    if [ "${#CLANDRO__INTERNAL_NAME}" -gt ${CLANDRO__INTERNAL_NAME___MAX_LEN:?} ]; then
        echo "The CLANDRO__INTERNAL_NAME '$CLANDRO__INTERNAL_NAME' with length ${#CLANDRO__INTERNAL_NAME} is invalid." 1>&2
        echo "The CLANDRO__INTERNAL_NAME must have max length \`<= CLANDRO__INTERNAL_NAME___MAX_LEN ($CLANDRO__INTERNAL_NAME___MAX_LEN)\`." 1>&2
        return 1
    fi

    if [[ ! "$CLANDRO_APP__DATA_DIR" =~ ${CLANDRO_REGEX__APP_DATA_DIR_PATH:?} ]]; then
        echo "The CLANDRO_APP__DATA_DIR '$CLANDRO_APP__DATA_DIR' with length ${#CLANDRO_APP__DATA_DIR} is invalid." 1>&2
        echo "The CLANDRO_APP__DATA_DIR must match \`/data/data/<package_name>\`, \`/data/user/<user_id>/<package_name>\` \
or \`/mnt/expand/<volume_uuid>/user/<user_id>/<package_name>\` formats." 1>&2
        return 1
    fi


    for variable_name in "${__CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_VARIABLE_NAMES[@]}"; do
        if [[ ! "$variable_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
            echo "The variable_name '$variable_name' in Clandro properties variables validator actions is not a valid shell variable name." 1>&2
            return 1
        fi

        variable_value="${!variable_name:-}"
        validator_actions="${__CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_MAP["$variable_name"]}"
        [[ -z "$validator_actions" ]] && continue

        if [[ -n "$variable_value" ]]; then
            :
        else
            is_value_defined=0
            eval '[ -n "${'"$variable_name"'+x}" ] && is_value_defined=1'

            # If not defined.
            if [[ "$is_value_defined" = "0" ]]; then
                echo "The variable_name '$variable_name' in Clandro properties variables validator actions is not defined." 1>&2
                return 1
            fi

            # If defined but unset.
            [[ " ${validator_actions[*]} " == *" allow_unset_value "* ]] && continue

            echo "The Clandro properties variable value for variable name '$variable_name' is not set." 1>&2
            return 1
        fi

        for validator_action in $validator_actions; do
            case "$validator_action" in
                allow_unset_value)
                    :
                    ;;
                app_package_name)
                    if [[ ! "$variable_value" =~ ${CLANDRO_REGEX__APP_PACKAGE_NAME:?} ]] || \
                            [ "${#variable_value}" -gt "${CLANDRO__NAME_MAX:?}" ]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must be a valid android app package name with \
max length \`<= CLANDRO__NAME_MAX ($CLANDRO__NAME_MAX)\`." 1>&2
                        echo "- https://developer.android.com/build/configure-app-module#set-application-id" 1>&2
                        return 1
                    fi
                    ;;
                invalid_clandro_rootfs_paths)
                    if [[ "$variable_value" =~ ${CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS:?} ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must not match one of the invalid paths \
in CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS \`$CLANDRO_REGEX__INVALID_CLANDRO_ROOTFS_PATHS\`." 1>&2
                        return 1
                    fi
                    ;;
                invalid_clandro_home_paths)
                    if [[ "$variable_value" =~ ${CLANDRO_REGEX__INVALID_CLANDRO_HOME_PATHS:?} ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must not match one of the invalid paths \
in CLANDRO_REGEX__INVALID_CLANDRO_HOME_PATHS \`$CLANDRO_REGEX__INVALID_CLANDRO_HOME_PATHS\`." 1>&2
                        return 1
                    fi
                    ;;
                invalid_clandro_prefix_paths)
                    if [[ "$variable_value" =~ ${CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS:?} ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must not match one of the invalid paths \
in CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS \`$CLANDRO_REGEX__INVALID_CLANDRO_PREFIX_PATHS\`." 1>&2
                        return 1
                    fi
                    ;;
                path_equal_to_or_under_clandro_rootfs)
                    if [[ "$variable_value" != "${CLANDRO__ROOTFS:?}" ]] && \
                            {
                                { [[ "${CLANDRO__ROOTFS:?}" != "/" ]] && [[ "$variable_value" != "${CLANDRO__ROOTFS}/"* ]]; } || \
                                { [[ "${CLANDRO__ROOTFS:?}" == "/" ]] && [[ "$variable_value" != "/"* ]]; };
                            }; then
                        echo "The $variable_name '$variable_value' is invalid." 1>&2
                        echo "The $variable_name must be equal to or be under CLANDRO__ROOTFS \`$CLANDRO__ROOTFS\`." 1>&2
                        return 1
                    fi
                    ;;
                path_under_clandro_rootfs)
                    if { [[ "${CLANDRO__ROOTFS:?}" != "/" ]] && [[ "$variable_value" != "${CLANDRO__ROOTFS}/"* ]]; } || \
                        { [[ "${CLANDRO__ROOTFS:?}" == "/" ]] && [[ "$variable_value" != "/"* ]]; }; then
                        echo "The $variable_name '$variable_value' is invalid." 1>&2
                        echo "The $variable_name must be under CLANDRO__ROOTFS \`$CLANDRO__ROOTFS\`." 1>&2
                        return 1
                    fi
                    ;;
                safe_absolute_path)
                    if [[ ! "$variable_value" =~ ${CLANDRO_REGEX__SAFE_ABSOLUTE_PATH:?} ]] || \
                            [[ "$variable_value" =~ ${CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH:?} ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must match a safe absolute path that starts with a \`/\` with at least one \
characters under rootfs \`/\`. Duplicate or trailing path separators \`/\` are not allowed. \
The path component characters must be in the range \`[a-zA-Z0-9+,.=_-]\`. The path must not contain single \`/./\` or \
double \`/../\` dot components." 1>&2
                        return 1
                    fi
                    ;;
                safe_relative_path)
                    if [[ ! "$variable_value" =~ ${CLANDRO_REGEX__SAFE_RELATIVE_PATH:?} ]] || \
                            [[ "$variable_value" =~ ${CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH:?} ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must match a safe relative path that does not start with a \`/\`. \
Duplicate or trailing path separators \`/\` are not allowed. The path component characters must be in the \
range \`[a-zA-Z0-9+,.=_-]\`. The path must not contain single \`/./\` or double \`/../\` dot components." 1>&2
                        return 1
                    fi
                    ;;
                safe_rootfs_or_absolute_path)
                    if [[ ! "$variable_value" =~ ${CLANDRO_REGEX__SAFE_ROOTFS_OR_ABSOLUTE_PATH:?} ]] || \
                            [[ "$variable_value" =~ ${CLANDRO_REGEX__SINGLE_OR_DOUBLE_DOT_CONTAINING_PATH:?} ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must match (rootfs \`/\`) or (a safe absolute path that starts with a \`/\`). \
Duplicate or trailing path separators \`/\` are not allowed. The path component characters must be in the \
range \`[a-zA-Z0-9+,.=_-]\`. The path must not contain single \`/./\` or double \`/../\` dot components." 1>&2
                        return 1
                    fi
                    ;;
                apps_api_socket__server_parent_dir)
                    if [[ "${#variable_value}" -ge "${CLANDRO__APPS_API_SOCKET__SERVER_PARENT_DIR___MAX_LEN:?}" ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must have max length \`<= CLANDRO__APPS_API_SOCKET__SERVER_PARENT_DIR___MAX_LEN \
($CLANDRO__APPS_API_SOCKET__SERVER_PARENT_DIR___MAX_LEN)\` including the null \`\0\` terminator." 1>&2
                        return 1
                    fi
                    ;;
                unix_path_max)
                    if [[ "${#variable_value}" -ge "${CLANDRO__UNIX_PATH_MAX:?}" ]]; then
                        echo "The $variable_name '$variable_value' with length ${#variable_value} is invalid." 1>&2
                        echo "The $variable_name must have max length \`<= CLANDRO__UNIX_PATH_MAX ($CLANDRO__UNIX_PATH_MAX)\` \
including the null \`\0\` terminator." 1>&2
                        return 1
                    fi
                    ;;
                unsigned_int)
                    if [[ ! "$variable_value" =~ ${CLANDRO_REGEX__UNSIGNED_INT:?} ]]; then
                        echo "The $variable_name '$variable_value' is invalid." 1>&2
                        echo "The $variable_name must be an unsigned integer \`>= 0\`." 1>&2
                        return 1
                    fi
                    ;;
                *)
                    echo "The Clandro properties variables validator action '$validator_action' for \
variable name '$variable_name' is invalid." 1>&2
                    return 1
                    ;;
            esac
        done
    done


    if [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN" == "true" ]] && \
            [ "${#CLANDRO_APP__DATA_DIR}" -ge ${CLANDRO_APP__DATA_DIR___MAX_LEN:?} ]; then
        echo "The CLANDRO_APP__DATA_DIR '$CLANDRO_APP__DATA_DIR' with length ${#CLANDRO_APP__DATA_DIR} is invalid." 1>&2
        echo "The CLANDRO_APP__DATA_DIR must have max length \`<= CLANDRO_APP__DATA_DIR___MAX_LEN ($CLANDRO_APP__DATA_DIR___MAX_LEN)\` \
including the null \`\0\` terminator." 1>&2
        return 1
    fi

    if [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN" == "true" ]] && \
            [ "${#CLANDRO__APPS_DIR}" -ge ${CLANDRO__APPS_DIR___MAX_LEN:?} ]; then
        echo "The CLANDRO__APPS_DIR '$CLANDRO__APPS_DIR' with length ${#CLANDRO__APPS_DIR} is invalid." 1>&2
        echo "The CLANDRO__APPS_DIR must have max length \`<= CLANDRO__APPS_DIR___MAX_LEN ($CLANDRO__APPS_DIR___MAX_LEN)\` \
including the null \`\0\` terminator." 1>&2
        return 1
    fi


    if [[ ! "$CLANDRO_APP__APP_IDENTIFIER" =~ ${CLANDRO__APPS_APP_IDENTIFIER_REGEX:?} ]]; then
        echo "The CLANDRO_APP__APP_IDENTIFIER '$CLANDRO_APP__APP_IDENTIFIER' with length ${#CLANDRO_APP__APP_IDENTIFIER} is invalid." 1>&2
        echo "Check 'CLANDRO__APPS_APP_IDENTIFIER_REGEX' variable docs for info on what is a valid app identifier." 1>&2
        return 1
    fi

    if [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN" == "true" ]] && \
            [ "${#CLANDRO_APP__APP_IDENTIFIER}" -gt ${CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN:?} ]; then
        echo "The CLANDRO_APP__APP_IDENTIFIER '$CLANDRO_APP__APP_IDENTIFIER' with length ${#CLANDRO_APP__APP_IDENTIFIER} is invalid." 1>&2
        echo "The CLANDRO_APP__APP_IDENTIFIER must have max length \
\`<= CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN ($CLANDRO__APPS_APP_IDENTIFIER___MAX_LEN)\`." 1>&2
        return 1
    fi


    if [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN" == "true" ]] && \
            [ "${#CLANDRO__ROOTFS}" -ge ${CLANDRO__ROOTFS_DIR___MAX_LEN:?} ]; then
        echo "The CLANDRO__ROOTFS '$CLANDRO__ROOTFS' with length ${#CLANDRO__ROOTFS} is invalid." 1>&2
        echo "The CLANDRO__ROOTFS must have max length \`<= CLANDRO__ROOTFS_DIR___MAX_LEN ($CLANDRO__ROOTFS_DIR___MAX_LEN)\` \
including the null \`\0\` terminator." 1>&2
        return 1
    fi

    if [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN" == "true" ]] && \
            [ "${#CLANDRO__PREFIX}" -ge ${CLANDRO__PREFIX_DIR___MAX_LEN:?} ]; then
        echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' with length ${#CLANDRO__PREFIX} is invalid." 1>&2
        echo "The CLANDRO__PREFIX must have max length \`<= CLANDRO__PREFIX_DIR___MAX_LEN ($CLANDRO__PREFIX_DIR___MAX_LEN)\` \
including the null \`\0\` terminator." 1>&2
        return 1
    fi

    if [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN" == "true" ]] && \
            [ "${#CLANDRO__PREFIX__TMP_DIR}" -ge ${CLANDRO__PREFIX__TMP_DIR___MAX_LEN:?} ]; then
        echo "The CLANDRO__PREFIX__TMP_DIR '$CLANDRO__PREFIX__TMP_DIR' with length ${#CLANDRO__PREFIX__TMP_DIR} is invalid." 1>&2
        echo "The CLANDRO__PREFIX__TMP_DIR must have max length \`<= CLANDRO__PREFIX__TMP_DIR___MAX_LEN ($CLANDRO__PREFIX__TMP_DIR___MAX_LEN)\` \
including the null \`\0\` terminator." 1>&2
        return 1
    fi


    if [[ "$CLANDRO__ROOTFS" != "/" ]] && \
            [[ "$__CLANDRO_BUILD_PROPS__VALIDATE_CLANDRO_PREFIX_USR_MERGE_FORMAT" == "true" ]]; then
        if [[ "$CLANDRO__PREFIX" != "$CLANDRO__ROOTFS/usr" ]]; then
            echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' is invalid." 1>&2
            echo "The CLANDRO__PREFIX must be equal to '\$CLANDRO__ROOTFS/usr' ($CLANDRO__ROOTFS/usr) as per 'usr' merge format." 1>&2
            return 1
        fi

        if [[ "${CLANDRO__PREFIX:?}" == "${CLANDRO__HOME:?}" ]] || \
                [[ "$CLANDRO__PREFIX" == "$CLANDRO__HOME/"* ]] || \
                [[ "$CLANDRO__HOME" == "$CLANDRO__PREFIX/"* ]]; then
            echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' or CLANDRO__HOME '$CLANDRO__HOME' is invalid." 1>&2
            echo "The CLANDRO__PREFIX must not be equal to CLANDRO__HOME and they must not be under each other as per 'usr' merge format." 1>&2
            return 1
        fi
    else
        if [[ "${CLANDRO__PREFIX:?}" == "${CLANDRO__HOME:?}" ]] || \
                [[ "$CLANDRO__PREFIX" == "$CLANDRO__HOME/"* ]]; then
            echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' or CLANDRO__HOME '$CLANDRO__HOME' is invalid." 1>&2
            echo "The CLANDRO__PREFIX must not be equal to or be under CLANDRO__HOME." 1>&2
            return 1
        fi
    fi

    if [[ "${CLANDRO__PREFIX:?}" == "${CGCT_DIR:?}" ]] || \
            [[ "$CLANDRO__PREFIX" == "$CGCT_DIR/"* ]] || \
            [[ "$CGCT_DIR" == "$CLANDRO__PREFIX/"* ]]; then
        echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' or CGCT_DIR '$CGCT_DIR' is invalid." 1>&2
        echo "The CLANDRO__PREFIX must not be equal to CGCT_DIR and they must not be under each other." 1>&2
        return 1
    fi

    if [[ "$CLANDRO__PREFIX" != "$CLANDRO_PREFIX_CLASSICAL" ]]; then
        echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' or CLANDRO_PREFIX_CLASSICAL '$CLANDRO_PREFIX_CLASSICAL' is invalid." 1>&2
        echo "The CLANDRO__PREFIX must be equal to CLANDRO_PREFIX_CLASSICAL." 1>&2
        return 1
    fi

    if [[ "$CLANDRO__PREFIX" == "$CLANDRO__PREFIX_GLIBC" ]]; then
        echo "The CLANDRO__PREFIX '$CLANDRO__PREFIX' or CLANDRO__PREFIX_GLIBC '$CLANDRO__PREFIX_GLIBC' is invalid." 1>&2
        echo "The CLANDRO__PREFIX must not be equal to CLANDRO__PREFIX_GLIBC." 1>&2
        return 1
    fi

    if [[ "$CLANDRO__PREFIX__BASE_LIB_DIR" == "$CLANDRO__PREFIX__MULTI_LIB_DIR" ]]; then
        echo "The CLANDRO__PREFIX__BASE_LIB_DIR '$CLANDRO__PREFIX__BASE_LIB_DIR' or CLANDRO__PREFIX__MULTI_LIB_DIR '$CLANDRO__PREFIX__MULTI_LIB_DIR' is invalid." 1>&2
        echo "The CLANDRO__PREFIX__BASE_LIB_DIR must not be equal to CLANDRO__PREFIX__MULTI_LIB_DIR." 1>&2
        return 1
    fi

    if [[ "$CLANDRO__PREFIX__BASE_INCLUDE_DIR" == "$CLANDRO__PREFIX__MULTI_INCLUDE_DIR" ]]; then
        echo "The CLANDRO__PREFIX__BASE_INCLUDE_DIR '$CLANDRO__PREFIX__BASE_INCLUDE_DIR' or CLANDRO__PREFIX__MULTI_INCLUDE_DIR '$CLANDRO__PREFIX__MULTI_INCLUDE_DIR' is invalid." 1>&2
        echo "The CLANDRO__PREFIX__BASE_INCLUDE_DIR must not be equal to CLANDRO__PREFIX__MULTI_INCLUDE_DIR." 1>&2
        return 1
    fi

}

__clandro_build_props__validate_variables || exit $?

unset __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_MAP
unset __CLANDRO_BUILD_PROPS__VARIABLES_VALIDATOR_ACTIONS_VARIABLE_NAMES
unset __CLANDRO_BUILD_PROPS__VALIDATE_PATHS_MAX_LEN
unset __CLANDRO_BUILD_PROPS__VALIDATE_CLANDRO_PREFIX_USR_MERGE_FORMAT
unset __clandro_build_props__add_variables_validator_actions
unset __clandro_build_props__validate_variables
