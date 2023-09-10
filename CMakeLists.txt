cmake_minimum_required(VERSION 2.6.0)
project(dbm)

include(CheckCXXSourceCompiles)
include (CheckCXXCompilerFlag)

check_cxx_compiler_flag(-fvisibility=hidden __DBUSMENU_HAVE_GCC_VISIBILITY)
if (__DBUSMENU_HAVE_GCC_VISIBILITY AND NOT WIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden")
endif (__DBUSMENU_HAVE_GCC_VISIBILITY AND NOT WIN32)

check_cxx_compiler_flag(-Woverloaded-virtual __DBUSMENU_HAVE_W_OVERLOADED_VIRTUAL)
if (__DBUSMENU_HAVE_W_OVERLOADED_VIRTUAL)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Woverloaded-virtual")
endif (__DBUSMENU_HAVE_W_OVERLOADED_VIRTUAL)

check_cxx_compiler_flag(-Wall __DBUSMENU_HAVE_W_ALL)
if (__DBUSMENU_HAVE_W_ALL)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif (__DBUSMENU_HAVE_W_ALL)


find_library(LIB_GLIB NAMES glib libglib libglib-2.0.so.0 PATHS /usr/local/lib)
MESSAGE("LIB_GLIB: " ${LIB_GLIB})
find_library(LIB_GTK NAMES  libgtk-3.so PATHS /usr/local/lib)
MESSAGE("LIB_GTK: " ${LIB_GTK})
find_library(LIB_GDK NAMES  libgdk-3.so PATHS /usr/local/lib)
MESSAGE("LIB_GDK: " ${LIB_GDK})

set(LIB_DBUSMENU "${PROJECT_SOURCE_DIR}/libdbusmenu/libdbusmenu-glib/.libs/libdbusmenu-glib.a")
#set(LIB_DBUSMENU "/usr/local/lib/libdbusmenu-glib.so")

find_library(LIB_GIO NAMES libgio-2.0.so.0 PATHS /usr/local/lib)
MESSAGE("LIB_GIO: " ${LIB_GIO})

find_library(LIB_GOBJ NAMES libgobject-2.0.so.0 PATHS /usr/local/lib)
MESSAGE("LIB_GOBJ: " ${LIB_GOBJ})

set(GLIB_INCLUDE_DIRS /usr/local/include/glib-2.0 /usr/local/lib/glib-2.0/include)
set(DBUSMENU_GLIB_INCLUDE_DIRS /usr/local/include/libdbusmenu-glib-0.4)

include_directories(
        ${GLIB_INCLUDE_DIRS}
        ${DBUSMENU_GLIB_INCLUDE_DIRS}
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES DbusMenuWrapper.c)
find_package(X11 REQUIRED)
link_libraries(${X11_LIBRARIES})
include_directories(${X11_INCLUDE_DIR})
add_library(dbm SHARED ${SOURCE_FILES})
target_link_libraries(dbm ${LIB_GLIB} ${LIB_GIO} ${LIB_DBUSMENU} ${LIB_GOBJ})

add_executable(dbmexec test.cc)
target_include_directories(dbmexec PUBLIC "/usr/local/include/gtk-3.0" "/usr/local/include/gdk-3" "/usr/local/include/pango-1.0" "/usr/local/include/harfbuzz" "/usr/local/include/cairo" "/usr/local/include/gdk-pixbuf-2.0/" "/usr/local/include/atk-1.0/")
target_link_libraries(dbmexec dbm ${LIB_GLIB} ${LIB_GIO} ${LIB_DBUSMENU} ${LIB_DBUSMENU_GTK} ${LIB_GOBJ} ${LIB_GTK} ${LIB_GDK} ${LIB_GDK})

add_custom_command(TARGET dbm POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
        $<TARGET_FILE:dbm> libdbm64.so)
add_custom_command(TARGET dbm POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
        $<TARGET_FILE:dbm> libdbm64.so)
