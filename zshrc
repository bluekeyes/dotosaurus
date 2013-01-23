export DOTOSAURUS=~/.dotosaurus

export ZSH=$DOTOSAURUS/oh-my-zsh
export ZSH_THEME="wavelength"
export DISABLE_AUTO_UPDATE="true"
plugins=(solarized) 

source $ZSH/oh-my-zsh.sh

# Set up Solarized colors for ls  -------------------------------------
eval "$(dircolors $DOTOSAURUS/dircolors-solarized/dircolors.ansi-dark)"

# Environment Variables -----------------------------------------------
export EDITOR='vim'

# PATH changes --------------------------------------------------------
export PATH="$HOME/bin:${PATH}"

# ---------------------------------------------------------------------
# Aliases in $ZSH_CUSTOM/aliases.zsh
# ---------------------------------------------------------------------

