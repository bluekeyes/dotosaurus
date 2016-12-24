# install and manage NVM
zplug "lukechilds/zsh-nvm"

# load custon configuration
zplug "${DOTOSAURUS}/zsh/plugins", from:local, as:plugin

# load custom theme
zplug "${DOTOSAURUS}/zsh/theme", from:local, as:theme

# load local overrides
zplug "${HOME}/.zshrc.local", from:local, as:plugin, if:"[[ -f ${HOME}/.zshrc.local ]]"
