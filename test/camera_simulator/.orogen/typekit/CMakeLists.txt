# Generated from orogen/lib/orogen/templates/typekit/CMakeLists.txt

##
# Header for typegen-generated typekits
#
# END if typekit.standalone?
##

# Manually define '-DIS_ROS_PACKAGE' or include the UseOrocos.cmake file to automatically detect&set this flag.
if ( IS_ROS_PACKAGE )
    # When we import a typekit in a ROS package, we expect it to be in the package/lib directory
    set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${${CMAKE_PROJECT_NAME}_SOURCE_DIR}/lib/orocos${OROCOS_SUFFIX}/types)
endif( IS_ROS_PACKAGE ) 

execute_process(COMMAND cmake -E create_symlink
    ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/camera_simulator)

include_directories(BEFORE ${CMAKE_CURRENT_BINARY_DIR})
include_directories(BEFORE ${CMAKE_CURRENT_SOURCE_DIR}/types)
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

include_directories(${OrocosRTT_INCLUDE_DIRS})
add_definitions(${OrocosRTT_CFLAGS_OTHER})
link_directories(${OrocosRTT_LIBRARY_DIRS})


# Now set up the dependencies
orogen_pkg_check_modules(CAMERA_IDS REQUIRED camera_ids)
include_directories(${CAMERA_IDS_INCLUDE_DIRS})
add_definitions(${CAMERA_IDS_CFLAGS_OTHER})
link_directories(${CAMERA_IDS_LIBRARY_DIRS})
orogen_pkg_check_modules(LOGGER_TASKS_GNULINUX REQUIRED logger-tasks-gnulinux)
include_directories(${LOGGER_TASKS_GNULINUX_INCLUDE_DIRS})
add_definitions(${LOGGER_TASKS_GNULINUX_CFLAGS_OTHER})

set(PKG_CFLAGS ${OrocosRTT_CFLAGS})

set(PKG_CFLAGS ${PKG_CFLAGS} ${CAMERA_IDS_CFLAGS})
        
    
set(PKG_CFLAGS ${PKG_CFLAGS} ${LOGGER_TASKS_GNULINUX_CFLAGS})
        
    
list(REMOVE_DUPLICATES PKG_CFLAGS)
string(REPLACE ";" "\" \"" PKG_CFLAGS "\"${PKG_CFLAGS}\"")

# Generate the base typekit shared library
set(libname camera_simulator-typekit-${OROCOS_TARGET})
add_library(${libname} SHARED
    Plugin.cpp
    ${TYPEKIT_ADDITIONAL_SOURCES}
    ${TOOLKIT_ADDITIONAL_SOURCES})

target_link_libraries(${libname} ${CAMERA_IDS_LIBRARIES})
target_link_libraries(${libname} ${OrocosRTT_LIBRARIES} ${TYPEKIT_ADDITIONAL_LIBRARIES} ${TOOLKIT_ADDITIONAL_LIBRARIES})
set_target_properties(${libname} PROPERTIES LINK_INTERFACE_LIBRARIES ${OrocosRTT_LIBRARIES})
set_target_properties(${libname} PROPERTIES INTERFACE_LINK_LIBRARIES ${OrocosRTT_LIBRARIES})
if(WITH_RPATH AND APPLE)
  set_target_properties( ${libname} PROPERTIES
    INSTALL_NAME_DIR "@rpath")
    SET(CMAKE_BUILD_WITH_INSTALL_RPATH ON)
endif()
set(PKG_CONFIG_FILE ${CMAKE_CURRENT_BINARY_DIR}/camera_simulator-typekit-${OROCOS_TARGET}.pc)
configure_file(camera_simulator-typekit.pc.in ${PKG_CONFIG_FILE} @ONLY)

install(TARGETS ${libname} LIBRARY DESTINATION lib/orocos${OROCOS_PKG_DIR}/types)
install(FILES Types.hpp Opaques.hpp
    DESTINATION include/orocos/camera_simulator)
install(FILES
    
    
    DESTINATION include/orocos/camera_simulator/typekit)


install(FILES types/camera_simulator/typekit/Types.hpp
    DESTINATION include/orocos/camera_simulator/typekit)

install(FILES types/camera_simulator/typekit/BoostSerialization.hpp
    DESTINATION include/orocos/camera_simulator/typekit)

install(FILES types/camera_simulator/typekit/Plugin.hpp
    DESTINATION include/orocos/camera_simulator/typekit)

install(FILES types/camera_simulator/TaskStates.hpp
    DESTINATION include/orocos/camera_simulator)
install(FILES ${PKG_CONFIG_FILE}
    DESTINATION lib/pkgconfig)
install(FILES camera_simulator.tlb
    camera_simulator.typelist
    DESTINATION share/orogen)


    add_subdirectory(transports/corba)
    
    add_subdirectory(transports/mqueue)
    
    add_subdirectory(transports/typelib)
    

# Force the user to regenerate its typekit if the inputs changed
set(TK_STAMP "${CMAKE_CURRENT_SOURCE_DIR}/stamp")
get_directory_property(include_path INCLUDE_DIRECTORIES)
foreach(dep camera_simulator/TaskStates.hpp)
    find_file(dep_full_path ${dep} PATHS ${include_path})
    if (NOT dep_full_path)
        message(FATAL_ERROR "cannot find ${dep} in ${include_path}. This should never happen, report this as an oroGen bug")
    endif()
    list(APPEND TYPEKIT_SOURCE_HEADERS ${dep_full_path})
    unset(dep_full_path CACHE)
endforeach()
add_custom_command(
    OUTPUT "${TK_STAMP}"
    DEPENDS ${TYPEKIT_SOURCE_HEADERS}
    COMMENT "Typekit input changed. Run make regen in your build directory first"
    COMMAND /bin/false)
add_custom_target(check-typekit-uptodate ALL DEPENDS "${TK_STAMP}")
add_dependencies(${libname} check-typekit-uptodate)

