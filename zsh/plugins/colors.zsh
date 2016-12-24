# Install base16 colors into the 256 colorspace
source ${DOTOSAURUS}/colors/base16-tomorrow/shell.sh

# enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
eval "$(dircolors ${DOTOSAURUS}/colors/dark.256.dircolors)"
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
