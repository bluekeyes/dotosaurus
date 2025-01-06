# Install base16 colors into the 256 colorspace
source ${DOTOSAURUS}/colors/base16-tomorrow/shell.sh

# enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors ${DOTOSAURUS}/colors/dark.256.dircolors)"
fi
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
