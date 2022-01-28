cmake_minimum_required(VERSION 3.0)
project(wikiracer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(cpr CONFIG REQUIRED)
option(TEST_WIKISCRAPER "Test wikiracer only" OFF)

if(TEST_WIKISCRAPER)
    message("Building Wikiscraper Test")
    add_executable(test test-wikiscraper.cpp wikiscraper.cpp error.cpp)
    target_link_libraries(test PRIVATE cpr::cpr)
else()
    message("Building Entire Project")
    add_executable(main main.cpp wikiscraper.cpp error.cpp)
    target_link_libraries(main PRIVATE cpr::cpr)
endif()

