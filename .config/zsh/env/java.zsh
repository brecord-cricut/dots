if [[ $(uname) == "Darwin" ]]; then
  export JAVA_HOME="$HOMEBREW_CELLAR/openjdk/24.0.1"
elif [[ $(uname) == "Linux" ]]; then
  export JAVA_HOME="$XDG_DATA_HOME/openjdk/current"
fi

[[ -d $JAVA_HOME ]] && export PATH="$JAVA_HOME/bin:$PATH"
