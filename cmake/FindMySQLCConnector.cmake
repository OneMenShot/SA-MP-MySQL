# Look for MySQL C Connector
# Once done, this will define
#
#  MYSQLCCONNECTOR_FOUND - system has MySQL-C-Connector
#  MYSQLCCONNECTOR_INCLUDE_DIR - MySQL-C-Connector include directories
#  MYSQLCCONNECTOR_LIBRARY_DIR - MySQL-C-Connector libraries directories
#
# The user may wish to set, in the CMake GUI or otherwise, this variable:
#  MYSQLCCONNECTOR_ROOT_DIR - path to start searching for the module

set(MYSQLCCONNECTOR_ROOT_DIR
	"${MYSQLCCONNECTOR_ROOT_DIR}"
	CACHE
	PATH
	"Where to start looking for this component."
)

if(WIN32)
    find_path(
		MYSQLCCONNECTOR_INCLUDE_DIR
		NAMES
		mysql_version.h
		PATHS
		"C:\\Program Files"
		HINTS
		${MYSQLCCONNECTOR_ROOT_DIR}
		PATH_SUFFIXES
		include
	)

    find_path(
		MYSQLCCONNECTOR_LIBRARY_DIR
		NAMES
		libmysql.lib
		HINTS
		${MYSQLCCONNECTOR_ROOT_DIR}
		PATH_SUFFIXES
		lib
	)
else()
    find_path(
		MYSQLCCONNECTOR_INCLUDE_DIR
		mysql_version.h
		HINTS
		${MYSQLCCONNECTOR_ROOT_DIR}
		PATH_SUFFIXES
		include
	)

    find_library(
		MYSQLCCONNECTOR_LIBRARY_DIR
		NAMES
		mysqlclient
		HINTS
		${MYSQLCCONNECTOR_ROOT_DIR}
		PATH_SUFFIXES
		lib
	)
endif()

mark_as_advanced(
	MYSQLCCONNECTOR_INCLUDE_DIR
	MYSQLCCONNECTOR_LIBRARY_DIR
)

if(MYSQLCCONNECTOR_INCLUDE_DIR)
	set(_mysqlcc_VERSION_STRING "")
	file(
		STRINGS 
		"${MYSQLCCONNECTOR_INCLUDE_DIR}/mysql_version.h" 
		_mysqlcc_VERSION_H_CONTENTS 
		REGEX "#define BOOST_LIB_VERSION \"([0-9_]+)\""
	)
	if(_mysqlcc_VERSION_H_CONTENTS)
		set(MYSQLCCONNECTOR_VERSION "${CMAKE_MATCH_1}")
	endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
	MySQLCConnector
	REQUIRED_VARS
		MYSQLCCONNECTOR_INCLUDE_DIR
		MYSQLCCONNECTOR_LIBRARY_DIR
	VERSION_VAR
		MYSQLCCONNECTOR_VERSION
)

if(MYSQLCCONNECTOR_FOUND)
    mark_as_advanced(MYSQLCCONNECTOR_ROOT_DIR)
endif() 
