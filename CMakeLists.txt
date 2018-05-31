cmake_minimum_required(VERSION 2.8.11)

##############################################################################

set(CMAKE_BUILD_TYPE Release)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(EGCAS_VERSION "0.0.2")

##############################################################################
##############################################################################
# set egcas version as define for C++ program
add_definitions(-DEGCAS_VERSION="${EGCAS_VERSION}")
set(MAXIMA_INST_PATH maxima_installation)

add_subdirectory(libmml_egcas)
add_subdirectory(egcas-core)
add_subdirectory(egcas_maxima)

set(CPACK_PACKAGE_NAME "egcas")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "* egcas is a Easy to use Graphical Computer Algebra System.")
set(CPACK_PACKAGE_VENDOR "Johannes Maier")
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        set(CPACK_DEBIAN_PACKAGE_DEPENDS "libqt5widgets5,libqt5xml5,libqt5printsupport5,libqt5network5,libqt5multimedia5,sbcl,xdg-utils")
        set(CPACK_GENERATOR "DEB")
        set(PACKAGE_OS "linux")
        if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64")
                set(CPACK_SYSTEM_NAME "${PACKAGE_OS}-amd64")
        endif()
        if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "i386")
                set(CPACK_SYSTEM_NAME "${PACKAGE_OS}-i386")
        endif()
        set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Johannes Maier <maier_jo@gmx.de>")
        set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_CURRENT_SOURCE_DIR}/desktop/postinst;${CMAKE_CURRENT_SOURCE_DIR}/desktop/prerm")
        install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/pics/egcas_32x32.png DESTINATION /usr/share/pixmaps)
        install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/desktop/egcas.desktop DESTINATION /usr/share/applications)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set(CPACK_PACKAGE_INSTALL_DIRECTORY "egcas")
        set(CPACK_COMPONENT_APPLICATIONS_DISPLAY_NAME "EgCAS")
        set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/egcas-core/LICENSE")

        set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/pics/egcas_32x32.bmp")
        set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}/pics/egcas_32x32.ico")
        set(CPACK_NSIS_MUI_UNIICON "${CMAKE_SOURCE_DIR}/pics/egcas_32x32.ico")

        set(CPACK_NSIS_MENU_LINKS "bin\\\\egcas.exe" "EgCAS"
                                  "Uninstall.exe" "uninstall EgCAS")
endif()
set(CPACK_PACKAGE_VERSION ${EGCAS_VERSION})

include(CPack)


