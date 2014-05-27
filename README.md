# Dotosaurus

Protecting dotfiles and such from extinction by meteorite (or harddrive failure).

```
 _____________
< Dotosaurus! >
 -------------
\                             .       .
 \                           / `.   .' "
  \                  .---.  <    > <    >  .---.
   \                 |    \  \ - ~ ~ - /  /    |
         _____          ..-~             ~-..-~
        |     |   \~~~\.'                    `./~~~/
       ---------   \__/                        \__/
      .'  O    \     /               /       \  "
     (_____,    `._.'               |         }  \/~~~/
      `----.          /       }     |        /    \__/
            `-.      |       /      |       /      `. ,~~|
                ~-.__|      /_ - ~ ^|      /- _      `..-'
                     |     /        |     /     ~-.     `-. _  _  _
                     |_____|        |_____|         ~ - . _ _ _ _ _>
```

## Installation

### Bootstrap

If you haven't already cloned the repository, consider using the bootstrap
script. This script will clone the repository and its submodules, then run the
installation script described below.

You can use either `curl` or `wget` to get the bootstrap script

    curl -L https://github.com/bluekeyes/dotosaurus/raw/master/scripts/bootstrap.sh | sh
    wget --no-check-certificate https://github.com/bluekeyes/dotosaurus/raw/master/scripts/bootstrap.sh -O - | sh

### Install

To install dotosaurus, run

    ./scripts/dotosaurus install

Note that this requires Python 2.7.x. You don't need to run this script if you
already ran the bootstrap script.

If any dotfiles already exist, the command will fail. If this happens, rerun
with either the `--force` or `--backup` flag.

If you have any local changes, make them and commit them on the `local` branch.

## Updating

To update dotosaurus, run

    ./scripts/dotosaurus update

Note that this require Python 2.7.x.

If you have local changes that conflict with new remote changes, the command
will fail and ask you to resolve merge conflicts manually. Once the conflicts
are resolved run

    ./scripts/dotosaurus update --continue

to finish the update.
