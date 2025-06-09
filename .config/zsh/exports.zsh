[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"

if [[ $(uname) == "Darwin" ]]; then
  launchctl setenv BROWSER $BROWSER
  launchctl setenv EDITOR $EDITOR
  launchctl setenv PAGER $PAGER
  launchctl setenv TERMINAL $TERMINAL
fi
