export FLUTTER_HOME="$REPOS/flutter"
if [[ -d "$FLUTTER_HOME/bin" ]]; then
  path=("$FLUTTER_HOME/bin" $path)
fi

if [[ -d "$FLUTTER_HOME" ]]; then
  [[ $OSNAME == darwin* ]] && alias flutter="flutter -d macos"
  [[ $OSNAME == linux* ]] && alias flutter="flutter -d linux"
fi
