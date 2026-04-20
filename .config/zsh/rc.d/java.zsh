if [[ "$(uname -s)" == "Darwin" ]]; then
  export JAVA_HOME="/opt/homebrew/opt/openjdk"
elif [[ "$(uname -s)" == "Linux" ]]; then
  export JAVA_HOME="$XDG_DATA_HOME/openjdk/current"
fi

path=($JAVA_HOME/bin $path[@])
