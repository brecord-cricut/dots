if [[ "$(uname -s)" == "Darwin" ]]; then
  export JAVA_HOME="$HOMEBREW_CELLAR/openjdk/24.0.1"
elif [[ "$(uname -s)" == "Linux" ]]; then
  export JAVA_HOME="$XDG_DATA_HOME/openjdk/current"
fi

path=($JAVA_HOME/bin $path[@])

