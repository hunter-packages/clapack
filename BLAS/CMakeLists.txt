add_subdirectory(SRC)
if(CLAPACK_BUILD_TESTS)
  add_subdirectory(TESTING)
endif()
