cmake_minimum_required(VERSION 3.7)
project(example)

set(CMAKE_MODULE_PATH $ENV{CMAKEHELPERS_HOME}/cmake/Modules $ENV{STM32CMAKE_HOME}/cmake)

include(stm32f103c8t6)
include(stm32_project)

setup_stm32()
find_srcs()

####################################################################################################
# libopencm3 {

include(libopencm3)
include_directories(${libopencm3_INC_DIR})
link_directories(${libopencm3_LIB_DIR})
list(APPEND LIBS ${libopencm3_LIB_NAME})

# } libopencm3

####################################################################################################
# FreeRTOS {

include(freertos)
include_directories(${FREERTOS_INC_DIRS})
list(APPEND SOURCES ${FREERTOS_SOURCES})

# } FreeRTOS

build_exe(SRCS ${SOURCES} LIBS ${LIBS})
