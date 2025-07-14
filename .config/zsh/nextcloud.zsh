#!/usr/bin/env zsh

export NEXTCLOUD_DIR=$XDG_DATA_HOME/Nextcloud
[[ -d $NEXTCLOUD_DIR/bin ]] && export PATH="$NEXTCLOUD_DIR/bin:$PATH"
