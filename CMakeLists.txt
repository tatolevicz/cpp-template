cmake_minimum_required(VERSION 3.24)
set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)

project(template)

set(CMAKE_CXX_STANDARD 17)

include(cmake/template.cmake)

option(template_BUILD_TESTS "Build template tests" ON)
option(template_BUILD_EXAMPLES "Build template examples" ON)

add_library(${PROJECT_NAME}
  ${template_HEADERS}
  ${template_SRCS}
)

# EXAMPLE TO INCLUDE DEPS ON THE EXTERNAL FOLDER
## Include FetchContent module
#include(FetchContent)
#
## Set the base directory for external dependencies
#set(EXTERNAL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/external")
#
## Ensure the external directory exists
#file(MAKE_DIRECTORY ${EXTERNAL_DIR})

#message(STATUS "Fetching mgutils...")
#FetchContent_Declare(
#  mgutils
#  GIT_REPOSITORY https://github.com/MagiaTrade/mgutils.git
#  GIT_TAG master
#  SOURCE_DIR ${EXTERNAL_DIR}/mgutils
#)

#set(MGUTILS_BUILD_TESTS OFF)
#set(MGUTILS_BUILD_EXAMPLES OFF)
#set(MGUTILS_BUILD_WITH_LUA ON)
#set(MGUTILS_BUILD_WITH_SOL ON)
#FetchContent_MakeAvailable(mgutils)
#message(STATUS "mgutils fetched and made available.")

target_link_libraries(${PROJECT_NAME} PUBLIC
  mgutils
)

if(template_BUILD_EXAMPLES)
  add_subdirectory(examples/template_ex)
endif()

if(template_BUILD_TESTS)
  add_subdirectory(tests)
endif()
