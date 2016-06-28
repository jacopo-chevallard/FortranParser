# CMake project file for mt_stream
cmake_minimum_required ( VERSION 2.6 )
project ( FortranParser )
enable_language ( Fortran )

# Set the CMAKE_MODULE_PATH
MESSAGE( STATUS "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
LIST ( APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )

set(ENABLE_TESTING ON CACHE INTERNAL "flag to enable unit tests")

# Check that when using GNU Fortran the free form flag is passed
if ( NOT Fortran_FLAGS_ARE_SET )
  if ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
    include( GNU_Fortran_Flags )
  elseif ( CMAKE_Fortran_COMPILER_ID STREQUAL Intel )
    include( Intel_Fortran_Flags )
  endif ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
endif ( NOT Fortran_FLAGS_ARE_SET )

if ( NOT RPATH_CONFIG )
  include ( General_rpath_config ) 
endif ( NOT RPATH_CONFIG )


# Set library name
set ( LIBRARY_NAME FortranParser )

# Find all *f90 files
FILE(GLOB SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
      "${CMAKE_CURRENT_SOURCE_DIR}/src/*.f90")

# Command to build the library
add_library(
  ${LIBRARY_NAME}
  SHARED
  ${SRC_FILES}
)

# install library
install(
  TARGETS ${LIBRARY_NAME} 
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)

# install header (*mod) files
install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ 
  DESTINATION include
)

# install the configuration file
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/cmake/${LIBRARY_NAME}_meta_info.nl
  DESTINATION share/info
  COMPONENT config
  )

# set variables which will be sued by a calling CMakeLists.txt file
set ( FORTRANPARSER_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE INTERNAL "FORTRANPARSER include directory" )
set ( FORTRANPARSER_LIBRARIES_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE INTERNAL "FORTRANPARSER library directory" )
set ( FORTRANPARSER_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "FORTRANPARSER library" )

# *******************************************
# ************* UNINSTALL THE LIBRARY *******
# *******************************************
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)

add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake/cmake_uninstall.cmake)

# **************************************************
# ************* EXTRACT THE PACKAGE VERSION FROM THE GIT TAG
# **************************************************
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${LIBRARY_NAME}_meta_info.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake/${LIBRARY_NAME}_meta_info.cmake"
)

add_custom_command(TARGET ${LIBRARY_NAME} PRE_BUILD COMMAND cmake -P ${CMAKE_CURRENT_BINARY_DIR}/cmake/${LIBRARY_NAME}_meta_info.cmake)

# Testing routine
if (ENABLE_TESTING)
  enable_testing( )

  add_executable( test0 "${CMAKE_CURRENT_SOURCE_DIR}/src/tests/testfp.f90" )
  target_link_libraries( test0 ${LIBRARY_NAME} )
  add_test( test0 test0 )

  add_executable( test1 "${CMAKE_CURRENT_SOURCE_DIR}/src/tests/testfp1.f90" )
  target_link_libraries( test1 ${LIBRARY_NAME} )
  add_test( test1 test1 )

  add_executable( test2 "${CMAKE_CURRENT_SOURCE_DIR}/src/tests/testfp2.f90" )
  target_link_libraries( test2 ${LIBRARY_NAME} )
  add_test( test2 test2 )

  add_executable( test3 "${CMAKE_CURRENT_SOURCE_DIR}/src/tests/testfp3.f90" )
  target_link_libraries( test3 ${LIBRARY_NAME} )
  add_test( test3 test3 )

  add_executable( test4 "${CMAKE_CURRENT_SOURCE_DIR}/src/tests/testfp4.f90" )
  target_link_libraries( test4 ${LIBRARY_NAME} )
  add_test( test4 test4 )

  add_executable( test5 "${CMAKE_CURRENT_SOURCE_DIR}/src/tests/testfp5.f90" )
  target_link_libraries( test5 ${LIBRARY_NAME} )
  add_test( test5 test5 )
endif(ENABLE_TESTING)



