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
# - ZSH_BASE16_BOLD_FG
#   values: [false (default), true]
#
#   If unset or set to false, use aixterm codes for bright foreground colors.
#   If set to true, use bright/bold escapes for bright foreground colors.
#   Ignored if ZSH_BASE16_COLORSPACE is 256.
#
# - ZSH_BASE16_BOLD_BG
#   values: [false (default), true]
#
#   If unset or set to false, use aixterm codes for bright background colors.
#   If set to true, use bright/bold escapes for bright background colors.
#   Ignored if ZSH_BASE16_COLORSPACE is 256.

function base16_colors() {
    # n_    normal : color number
    # b_    bright : color number
    local -A src

    local nfg_pattern nbg_pattern
    local bfg_pattern bbg_pattern

    if [[ "$ZSH_BASE16_COLORSPACE" == "256" ]]; then
        src=(
            n0 0    n1 18
            n2 19   n3 8
            n4 20   n5 7
            n6 21   n7 15
            n8 1    n9 16
            nA 3    nB 2
            nC 6    nD 4
            nE 5    nF 17
        )

        nfg_pattern='38;5;${src[$k]}'
        nbg_pattern='48;5;${src[$k]}'
        # bright patterns unused in 256 color mode
    else
        src=(
            n0 0    b1 2
            b2 3    b3 0
            b4 4    n5 7
            b6 5    b7 7
            n8 1    b9 1
            nA 3    nB 2
            nC 6    nD 4
            nE 5    bF 6
        )

        nfg_pattern='$((30 + ${src[$k]}))'
        nbg_pattern='$((40 + ${src[$k]}))'

        if [[ "$ZSH_BASE16_FG_BOLD" == "true" ]]; then
            bfg_pattern'1;$((30 + ${src[$k]}))'=
        else
            bfg_pattern='$((90 + ${src[$k]}))'
        fi

        if [[ "$ZSH_BASE16_BG_BOLD" == "true" ]]; then
            bbg_pattern='1;$((40 + ${src16[$k]}))'
        else
            bbg_pattern='$((100 + ${src[$k]}))'
        fi
    fi

    typeset -Ag base16_color

    local lc=$'\e['
    local k

    # set normal colors
    for k in ${(k)src[(I)n?]}; do
        base16_color[fg-0${k#?}]="${lc}${(e)nfg_pattern}m"
        base16_color[bg-0${k#?}]="${lc}${(e)nbg_pattern}m"
    done

    # set bright colors
    for k in ${(k)src[(I)b?]}; do
        base16_color[fg-0${k#?}]="${lc}${(e)bfg_pattern}m"
        base16_color[bg-0${k#?}]="${lc}${(e)bbg_pattern}m"
    done

    typeset -AHg fg_base16
    for k in ${(k)base16_color[(I)fg-*]}; do
        fg_base16[${k#fg-}]="%{${base16_color[$k]}%}"
    done

    typeset -AHg bg_base16
    for k in ${(k)base16_color[(I)bg-*]}; do
        bg_base16[${k#bg-}]="%{${base16_color[$k]}%}"
    done
}
