# rp2040_example
An example of a configured project for the rp2040 microcontroller.

## How to use this?
### 1. Install System Dependencies
Install the GNU ARM embedded toolchain, CMake, and `libusb` development headers:
```bash
# Void Linux
sudo xbps-install -S git cmake make cross-arm-none-eabi-gcc cross-arm-none-eabi-newlib libusb-devel screen

# Debian / Ubuntu
sudo apt update && sudo apt install -y git cmake make gcc-arm-none-eabi libnewlib-arm-none-eabi libusb-1.0-0-dev screen

# Arch Linux
sudo pacman -S git cmake make arm-none-eabi-gcc arm-none-eabi-newlib libusb screen

```


### 2. Clone and Setup Pico SDK

```bash
mkdir ~/pico && cd ~/pico
git clone -b master [https://github.com/raspberrypi/pico-sdk.git](https://github.com/raspberrypi/pico-sdk.git)
cd pico-sdk
git submodule update --init

```

### 3. Build and Install `picotool`

`picotool` is required for flashing the board over USB without using the physical BOOTSEL button.

```bash
cd ~/pico
git clone -b master [https://github.com/raspberrypi/picotool.git](https://github.com/raspberrypi/picotool.git)
cd picotool && mkdir build && cd build
PICO_SDK_PATH=$HOME/pico/pico-sdk cmake ..
make -j$(nproc)
sudo make install

```

### 4. Configure Udev Rules (Non-root USB access)

Allow your Linux user to communicate with the Pico over USB without `sudo`:

```bash
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", MODE="0666"' | sudo tee /etc/udev/rules.d/99-pico.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

```

---

## 🚀 Workflow & Makefile Commands

This repository includes a smart `Makefile` that handles the entire building, flashing, and monitoring pipeline.

### Build the Project

```bash
make

```

### Flash the Board

Uploads the compiled `.uf2` binary to the connected Raspberry Pi Pico using `picotool`:

```bash
make flash

```

### Open Serial Monitor

Connects to the Pico's `printf()` output via USB CDC (`/dev/ttyACM0`) using `screen`:

```bash
make monitor

```

*Tip: To exit the `screen` session, press `Ctrl+A`, then `K`, and confirm with `y`.*
*You can also use "make flash monitor" to open the "screen" immediately after flashing.*
