zplug "lukechilds/zsh-nvm"
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg

# load custon configuration
zplug "${DOTOSAURUS}/zsh/plugins", from:local, as:plugin

# load custom theme
zplug "${DOTOSAURUS}/zsh/theme", from:local, as:theme

# load local overrides
zplug "${HOME}", from:local, as:plugin, use:'.zshrc.local', if:"[[ -f ${HOME}/.zshrc.local ]]"
