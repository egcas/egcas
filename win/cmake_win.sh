#!/bin/bash -e

SCR_BASE_DIR=$(dirname "${0}")
EGCAS_META_DIR=$(realpath "${SCR_BASE_DIR}/../")


WIN_BUILD_DIR="build_win"
MXE_BUILD_DIR="build_mxe"
MXE_CONFIG_FILE="mxe_config_file.txt"

if ! [ -d "${EGCAS_META_DIR}/win/" ]; then
        echo "${0} script not existing at expected place."
        exit 1
fi

MXE_ABS_BUILD_DIR="${EGCAS_META_DIR}/${MXE_BUILD_DIR}"

if ! [ -d "${MXE_ABS_BUILD_DIR}" ]; then
        echo "mxe build dir ${MXE_BUILD_DIR} does not exist... Aborting..."
        exit 2
fi


cd "${EGCAS_META_DIR}/${MXE_BUILD_DIR}"
source "${MXE_ABS_BUILD_DIR}/${MXE_CONFIG_FILE}"
cd "${EGCAS_META_DIR}"
mkdir "${WIN_BUILD_DIR}"
cd "${WIN_BUILD_DIR}"
"${MXE_ABS_BUILD_DIR}/mxe/usr/bin/i686-w64-mingw32.shared-cmake" -DCMAKE_PREFIX_PATH="${MXE_QT_INSTALL_PATH}" ..
  
echo "cmake environment setup successful!"
echo ""
echo "build egcas now with \"make TARGET\""
echo ""

