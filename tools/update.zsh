#!/bin/zsh
#
# Updates Dotosaurus
#

cd ${DOTOSAURUS:-~/.dotosaurus}

# TODO Warn when the current branch has uncommitted changes or is ahead of
# the origin

echo "Fetching changes from origin..."
git fetch origin && git merge origin/master || {
    echo "Failed get or merge updates from origin."
    exit 1
}

echo "Updating submodules..."
git submodule update || {
    echo "Failed to update submodules."
    exit 1
}

echo "Rebuilding config files..."
rm -r build
python tools/build.py || {
    echo "Failed to build config files."
    rm -r build
    exit 1
}

echo "Dotosaurus is up-to-date and ready to use!"
