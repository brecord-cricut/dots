#!/usr/bin/env zsh

alias nvimc="cd ~/.config/nvim && $EDITOR -c \"lua require('persistence').load()\" && cd - >/dev/null"
