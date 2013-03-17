#!/bin/zsh
#
# Updates Dotosaurus
#

cd ${DOTOSAURUS:-~/.dotosaurus}

echo "Updating submodules..."
git submodule update || {
    echo "Failed to update submodules."
    exit 1
}

echo "Rebuilding config files..."
python tools/build.py || {
    echo "Failed to build config files."
    rm -rf build
    exit 1
}

echo "Dotosaurus is up-to-date and ready to use!"
