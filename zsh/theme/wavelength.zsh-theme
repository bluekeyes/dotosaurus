# ---------------------------------------------------------------------
# wavelength.zsh-theme
# Billy Keyes (http://bluekeyes.com/)
# ---------------------------------------------------------------------

base16_colors

GIT_PROMPT_PREFIX="${fg_base16[03]}[${fg_base16[0D]}"
GIT_PROMPT_SUFFIX="${fg_base16[03]}]"
GIT_PROMPT_DIRTY=" ${fg_base16[08]}Δ"
GIT_PROMPT_CLEAN=""
GIT_PROMPT_UNKNOWN=" ${fg_base16[0E]}×"

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

#
# Gets the current branch and status
#
function git_prompt_info() {
  if [[ "$(git config --get zsh.hide-prompt)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$GIT_PROMPT_SUFFIX"
  fi
}

#
# Gets the current git status
#
function parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ "$(command git config --get zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
          SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    else
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    fi
    if [[ -n $GIT_STATUS ]]; then
      echo "$GIT_PROMPT_DIRTY"
    else
      echo "$GIT_PROMPT_CLEAN"
    fi
  else
    echo "$GIT_PROMPT_UNKNOWN"
  fi
}

#
# Gets the current virtual environment
#
function virtualenv_prompt_info() {
  if [[ -n $VIRTUAL_ENV ]]; then
    printf "%s[%s] " "%{${fg[yellow]}%}" ${${VIRTUAL_ENV}:t}
  fi
}

# Disable virtualenv prompt mangling
export VIRTUAL_ENV_DISABLE_PROMPT=1


#
# Gets the number of visible characters in a prompt string
# http://stackoverflow.com/questions/10564314/count-length-of-user-visible-string-for-zsh-prompt
#
function visible_width() {
  local zero='%([BSUbfksu]|([FK]|){*})'
  echo ${#${(S%%)1//$~zero/}}
}

#
# Gets the text for the main prompt line
#
function wavelength_statusline() {
  local LEFT="${fg_base16[0A]}λ ${fg_base16[03]}$(highlighted_pwd)${fg_base16[03]} $(git_prompt_info)$(virtualenv_prompt_info)"
  local RIGHT=""
  if [[ -n ${SSH_CONNECTION} ]]; then
    RIGHT="${fg_base16[0D]}%m${fg_base16[03]}"
  fi

  local lwidth=$(visible_width "$LEFT")
  local rwidth=$(visible_width "$RIGHT")
  local padding=$(( $COLUMNS - $lwidth + (${#RIGHT} - $rwidth) ))

  echo $LEFT${(l:$padding:)RIGHT}
}

PROMPT='
${bg_base16[01]}$(wavelength_statusline)
%{$reset_color%}$(prompt_char) '
