include("${CMAKE_CURRENT_LIST_DIR}/CLAPACKTargets.cmake")

# Use release variant library in default case;
function(_apply_release_imported_config_as_default tgt)
  get_target_property(location ${tgt} IMPORTED_LOCATION_RELEASE)
  get_target_property(link ${tgt} IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE)
  if(NOT location)
    message(FATAL_ERROR "Release target `${tgt}` not installed")
  endif()
  set_target_properties(
      ${tgt}
      PROPERTIES
      IMPORTED_LOCATION "${location}"
  )
  if(link)
    set_target_properties(
        ${tgt}
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LIBRARIES "${link}"
    )
  endif()
endfunction()

_apply_release_imported_config_as_default(CLAPACK::f2c)
_apply_release_imported_config_as_default(CLAPACK::blas)
_apply_release_imported_config_as_default(CLAPACK::lapack)
