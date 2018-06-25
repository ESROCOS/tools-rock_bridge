# Generated from orogen/lib/orogen/templates/typekit/corba/CMakeLists.txt


find_package(OrocosCORBA REQUIRED COMPONENTS Typekit)
INCLUDE_DIRECTORIES(${OrocosCORBA_INCLUDE_DIRS})
ADD_DEFINITIONS(${OrocosCORBA_DEFINES})

include_directories(${OrocosCORBA_INCLUDE_DIRS})
add_definitions(${OrocosCORBA_CFLAGS_OTHER})
link_directories(${OrocosCORBA_LIBRARY_DIRS})

orogen_pkg_check_modules(CAMERA_IDS REQUIRED camera_ids)
include_directories(${CAMERA_IDS_INCLUDE_DIRS})
add_definitions(${CAMERA_IDS_CFLAGS_OTHER})
link_directories(${CAMERA_IDS_LIBRARY_DIRS})
orogen_pkg_check_modules(LOGGER_TASKS_GNULINUX REQUIRED logger-tasks-gnulinux)
include_directories(${LOGGER_TASKS_GNULINUX_INCLUDE_DIRS})
add_definitions(${LOGGER_TASKS_GNULINUX_CFLAGS_OTHER})

# Set up generation of IDL files for CORBA support
IF (NOT OrocosCORBA_Typekit_FOUND)
    MESSAGE(FATAL_ERROR "could not find development files for Orocos/CORBA")
ENDIF(NOT OrocosCORBA_Typekit_FOUND)

set(CORBA_FILES ${CMAKE_CURRENT_BINARY_DIR}/camera_simulatorTypesC.cpp)
if(CORBA_IMPLEMENTATION STREQUAL "OMNIORB")
    list(APPEND CORBA_FILES ${CMAKE_CURRENT_BINARY_DIR}/camera_simulatorTypesDynSK.cpp)
endif(CORBA_IMPLEMENTATION STREQUAL "OMNIORB")

add_custom_command(OUTPUT ${CORBA_FILES}
    COMMAND ${OrocosCORBA_IDL} -Wbkeep_inc_path
        
        ${CMAKE_CURRENT_SOURCE_DIR}/camera_simulatorTypes.idl
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/camera_simulatorTypes.idl)

add_definitions(${OrocosCORBA_Typekit_DEFINES})
include_directories(${OrocosCORBA_Typekit_INCLUDE_DIRS})

# Generate the CORBA transport
set(libname_corba camera_simulator-transport-corba-${OROCOS_TARGET})
add_library(${libname_corba} SHARED
    Convertions.cpp
    TransportPlugin.cpp
    ${CORBA_FILES})
if (CXX_SUPPORTS_WUNUSED_VARIABLE)
    set_source_files_properties(${CORBA_FILES} TARGET_COMPILE_OPTIONS "-Wno-unused-variable")
endif()

target_link_libraries(${libname_corba}
    camera_simulator-typekit-${OROCOS_TARGET}
    ${OrocosCORBA_LIBRARIES})
if(WITH_RPATH AND APPLE)
  set_target_properties( ${libname_corba} PROPERTIES
    INSTALL_NAME_DIR "@rpath")
    SET(CMAKE_BUILD_WITH_INSTALL_RPATH ON)
endif()

target_link_libraries(${libname_corba} ${CAMERA_IDS_LIBRARIES})
set_target_properties(${libname_corba} PROPERTIES LINK_INTERFACE_LIBRARIES ${OrocosCORBA_LIBRARIES})
set_target_properties(${libname_corba} PROPERTIES INTERFACE_LINK_LIBRARIES ${OrocosCORBA_LIBRARIES})

SET(PKG_CONFIG_FILE_CORBA ${CMAKE_CURRENT_BINARY_DIR}/camera_simulator-transport-corba-${OROCOS_TARGET}.pc)
CONFIGURE_FILE(camera_simulator-transport-corba.pc.in ${PKG_CONFIG_FILE_CORBA} @ONLY)

install(TARGETS ${libname_corba} LIBRARY DESTINATION lib/orocos${OROCOS_PKG_DIR}/types)
install(FILES ${PKG_CONFIG_FILE_CORBA} DESTINATION lib/pkgconfig)
install(FILES
    TransportPlugin.hpp
    camera_simulatorTypes.idl
    ${CMAKE_CURRENT_BINARY_DIR}/camera_simulatorTypesC.h
    DESTINATION include/orocos/camera_simulator/transports/corba)

