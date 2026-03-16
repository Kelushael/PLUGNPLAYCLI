cmake_minimum_required(VERSION 3.10)
project(Zaphod)

# Add executable
set(SOURCES server.cpp)
add_executable(plugnplay ${SOURCES})

# Windows specific
if(WIN32)
    target_compile_definitions(plugnplay PRIVATE _CRT_SECURE_NO_WARNINGS)
    target_link_libraries(plugnplay winmm.lib)
endif()

# Install target
install(TARGETS plugnplay DESTINATION bin)