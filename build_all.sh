#!/usr/bin/env bash

# Check for null parameter
if [ -z $1 ] ; then
    echo "Please provide the zmk directory when using $0"
    exit 1
fi

ZMK_DIRECTORY=$1
ENV_DIRECTORY=~/.python_venvs/local_env

# Go to root
cd $1

# Start virtual env
echo "Starting Virtual Environment ${ENV_DIRECTORY}"
#${ENV_DIRECTORY}/bin/activate
source ${ENV_DIRECTORY}/bin/activate

if [ -z ${VIRTUAL_ENV} ] ; then
    echo "Virtual Environment ${ENV_DIRECTORY} failed to start"
    exit 1
fi

cd app

# Build Dongle
west build -p -d build/dongle -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD="fifi_dongle_pro_micro dongle_display" -DZMK_EXTRA_MODULES="/home/celestria/repositories/keyboard/zmk-config-kurofi;/home/celestria/repositories/keyboard/zmk-dongle-display" -DZMK_CONFIG="/home/celestria/repositories/keyboard/zmk-config-kurofi/config"

# Build Right
west build -p -d build/right -b nice_nano_v2 -- -DSHIELD="fifi_right" -DZMK_EXTRA_MODULES="/home/celestria/repositories/keyboard/zmk-config-kurofi" -DZMK_CONFIG="/home/celestria/repositories/keyboard/zmk-config-kurofi/config"

# Build Left 
west build -p -d build/left -b nice_nano_v2 -- -DSHIELD="fifi_left_peripheral" -DZMK_EXTRA_MODULES="/home/celestria/repositories/keyboard/zmk-config-kurofi" -DZMK_CONFIG="/home/celestria/repositories/keyboard/zmk-config-kurofi/config"

if [ ${VIRTUAL_ENV} ] ; then
    deactivate
fi
