export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export NVMRC_PATH="$XDG_CONFIG_HOME/nvmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"

[ -d "$XDG_CONFIG_HOME/npm" ] || mkdir -p "$XDG_CONFIG_HOME/npm"
[ -d "$NVM_DIR" ] && source $NVM_DIR/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
