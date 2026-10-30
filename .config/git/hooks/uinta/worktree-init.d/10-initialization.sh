#!/bin/sh
# Initialize submodules in a newly added linked worktree (the $HOME work tree
# is handled by post-checkout.d/10-bootstrap.sh).
[ "$PWD" = "$HOME" ] && exit 0
git submodule update --init --depth 1 || exit
cmake -B build -S . || exit
make --directory build || exit
