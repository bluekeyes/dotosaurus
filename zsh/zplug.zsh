zplug "lukechilds/zsh-nvm"

# load commands
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg
zplug "github/hub", from:gh-r, as:command, rename-to:hub

# load custon configuration
zplug "${DOTOSAURUS}/zsh/plugins", from:local

# load custom theme
zplug "${DOTOSAURUS}/zsh/theme", from:local, as:theme

# load local overrides
zplug "${HOME}", from:local, as:plugin, use:'.zshrc.local', if:"[[ -f ${HOME}/.zshrc.local ]]"
