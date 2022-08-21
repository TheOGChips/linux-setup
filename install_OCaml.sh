#!/bin/zsh

DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"
distro="$1"
pkg_mgr="$2"

if [ "$distro" = "$DEBIAN" ]
    then
    sudo "$pkg_mgr" update
    sudo "$pkg_mgr" -y install opam camlp4 rlwrap bubblewrap
    sudo "$pkg_mgr" install libgtksourceview2.0-dev # needed for ocaml-top

elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    sudo "$pkg_mgr" -y install opam ocaml
fi

# OPAM initialization
opam init

if [ "$distro" = "$DEBIAN" ]
    then
    # opam configuration (alternatively, ~/.bashrc can be chosen when running opam init if ~/.profile is giving issues)
    #test -r /home/chris/.opam/opam-init/init.sh && . /home/chris/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

    #I had to use this one time because a switch wasn't created when I ran opam init (haven't had that problem before or since, though)
    #opam switch create ocaml-base-compiler

    opam install ocamlfind ounit ocaml-top

elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    eval $(opam env --switch=default)
    opam install ocaml-top user-setup
    opam user-setup install
    eval $(opam env)
fi

# NOTE: ocaml-top needs to be run from the command line (i.e. "$ ocaml-top")

# only needed until the next time the computer restarts
source ~/.zshrc
