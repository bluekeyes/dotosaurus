# ---------------------------------------------------------------------
# wavelength.zsh-theme
# Billy Keyes (http://bluekeyes.com/)
# ---------------------------------------------------------------------

base16_colors

#
# Highlights the current directory in the PWD string
#
function highlighted_pwd() {
    local dir home_sub

    dir="$(basename ${PWD})"
    home_sub="${PWD/#$HOME/~}"

    if [[ ${home_sub} = "~" ]]; then
        echo "${fg_base16[04]}~"
    else
        # TODO truncate extra long working directories
        echo "${home_sub%${~dir}}${fg_base16[04]}${dir}"
    fi
}

#
# Switches color and character based on privildege
#
function prompt_char() {
    echo "%(!.${fg_base16[08]}#.${fg_base16[0B]}»)%{$reset_color%}"
}

PROMPT='
${bg_base16[01]}${fg_base16[0A]}λ ${fg_base16[03]}$(highlighted_pwd)${fg_base16[03]} $(git_prompt_info)$(virtualenv_prompt_info)%E
%{$reset_color%}$(prompt_char) '

RPROMPT='$fg_base16[03]%*%{$reset_color%}'
if [[ -n ${SSH_CONNECTION} ]]; then
    RPROMPT='$fg_base16[0D]%n@%m$fg_base16[03]|'${RPROMPT}
fi

ZSH_THEME_GIT_PROMPT_PREFIX="${fg_base16[03]}[${fg_base16[0D]}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${fg_base16[03]}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${fg_base16[08]}Δ"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNKNOWN=" ${fg_base16[0E]}×"

ZSH_THEME_TERM_TAB_TITLE_IDLE='%15<..<${PWD/#$HOME/~}%<<'
ZSH_THEME_TERM_TITLE_IDLE='%n@%m: ${PWD/#$HOME/~}'
