# ---------------------------------------------------------------------
# wavelength.zsh-theme
# Billy Keyes (http://bluekeyes.com/)
# ---------------------------------------------------------------------

# Load the solarized colors
solarized

#
# Highlights the current directory in the PWD string
#
function highlighted_pwd() {
    local dir home_sub

    dir="$(basename ${PWD})"
    home_sub="${PWD/#$HOME/~}"

    if [[ ${home_sub} = "~" ]]; then
        echo "${slr_fg[base0]}~"
    else
        # TODO truncate extra long working directories
        echo "${home_sub%${~dir}}${slr_fg[base0]}${dir}"
    fi
}

#
# Switches color and character based on privildege
#
function prompt_char() {
    echo "%(!.${slr_fg[red]}#.${slr_fg[base1]}»)%{$reset_color%}"
}

PROMPT='
${slr_bg[base03]}${slr_fg[yellow]}λ ${slr_fg[base01]}$(highlighted_pwd)${slr_fg[base01]} $(git_prompt_info)%E
%{$reset_color%}$(prompt_char) '

RPROMPT='${slr_fg[base01]}%*%{$reset_color%}'
if [[ -n ${SSH_CONNECTION} ]]; then
    RPROMPT="${slr_fg[blue]}%n@%m${slr_fg[base0]}|${RPROMPT}"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="${slr_fg[base01]}[${slr_fg[blue]}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${slr_fg[base01]}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${slr_fg[red]}Δ"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNKNOWN=" ${slr_fg[violet]}×"

ZSH_THEME_TERM_TAB_TITLE_IDLE='%15<..<${PWD/#$HOME/~}%<<'
ZSH_THEME_TERM_TITLE_IDLE='%n@%m: ${PWD/#$HOME/~}'

