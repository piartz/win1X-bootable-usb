#!/bin/bash

# Version without emojis for a more classic experience

# Set source and destination volumes
ISO_VOL="/Volumes/CCCOMA_X64FRE_EN-US_DV9" # Change this to your ISO mount name
USB_VOL="/Volumes/WIN" # Change this to your USB drive name
TMP_DIR="$HOME/win11_split" # (Optional) Change this to your temporary folder

# Create temp dir
mkdir -p "$TMP_DIR"

echo "Splitting install.wim into <4GB SWM files..."
wimlib-imagex split "$ISO_VOL/sources/install.wim" "$TMP_DIR/install.swm" 4000

echo "Cleaning existing USB contents..."
rm -rf "$USB_VOL"/*

echo "Copying ISO contents to USB..."
cp -R "$ISO_VOL"/* "$USB_VOL/"

echo "Removing oversized install.wim..."
rm "$USB_VOL/sources/install.wim"

echo "Copying split SWM files..."
cp "$TMP_DIR"/install*.swm "$USB_VOL/sources/"

echo "Done! Safely eject the USB before removing."
