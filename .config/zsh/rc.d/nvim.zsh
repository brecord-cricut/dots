nvimc() {
  cd "$XDG_CONFIG_HOME/nvim"
  case "$1" in
  "d") pwd ;;
  *)
    env "${DOTS_PREFIX[@]}" nvim
    cd - >/dev/null
    ;;
  esac
}
