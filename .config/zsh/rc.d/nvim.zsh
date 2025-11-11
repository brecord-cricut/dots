nvimc() {
  cd "$XDG_CONFIG_HOME/nvim"
  case "$1" in
  "d") pwd ;;
  *)
    nvim
    cd - >/dev/null
    ;;
  esac
}
