#!/bin/sh
# Rebuild and install nvim into ~/.local after pulling new commits into master.
# post-merge only fires when a pull/merge actually moves HEAD, so an up-to-date
# pull doesn't trigger a rebuild.

[ "$(git rev-parse --abbrev-ref HEAD)" = master ] || exit 0

# Keep git's hook env vars from leaking into the build's own git calls
# shellcheck disable=SC2046
unset $(git rev-parse --local-env-vars)
set -e

nvim="$HOME/.local/bin/nvim"
echo "neovim: building $(git describe --always) (installed: $("$nvim" --version | head -n 1))"
rm -rf build
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local"
make install >/dev/null
"$nvim" --version
