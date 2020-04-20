gofiles() {
    go list -f '{{range .GoFiles}}{{ printf "%s/%s\n" $.Dir .}}{{end}}' ./...
    go list -f '{{range .TestGoFiles}}{{ printf "%s/%s\n" $.Dir .}}{{end}}' ./...
}

autoload zmv
alias zmv='noglob zmv'
alias zcp='noglob zmv -C'
