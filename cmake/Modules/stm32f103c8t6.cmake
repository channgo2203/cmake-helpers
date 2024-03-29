function(print_compile_flags)
  message(STATUS "CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")
  message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
  message(STATUS "CMAKE_C_FLAGS_DEBUG: ${CMAKE_C_FLAGS_DEBUG}")
  message(STATUS "CMAKE_CXX_FLAGS_DEBUG: ${CMAKE_CXX_FLAGS_DEBUG}")
  message(STATUS "CMAKE_C_FLAGS_RELEASE: ${CMAKE_C_FLAGS_RELEASE}")
  message(STATUS "CMAKE_CXX_FLAGS_RELEASE: ${CMAKE_CXX_FLAGS_RELEASE}")
  message(STATUS "CMAKE_EXE_LINKER_FLAGS: ${CMAKE_EXE_LINKER_FLAGS}")
  message(STATUS "CMAKE_MODULE_LINKER_FLAGS: ${CMAKE_MODULE_LINKER_FLAGS}")
  message(STATUS "CMAKE_SHARED_LINKER_FLAGS: ${CMAKE_SHARED_LINKER_FLAGS}")
  message(STATUS "CMAKE_STATIC_LINKER_FLAGS: ${CMAKE_STATIC_LINKER_FLAGS}")
  message(STATUS "STM32_LINKER_SCRIPT: ${STM32_LINKER_SCRIPT}")
endfunction()

# Sets "-Og -g". Disable it as "-Og" level causes BluePill to lock up for unknown reason.
set(CMAKE_C_FLAGS_DEBUG "")
set(CMAKE_CXX_FLAGS_DEBUG "")
# Sets "-Os -flto" when CMAKE_BUILD_TYPE=Release, but causes symbol vTaskSwitchContext disappear
set(CMAKE_C_FLAGS_RELEASE "")
set(CMAKE_CXX_FLAGS_RELEASE "")

if (CMAKE_BUILD_TYPE MATCHES Release)
  set(O_FLAGS "-Os")
endif ()
if (CMAKE_BUILD_TYPE MATCHES Debug)
  # WARNING: Do NOT change optimization level to -00, the board will stuck in hard fault handler
  set(O_FLAGS "-Os -g")
endif ()

set(M_FLAGS "-mthumb -mcpu=cortex-m3 -mabi=aapcs -msoft-float -mfix-cortex-m3-ldrd -MD")
set(F_FLAGS "-fno-builtin -ffunction-sections -fdata-sections -fno-common -fomit-frame-pointer")
set(F_FLAGS "${F_FLAGS} -fno-unroll-loops -ffast-math -ftree-vectorize -fno-exceptions")
set(F_FLAGS "${F_FLAGS} -fno-unwind-tables")
set(W_FLAGS "-Wall -Wextra -Wshadow -Wredundant-decls")

set(CMAKE_CXX_FLAGS "${O_FLAGS} ${M_FLAGS} ${F_FLAGS} ${W_FLAGS}")
set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS}")

# From book: -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group")
set(LD_FLAGS "--static -nostartfiles -specs=nosys.specs")
set(LD_FLAGS "${LD_FLAGS} -Wl,-Map=${PROJECT_NAME}.map -Wl,--gc-sections")
set(CMAKE_EXE_LINKER_FLAGS "${LD_FLAGS}")
