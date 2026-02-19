if [[ "$(uname -s)" == "Darwin" ]]; then
  export JAVA_HOME="$HOMEBREW_CELLAR/openjdk@17/17.0.17"
elif [[ "$(uname -s)" == "Linux" ]]; then
  export JAVA_HOME="$XDG_DATA_HOME/openjdk/current"
fi

path=($JAVA_HOME/bin $path[@])

