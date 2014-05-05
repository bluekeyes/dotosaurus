#!/bin/zsh
# A script to make dealing with Ethan Schoonover's Solarized color
# scheme in zsh less painful.
#
# See http://ethanschoonover.com/solarized

function solarized() {
    typeset -Ag slr_color

    slr_color=(
        base03  bold-black
        base02  black
        base01  bold-green
        base00  bold-yellow
        base0   bold-blue
        base1   bold-cyan
        base2   white
        base3   bold-white
        yellow  yellow
        orange  bold-red
        red     red
        magenta magenta
        violet  bold-magenta
        blue    blue
        cyan    cyan
        green   green
    )

    typeset -A bold_map
    local k
    for k in ${(k)fg}
    do
        bold_map[$k]=${fg_no_bold[$k]}
        bold_map[bold-$k]=${fg_bold[$k]}
        bold_map[bg-$k]=${bg_no_bold[$k]}
        bold_map[bg-bold-$k]=${bg_bold[$k]}
    done

    typeset -AHg slr_fg slr_bg
    for k in ${(k)slr_color}
    do
        slr_fg[$k]="%{${bold_map[${slr_color[$k]}]}%}"
        slr_bg[$k]="%{${bold_map[bg-${slr_color[$k]}]}%}"
    done
}

function solarized_ls() {
    solarized
    for k in ${(k)slr_fg}
    do
        print -P -- "${slr_fg[$k]}Solarized${reset_color} : $k"
    done
    for k in ${(k)slr_bg}
    do
        print -P -- "${slr_bg[$k]}Solarized${reset_color} : $k"
    done
}
