#!/bin/zsh

# Sets variables that make the base16 color scheme easier to use in prompts.
#
# https://github.com/chriskempson/base16
#
# This plugin is configured by several environment variables:
#
# - ZSH_BASE16_COLORSPACE
#   values: [16 (default), 256]
#
#   If unset or set to 16, assume the terminal is configured with the base16
#   theme and use bright/bold to access non-standard colors. If set to 256,
#   assume the 256 colorspace is modified by base16-shell and use these
#   extended colors to access non-standard colors.
#
# - ZSH_BASE16_USE_BOLD
#   values: [false (default), true]
#
#   If unset or set to false, use aixterm codes for bright colors. If set to
#   true, use bright/bold escapes for bright colors. Ignored if
#   ZSH_BASE16_COLORSPACE is 256.

function base16_colors() {
    typeset -Ag base16_color

    # set standard colors
    base16_color[00]=$'\e[30m'
    base16_color[08]=$'\e[31m'
    base16_color[0B]=$'\e[32m'
    base16_color[0A]=$'\e[33m'
    base16_color[0D]=$'\e[34m'
    base16_color[0E]=$'\e[35m'
    base16_color[0C]=$'\e[36m'
    base16_color[05]=$'\e[37m'

    base16_color[bg-00]=$'\e[40m'
    base16_color[bg-08]=$'\e[41m'
    base16_color[bg-0B]=$'\e[42m'
    base16_color[bg-0A]=$'\e[43m'
    base16_color[bg-0D]=$'\e[44m'
    base16_color[bg-0E]=$'\e[45m'
    base16_color[bg-0C]=$'\e[46m'
    base16_color[bg-05]=$'\e[47m'

    if [[ "$ZSH_BASE16_COLORSPACE" == "256" ]]; then
        # TODO is it fine to reference bright white and black via 256?
        base16_color[03]=$'\e[38;5;8m'
        base16_color[09]=$'\e[38;5;16m'
        base16_color[01]=$'\e[38;5;18m'
        base16_color[02]=$'\e[38;5;19m'
        base16_color[04]=$'\e[38;5;20m'
        base16_color[06]=$'\e[38;5;21m'
        base16_color[0F]=$'\e[38;5;17m'
        base16_color[07]=$'\e[38;5;15m'

        base16_color[bg-03]=$'\e[48;5;8m'
        base16_color[bg-09]=$'\e[48;5;16m'
        base16_color[bg-01]=$'\e[48;5;18m'
        base16_color[bg-02]=$'\e[48;5;19m'
        base16_color[bg-04]=$'\e[48;5;20m'
        base16_color[bg-06]=$'\e[48;5;21m'
        base16_color[bg-0F]=$'\e[48;5;17m'
        base16_color[bg-07]=$'\e[48;5;15m'
    elif [[ "$ZSH_BASE16_USE_BOLD" == "true" ]]; then
        base16_color[03]=$'\e[1;30m'
        base16_color[09]=$'\e[1;31m'
        base16_color[01]=$'\e[1;32m'
        base16_color[02]=$'\e[1;33m'
        base16_color[04]=$'\e[1;34m'
        base16_color[06]=$'\e[1;35m'
        base16_color[0F]=$'\e[1;36m'
        base16_color[07]=$'\e[1;37m'

        base16_color[bg-03]=$'\e[1;40m'
        base16_color[bg-09]=$'\e[1;41m'
        base16_color[bg-01]=$'\e[1;42m'
        base16_color[bg-02]=$'\e[1;43m'
        base16_color[bg-04]=$'\e[1;44m'
        base16_color[bg-06]=$'\e[1;45m'
        base16_color[bg-0F]=$'\e[1;46m'
        base16_color[bg-07]=$'\e[1;47m'
    else
        base16_color[03]=$'\e[90m'
        base16_color[09]=$'\e[91m'
        base16_color[01]=$'\e[92m'
        base16_color[02]=$'\e[93m'
        base16_color[04]=$'\e[94m'
        base16_color[06]=$'\e[95m'
        base16_color[0F]=$'\e[96m'
        base16_color[07]=$'\e[97m'

        base16_color[bg-03]=$'\e[100m'
        base16_color[bg-09]=$'\e[101m'
        base16_color[bg-01]=$'\e[102m'
        base16_color[bg-02]=$'\e[103m'
        base16_color[bg-04]=$'\e[104m'
        base16_color[bg-06]=$'\e[105m'
        base16_color[bg-0F]=$'\e[106m'
        base16_color[bg-07]=$'\e[107m'
    fi

    local k
    for k in ${base16_color[(I)0?]}; do base16_color[fg-${k}]=${base16_color[$k]}; done

    typeset -AHg fg_base16
    for k in ${(k)base16_color[(I)fg-*]}; do
        fg_base16[${k#fg-}]="%{${base16_color[$k]}%}"
    done

    typeset -AHg bg_base16
    for k in ${(k)base16_color[(I)bg-*]}; do
        bg_base16[${k#bg-}]="%{${base16_color[$k]}%}"
    done
}
