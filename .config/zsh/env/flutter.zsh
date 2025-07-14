if [[ -d "$FLUTTER_HOME" ]]; then
  export PATH="$FLUTTER_HOME/bin:$PATH:$HOME/.pub-cache/bin"

  plugins+=flutter

  [[ $(uname) == "Darwin" ]] && alias flutter="flutter -d macos"
  [[ $(uname) == "Linux" ]] && alias flutter="flutter -d linux"
fi
