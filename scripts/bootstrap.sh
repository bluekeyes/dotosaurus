#!/bin/sh
DOTOSAURUS="~/.dotosaurus"

fail() {
    echo -e "[ \033[31mFAIL\033[0m ] $1" 1>&2
}

if [ -d "${DOTOSAURUS}" ]; then
    fail "${DOTOSAURUS} already exists"
    exit 1
fi

git clone https://github.com/bluekeyes/dotosaurus.git "${DOTOSAURUS}" || {
    fail "could not clone Dotosaurus"
    exit 1
}

cd "${DOTOSAURUS}"
git submodule init && git submodule update || {
    fail "could not initialize or update submodules"
    exit 1
}

./scripts/dotosaurus install || {
    fail "could not install Dotosaurus"
    echo "run ./scripts/dotosaurus install --help for more information"
    exit 1
}
