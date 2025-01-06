() {
    local funcs="${DOTOSAURUS}/zsh/functions"

    export FPATH="${funcs}:${FPATH}"

    if [[ -d "${funcs}" ]]; then
        autoload ${=$(cd ${funcs} && echo *)}
    fi
}
