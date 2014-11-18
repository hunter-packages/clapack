cmake_minimum_required(VERSION 2.8.4)
project(CLAPACK C)

enable_testing()
include(CTest)

if(WIN32 AND NOT CYGWIN)
  set(SECOND_SRC  ${CLAPACK_SOURCE_DIR}/INSTALL/winsecond.c)
  set(DSECOND_SRC  ${CLAPACK_SOURCE_DIR}/INSTALL/windsecnd.c)
  add_definitions(-DNO_ISATTY -DMSDOS -DUSE_CLOCK)
else()
  set(SECOND_SRC  ${CLAPACK_SOURCE_DIR}/INSTALL/second.c)
  set(DSECOND_SRC  ${CLAPACK_SOURCE_DIR}/INSTALL/dsecnd.c)
endif()

option(CLAPACK_BUILD_TESTS "Build tests" OFF)
option(USE_BLAS_WRAP "pre-pend f2c_ to each function in blas" OFF)
if(NOT USE_BLAS_WRAP)
# _zrotg_ seems to be missing in the wrap header
  add_definitions(-DNO_BLAS_WRAP)
endif()

include_directories(${CLAPACK_SOURCE_DIR}/INCLUDE)

add_subdirectory(F2CLIBS)
add_subdirectory(BLAS)
add_subdirectory(SRC)
if(CLAPACK_BUILD_TESTS)
  add_subdirectory(TESTING)
endif()

set(CLAPACK_VERSION 3.2.1)
set(CPACK_PACKAGE_VERSION_MAJOR 3)
set(CPACK_PACKAGE_VERSION_MINOR 2)
set(CPACK_PACKAGE_VERSION_PATCH 1)
include(CPack)

install(EXPORT CLAPACKTargets NAMESPACE CLAPACK:: DESTINATION lib/cmake/CLAPACK)
install(FILES CLAPACKConfig.cmake DESTINATION lib/cmake/CLAPACK)

install(
    FILES INCLUDE/blaswrap.h INCLUDE/clapack.h INCLUDE/f2c.h
    DESTINATION include
)
