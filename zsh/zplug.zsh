zplug "lukechilds/zsh-nvm"
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "monochromegane/the_platinum_searcher", from:gh-r, as:command, rename-to:pt

# load custon configuration
zplug "${DOTOSAURUS}/zsh/plugins", from:local, as:plugin

# load custom theme
zplug "${DOTOSAURUS}/zsh/theme", from:local, as:theme

# load local overrides
zplug "${HOME}/.zshrc.local", from:local, as:plugin, if:"[[ -f ${HOME}/.zshrc.local ]]"
