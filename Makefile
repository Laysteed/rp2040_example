.PHONY: all clean flash serial

export PICO_SDK_PATH = $(HOME)/pico/pico-sdk
PORT = /dev/ttyACM0

all:
	@mkdir -p build
	@cd build && cmake .. && make -j$(shell nproc)

	@# for clangd
	@ln -sf build/compile_commands.json .

flash:
	@mkdir -p build
	@cd build && cmake .. && make flash
	@ln -sf build/compile_commands.json .

monitor:
	@sleep 1
	@if [ -e $(PORT) ]; then \
		screen $(PORT) 115200; \
	else \
		echo "error: port $(PORT) is unavailable"; \
	fi

clean:
	@rm -rf build compile_commands.json

