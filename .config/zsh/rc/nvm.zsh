[ -d "$XDG_CONFIG_HOME/npm" ] || mkdir -p "$XDG_CONFIG_HOME/npm"
[ -d "$NVM_DIR" ] && source $NVM_DIR/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
