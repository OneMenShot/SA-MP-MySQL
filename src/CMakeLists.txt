include(AmxConfig)
include(Plugin)
include(FindSDK)

option(BUILD_STATIC "Build static library" OFF)

set(SAMP_SDK_DIR "../libs")
find_package(SDK REQUIRED)

include_directories("${SDK_INCLUDE_DIR}")

set(CMAKE_DEBUG_POSTFIX "_d")

add_plugin(mysql 
	${SDK_INCLUDE_DIR}/amxplugin.cpp
	${SDK_INCLUDE_DIR}/amxplugin2.cpp
	${SDK_INCLUDE_DIR}/amx/getch.c
	CCallback.cpp
	CConnection.cpp
	CDispatcher.cpp
	CHandle.cpp
	CLog.cpp
	COptions.cpp
	COrm.cpp
	CQuery.cpp
	CResult.cpp
	CScripting.cpp
	main.cpp
	misc.cpp
	plugin.def
)

if(MSVC)
	target_compile_definitions(mysql PUBLIC _CRT_SECURE_NO_WARNINGS NOMINMAX)
endif()
target_compile_definitions(mysql PUBLIC DLL_EXPORTS)

if(NOT WIN32) #we have auto-linking on Windows
	target_link_libraries(mysql
		boost_thread
		boost_chrono
		boost_date_time
		boost_system
		boost_atomic
		boost_filesystem
	)
	if(BUILD_STATIC)
		add_library(libmysql STATIC IMPORTED)
	else()
		add_library(libmysql SHARED IMPORTED)
	endif()
endif()
target_link_libraries(mysql libmysql)

install(TARGETS mysql DESTINATION plugins/)
install(FILES "../a_mysql.inc" DESTINATION pawno/include/)

set(CPACK_PACKAGE_VERSION ${MYSQL_PLUGIN_VERSION})
if(WIN32)
	set(CPACK_GENERATOR ZIP)
else()
	set(CPACK_GENERATOR TGZ)
endif()

include(CPack)