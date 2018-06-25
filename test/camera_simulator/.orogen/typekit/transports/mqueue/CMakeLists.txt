# Generated from orogen/lib/orogen/templates/typekit/mqueue/CMakeLists.txt

# OrocosRTT_PREFIX has been set by the pkg-config find modules:
find_package(OROCOS-RTT REQUIRED rtt-transport-mqueue HINTS ${OrocosRTT_PREFIX}/lib/cmake/orocos-rtt)

orogen_pkg_check_modules(CAMERA_IDS REQUIRED camera_ids)
include_directories(${CAMERA_IDS_INCLUDE_DIRS})
add_definitions(${CAMERA_IDS_CFLAGS_OTHER})
link_directories(${CAMERA_IDS_LIBRARY_DIRS})
orogen_pkg_check_modules(LOGGER_TASKS_GNULINUX REQUIRED logger-tasks-gnulinux)
include_directories(${LOGGER_TASKS_GNULINUX_INCLUDE_DIRS})
add_definitions(${LOGGER_TASKS_GNULINUX_CFLAGS_OTHER})

orogen_pkg_check_modules(RTT_Typelib REQUIRED rtt_typelib-${OROCOS_TARGET})
include_directories(${RTT_Typelib_INCLUDE_DIRS})
link_directories(${RTT_Typelib_LIBRARY_DIRS})

# Set up generation of IDL files for MQueue support
IF (NOT OROCOS-RTT_MQUEUE_FOUND)
    MESSAGE(FATAL_ERROR "could not find development files for Orocos/MQueue. Please compile the RTT with MQueue support.")
ENDIF(NOT OROCOS-RTT_MQUEUE_FOUND)

set(MQueue_FILES "")

# Generate the MQueue transport
set(libname_mqueue camera_simulator-transport-mqueue-${OROCOS_TARGET})
add_library(${libname_mqueue} SHARED
    TransportPlugin.cpp
    ${MQueue_FILES})
target_link_libraries(${libname_mqueue}
    camera_simulator-typekit-${OROCOS_TARGET}
    camera_simulator-transport-typelib-${OROCOS_TARGET}
    ${OROCOS-RTT_MQUEUE_LIBRARIES}
    ${RTT_Typelib_LIBRARIES})

target_link_libraries(${libname_mqueue} ${CAMERA_IDS_LIBRARIES})

SET(PKG_CONFIG_FILE_MQueue ${CMAKE_CURRENT_BINARY_DIR}/camera_simulator-transport-mqueue-${OROCOS_TARGET}.pc)
CONFIGURE_FILE(camera_simulator-transport-mqueue.pc.in ${PKG_CONFIG_FILE_MQueue} @ONLY)

install(TARGETS ${libname_mqueue} LIBRARY DESTINATION lib/orocos${OROCOS_PKG_DIR}/types)
install(FILES ${PKG_CONFIG_FILE_MQueue} DESTINATION lib/pkgconfig)
install(FILES
    TransportPlugin.hpp
    DESTINATION include/orocos/camera_simulator/transports/mqueue)

