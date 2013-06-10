#!/bin/zsh
#
# Installs all Dotosaurus configuration files into their appropriate places.
# Based on the oh-my-zsh installation script
#

DOT=~/.dotosaurus
if [ -d ${DOT} ]; then
    echo "\033[0;31mDotosaurus is already installed. Delete ${DOT} and try again.\033[0m"
    exit 1
fi

echo "\033[0;32mCloning Dotosaurus...\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/bluekeyes/dotosaurus.git ${DOT} || {
    echo "\033[0;31mgit not installed\033[0m"
    exit 1
}

# Let's work from the repository for the rest of the install
echo "\033[0;32mSwitching to Dotosaurus directory...\033[0m"
cd ${DOT}

# Initialize Dotosaurus submodules
echo "\033[0;32mInitalizing submodules...\033[0m"
/usr/bin/env git submodule init && /usr/bin/env git submodule update || {
    echo "\033[0;31mFailed to setup Dotosaurus submodules!\033[0m"
    exit 1
}

echo "\033[0;32mInstalling files...\033[0m"

# Link custom scripts into oh-my-zsh
mkdir -p zsh/oh-my-zsh/custom
setopt extendedglob
for script in zsh/**/*.zsh~zsh/oh-my-zsh/*(N); do
    ln -s ${DOT}/${script} ${DOT}/zsh/oh-my-zsh/custom/$(basename ${script})
done

# Link all dot files into the home directory
for file in *.src(.N); do
    ln -s ${DOT}/${file} ~/.$(basename ${file})
done

# Link the vim directory as .vim
if [ -d ~/.vim ]; then
    echo "\033[0;33mBacking up .vim directory in .vim.bak\033[0m"
    mv ~/.vim ~/.vim.bak
fi
ln -s ${DOT}/vim ~/.vim

# Make vim temp directories if they don't exis
mkdir -p ~/.local/share/vim/swap
mkdir -p ~/.local/share/vim/undo
mkdir -p ~/.local/share/vim/backup

# Set up a new branch for local customizations
echo "\033[0;32mSetting up the local branch...\033[0m"
/usr/bin/env git checkout -b local origin/master

echo "\n\n \033[0;34mDotosaurus is installed!\033[0m"
echo "Commit any customizations to the 'local' branch, then restart your shell and enjoy!"

echo "\n\n You may want to customize:"
echo "\t gitconfifg: core.name"
echo "\t gitconfifg: core.email"
