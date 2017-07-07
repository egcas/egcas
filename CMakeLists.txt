cmake_minimum_required(VERSION 2.8.11)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(MAXIMA_INST_PATH maxima_installation)

add_subdirectory(libmml_egcas)
add_subdirectory(egCAS)
add_subdirectory(egcas_maxima)


set(CPACK_PACKAGE_NAME "egcas")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "* egcas is a Easy to use Graphical Computer Algebra System.")
set(CPACK_DEBIAN_PACKAGE_DEPENDS libmmlegcas libqt5widgets5 libqt5xml5 libqt5printsupport5)
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        install(PROGRAMS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/bin/egcas-maxima DESTINATION /usr/bin/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/bin/egcas DESTINATION /usr/bin/ PATTERN * PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/lib/ DESTINATION /usr/lib/ PATTERN lisp.run EXCLUDE)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/lib/ DESTINATION /usr/lib/ PATTERN lisp.run PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/share/ DESTINATION /usr/share/)
        set(CPACK_GENERATOR "DEB")
        set(PACKAGE_OS "linux")
        if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "x86_64")
                set(CPACK_SYSTEM_NAME "${PACKAGE_OS}-amd64")
        endif()
        if (${CMAKE_SYSTEM_PROCESSOR} MATCHES "i386")
                set(CPACK_SYSTEM_NAME "${PACKAGE_OS}-i386")
        endif()
endif()
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Johannes Maier <maier_jo@gmx.de>")
set(CPACK_PACKAGE_VERSION "0.0.2")

include(CPack)


