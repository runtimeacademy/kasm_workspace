#!/bin/bash

# Extension identifier
EXTENSION="wasp-lang.wasp-0.5.3"

# Check if 'code' command is available
if ! command -v code &> /dev/null
then
    echo "'code' command not found. Please ensure Visual Studio Code is installed and added to your PATH."
    exit 1
fi

# Install the extension
echo "Installing the Barcode extension for VSCode..."
code --install-extension $EXTENSION

if [ $? -eq 0 ]; then
    echo "Barcode extension installed successfully."
else
    echo "Failed to install the Barcode extension."
    exit 1
fi
