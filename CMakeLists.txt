cmake_minimum_required(VERSION 2.8)
project(mysql)

set(MYSQL_PLUGIN_VERSION "R40")

option (BUILD_TESTS "Build tests" OFF)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

#include(CheckIncludeFile)

find_package(MySQLCConnector 6.1.5 REQUIRED)

set(Boost_USE_STATIC_LIBS ON)
find_package(Boost 1.57 REQUIRED 
	COMPONENTS thread chrono date_time system atomic filesystem)

#check_include_file("stdint.h" HAVE_STDINT_H)
#if(NOT DEFINED HAVE_STDINT_H)
#	message(FATAL_ERROR "stdint.h couldn't be found")
#endif()

include_directories("${Boost_INCLUDE_DIR}" "${MYSQLCCONNECTOR_INCLUDE_DIR}")
link_directories("${Boost_LIBRARY_DIRS}" "${MYSQLCCONNECTOR_LIBRARY_DIR}")

add_subdirectory(src)
