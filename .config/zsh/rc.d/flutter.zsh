export FLUTTER_HOME="$REPOS/flutter"
if [[ -d "$FLUTTER_HOME/bin" ]]; then
  path=("$FLUTTER_HOME/bin" $path[@])
fi

[[ $OSTYPE == darwin* ]] && alias flutter="flutter -d macos"
[[ $OSTYPE == linux* ]] && alias flutter="flutter -d linux"
[[ -d "$HOME/.pub-cache/bin" ]] && path+=("$HOME/.pub-cache/bin")
