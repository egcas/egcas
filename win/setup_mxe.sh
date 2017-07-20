#!/bin/bash -e

SCR_BASE_DIR=$(dirname "${0}")
EGCAS_META_DIR=$(realpath "${SCR_BASE_DIR}/../")


MXE_BUILD_DIR="build_mxe"
MXE_CONFIG_FILE="mxe_config_file.txt"

if ! [ -d "${EGCAS_META_DIR}/win/" ]; then
        echo "${0} script not existing at expected place."
        exit 1
fi

MXE_ABS_BUILD_DIR="${EGCAS_META_DIR}/${MXE_BUILD_DIR}"

if [ -d "${MXE_ABS_BUILD_DIR}" ]; then
        echo "mxe build dir ${MXE_BUILD_DIR} already exists..."
        exit 2
fi

sudo apt-get install autoconf automake autopoint bash bison bzip2 cmake flex gettext git g++ gperf intltool libffi-dev libtool libltdl-dev libssl-dev libxml-parser-perl make openssl p7zip-full patch perl pkg-config python ruby scons sed unzip wget xz-utils g++-multilib libc6-dev-i386 libtool-bin libgtk2.0-dev

cd "${EGCAS_META_DIR}"
mkdir "${MXE_BUILD_DIR}"
cd "${MXE_BUILD_DIR}"
git clone https://github.com/mxe/mxe.git
cd mxe
MXE_INSTALL_PATH=${PWD}
make MXE_TARGETS='x86_64-w64-mingw32.shared' cmake qt5 gcc gdb boost nsis 

#setup config vars and write config file
echo export MXE_INSTALL_PATH="${MXE_INSTALL_PATH}" >> "${MXE_ABS_BUILD_DIR}/${MXE_CONFIG_FILE}"
echo export PATH="${MXE_INSTALL_PATH}"/usr/bin:${PATH} >> "${MXE_ABS_BUILD_DIR}/${MXE_CONFIG_FILE}"
echo export MXE_COMMON_INSTALL_PATH="${MXE_INSTALL_PATH}/usr/x86_64-w64-mingw32.shared/" >> "${MXE_ABS_BUILD_DIR}/${MXE_CONFIG_FILE}"
echo export MXE_QT_INSTALL_PATH="${MXE_COMMON_INSTALL_PATH}/qt5/" >> "${MXE_ABS_BUILD_DIR}/${MXE_CONFIG_FILE}"
source "${MXE_ABS_BUILD_DIR}/${MXE_CONFIG_FILE}"

cp /usr/include/FlexLexer.h "${MXE_INSTALL_PATH}"/usr/x86_64-w64-mingw32.shared/include/

# copy runtime libraries to runtime pos
cd "${MXE_ABS_BUILD_DIR}"
MXE_RUNTIME_DIR="${MXE_ABS_BUILD_DIR}/runtime/"
mkdir "${MXE_RUNTIME_DIR}"
cd "${MXE_RUNTIME_DIR}"
cp "${MXE_QT_INSTALL_PATH}/bin/Qt5Gui.dll" .
cp "${MXE_QT_INSTALL_PATH}/bin/Qt5Xml.dll" .
cp "${MXE_QT_INSTALL_PATH}/bin/Qt5Test.dll" .
cp "${MXE_QT_INSTALL_PATH}/bin/Qt5Core.dll" .
cp "${MXE_QT_INSTALL_PATH}/bin/Qt5Svg.dll" .
cp "${MXE_QT_INSTALL_PATH}/bin/Qt5Widgets.dll" .
cp -r "${MXE_QT_INSTALL_PATH}/plugins/platforms/" ./platforms/
cp "${MXE_COMMON_INSTALL_PATH}/bin/libfreetype-6.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libfreetype-6.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libglib-2.0-0.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libharfbuzz-icu-0.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libintl-8.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libpcre16-0.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libpng16-16.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libbz2.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libgcc_s_sjlj-1.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libharfbuzz-1.dll" ./libharfbuzz-0.dll
cp "${MXE_COMMON_INSTALL_PATH}/bin/libiconv-2.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libmmlegcas.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libpcre-1.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/libstdc++-6.dll" .
cp "${MXE_COMMON_INSTALL_PATH}/bin/zlib1.dll" .
    
  
echo "mxe setup successful!"

