# taken from oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh

# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen, iterm, and probably most modern xterm and rxvt
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|ansi)
      print -Pn "\e]2;$2:q\a" # set window name
      print -Pn "\e]1;$1:q\a" # set tab name
      ;;
    screen*)
      print -Pn "\ek$1:q\e\\" # set screen hardstatus
      ;;
    *)
      if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        print -Pn "\e]2;$2:q\a" # set window name
        print -Pn "\e]1;$1:q\a" # set tab name
      else
        # Try to use terminfo to set the title
        # If the feature is available set title
        if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
	  echoti tsl
	  print -Pn "$1"
	  echoti fsl
	fi
      fi
      ;;
  esac
}

SHORT_TITLE='%15<..<${PWD/#$HOME/~}%<<'
LONG_TITLE='%n@%m: ${PWD/#$HOME/~}'

function _settitle_precmd {
  title $SHORT_TITLE $LONG_TITLE
}

autoload -U add-zsh-hook
add-zsh-hook precmd _settitle_precmd
