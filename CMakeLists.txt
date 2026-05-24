cmake_minimum_required(VERSION 3.13)

set(MY_PROJECT_NAME "rp2040_example")

set(PICO_SDK_PATH "$ENV{HOME}/pico/pico-sdk")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(${PICO_SDK_PATH}/pico_sdk_init.cmake)
project(${MY_PROJECT_NAME} C CXX ASM)

pico_sdk_init()

add_executable(${PROJECT_NAME} src/main.c)

pico_enable_stdio_usb(${PROJECT_NAME} 1)
target_link_libraries(${PROJECT_NAME} pico_stdlib)
pico_add_extra_outputs(${PROJECT_NAME})

add_custom_target(flash
    COMMAND picotool load -f -x ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.uf2
    DEPENDS ${PROJECT_NAME}
    COMMENT "flashing..."
)

