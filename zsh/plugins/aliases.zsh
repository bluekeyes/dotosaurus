# directory manipulation
alias ..='cd ..'
alias ...='cd ../..'

# ls
alias ll='ls -lh'
alias la='ls -lAh'
alias lt='ls -lth'

# history
alias history='fc -il 1'

# grep (use alias to avoid GREP_OPTIONS)
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

# other
alias less="less -S"
alias gradled="gradlef --daemon"

# add github actions to 'git'
alias git="hub"
