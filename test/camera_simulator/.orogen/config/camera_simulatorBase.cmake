include(OrogenPkgCheckModules)
ADD_CUSTOM_TARGET(regen
    
    ruby2.3 -S orogen --corba --extensions=metadata_support --import=std --no-rtt-scripting --parallel-build=2 --transports=corba,mqueue,typelib --type-export-policy=used /home/esrocos/esrocos_workspace/drivers/orogen/camera_simulator/camera_simulator.orogen
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_custom_command(
    OUTPUT ${PROJECT_SOURCE_DIR}/.orogen/camera_simulator.orogen
    DEPENDS /home/esrocos/esrocos_workspace/drivers/orogen/camera_simulator/camera_simulator.orogen
    COMMENT "oroGen specification file changed. Run make regen first."
    COMMAND /bin/false)

add_custom_target(check-uptodate ALL
    DEPENDS "${PROJECT_SOURCE_DIR}/.orogen/camera_simulator.orogen")

# In Orogen project, the build target is specified at generation time
set(OROCOS_TARGET "gnulinux")

# Enable -Wall for compilers that know it
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-Wall" CXX_SUPPORTS_WALL)
if (CXX_SUPPORTS_WALL)
    add_definitions ("-Wall")
endif()
CHECK_CXX_COMPILER_FLAG("-Wno-unused-local-typedefs" CXX_SUPPORTS_WUNUSED_LOCAL_TYPEDEFS)
if (CXX_SUPPORTS_WUNUSED_LOCAL_TYPEDEFS)
    add_definitions ("-Wno-unused-local-typedefs")
endif()
check_cxx_compiler_flag("-Wunused-variable" CXX_SUPPORTS_WUNUSED_VARIABLE)

if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    message(STATUS "running on Linux, implementing the __orogen_getTID() operation on all tasks")
    add_definitions(-DHAS_GETTID)
else()
    message(STATUS "NOT running on Linux (cmake reports ${CMAKE_SYSTEM_NAME}). The __orogen_getTID() operation will be a dummy")
endif()

# Define the necessary RPath information for all binaries. That can be stripped
# later
option(WITH_RPATH "enables or disables embedding RPath information in binaries" ON)
if(WITH_RPATH)
    include(RPATHHandling)
    CMAKE_USE_FULL_RPATH("${CMAKE_INSTALL_PREFIX}/lib:${CMAKE_INSTALL_PREFIX}/lib/orocos:${CMAKE_INSTALL_PREFIX}/lib/orocos/types")
endif(WITH_RPATH)

# Set the build type to debug by default
IF ( NOT CMAKE_BUILD_TYPE )
  SET( CMAKE_BUILD_TYPE Debug )
ENDIF ( NOT CMAKE_BUILD_TYPE )

# Check for Doxygen and enable documentation building if available
FIND_PACKAGE( Doxygen )
IF ( DOXYGEN_FOUND )
  MESSAGE(STATUS "documentation can be built" )
  CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/Doxyfile.in ${PROJECT_BINARY_DIR}/Doxyfile @ONLY)
  ADD_CUSTOM_TARGET(doc doxygen Doxyfile)
ELSE ( DOXYGEN_FOUND )
  MESSAGE(STATUS "documentation generation disabled" )
ENDIF ( DOXYGEN_FOUND )

#
# Start setting up the build itself
#

# First, we need the Orocos::RTT, and optionally the CORBA part
orogen_pkg_check_modules(OrocosRTT REQUIRED "orocos-rtt-${OROCOS_TARGET}>=2.1.0")

# Add generic include directories
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_CURRENT_SOURCE_DIR})
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_CURRENT_SOURCE_DIR}/.orogen/)

# Take care of the typekit
ADD_SUBDIRECTORY( ${CMAKE_CURRENT_SOURCE_DIR}/.orogen/typekit )
INCLUDE_DIRECTORIES(BEFORE "${CMAKE_CURRENT_SOURCE_DIR}/.orogen/typekit")
INCLUDE_DIRECTORIES(BEFORE "${CMAKE_CURRENT_SOURCE_DIR}/.orogen/typekit/types")
add_dependencies(check-uptodate check-typekit-uptodate)

# Take care of the task library
ADD_SUBDIRECTORY(${CMAKE_CURRENT_SOURCE_DIR}/tasks)


configure_file(.orogen/orogen-project-camera_simulator.pc.in
    orogen-project-camera_simulator.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/orogen-project-camera_simulator.pc
    DESTINATION lib/pkgconfig)

INSTALL(FILES ${PROJECT_SOURCE_DIR}/.orogen/camera_simulator.orogen
    DESTINATION share/orogen)

# Finally, add deployment code
include(.orogen/config/orogen_default_camera_simulator__CameraDriverDeployment.cmake)

# Install typelib and/or Roby plugins
if (EXISTS ${PROJECT_SOURCE_DIR}/scripts/typelib.rb)
    install(FILES ${PROJECT_SOURCE_DIR}/scripts/typelib.rb
        DESTINATION share/typelib/ruby
        RENAME camera_simulator.rb)
endif()
if (EXISTS ${PROJECT_SOURCE_DIR}/scripts/roby.rb)
    install(FILES ${PROJECT_SOURCE_DIR}/scripts/roby.rb
        DESTINATION share/orocos/roby
        RENAME camera_simulator.rb)
endif()

