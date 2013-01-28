#!/bin/zsh
#
# Installs all Dotosaurus configuration files into their appropriate places.
# Based on the oh-my-zsh installation script
#

DOT='~/.dotosaurus'
if [ -d ${DOT} ]; then
    echo "Dotosaurus is already installed. Delete your ${DOT} directory and try again."
    exit 1
fi

echo "Cloning Dotosaurus..."
hash git >/dev/null && /usr/bin/env git clone https://github.com/bluekeyes/dotosaurus.git ${DOT} || {
    echo "git not installed"
    exit 1
}

# Let's work from the repository for the rest of the install
echo "Switching to Dotosaurus directory..."
cd ${DOT}

# Initialize Dotosaurus submodules
echo "Initalizing submodules..."
/usr/bin/env git submodule init && /usr/bin/env git submodule update || {
    echo "Failed to setup Dotosaurus submodules!"
    exit 1
}

echo "Installing files..."

# Link custom scripts into oh-my-zsh
setopt extendedglob
for script in zsh/**/*.zsh~zsh/oh-my-zsh/*(N); do
    ln -s ${script} zsh/oh-my-zsh/custom/$(basename ${script})
done

# Link all files with no extensions into the home directory
for file in *~*.*(.N); do
    ln -s ${file} ~/.$(basename ${file})
done

echo "Dotosaurus is installed! Restart your shell and enjoy!"
