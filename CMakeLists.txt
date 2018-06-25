# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

# Tool: rock-bridge
cmake_minimum_required(VERSION 3.3)

# Install source Python and JSON files
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/rockBridgeModule
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/python
)


install(
    FILES create_rock_bridge
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_READ
)
