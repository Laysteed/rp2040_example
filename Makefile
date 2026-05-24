.PHONY: all clean flash

export PICO_SDK_PATH = $(HOME)/pico/pico-sdk

all:
	@mkdir -p build
	@cd build && cmake .. && make -j$(shell nproc)

	@# for nvim clangd
	@ln -sf build/compile_commands.json .

flash:
	@mkdir -p build
	@cd build && cmake .. && make flash
	@ln -sf build/compile_commands.json .

clean:
	@rm -rf build compile_commands.json

