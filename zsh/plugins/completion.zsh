setopt alwaystoend
setopt automenu
setopt completeinword
setopt hashlistall
setopt nomenucomplete
setopt nonomatch

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''

# process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# cache completions
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "~/.cache/zsh"
