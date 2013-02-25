#!/bin/zsh
#
# Installs all Dotosaurus configuration files into their appropriate places.
# Based on the oh-my-zsh installation script
#

DOT=~/.dotosaurus
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
mkdir -p zsh/oh-my-zsh/custom
setopt extendedglob
for script in zsh/**/*.zsh~zsh/oh-my-zsh/*(N); do
    ln -s ${DOT}/${script} ${DOT}/zsh/oh-my-zsh/custom/$(basename ${script})
done

echo "Building configuration files..."
python tools/build.py

# Link all build files into the home directory
for file in build/*(.N); do
    ln -s ${DOT}/${file} ~/.$(basename ${file})
done

# Link the vim directory as .vim
if [ -d ~/.vim ]; then
    echo "Backing up .vim directory in .vim.bak"
    mv ~/.vim ~/.vim.bak
fi
ln -s ${DOT}/vim ~/.vim

# Make vim temp directories if they don't exis
mkdir -p ~/.local/share/vim/swap
mkdir -p ~/.local/share/vim/undo
mkdir -p ~/.local/share/vim/backup

echo "Dotosaurus is installed! Restart your shell and enjoy!"
