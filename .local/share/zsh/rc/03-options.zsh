# Directory navigation & stack
setopt AUTO_CD           # cd by typing directory name alone
setopt AUTO_PUSHD        # make cd push $OLDPWD onto directory stack
setopt PUSHD_IGNORE_DUPS # don’t push duplicates
setopt PUSHD_SILENT      # no “~1  ~2” output on every cd
setopt CDABLE_VARS       # cd @foo works if @foo is a variable containing a path

# History (extra options that belong here, not in 01-history.zsh)
setopt EXTENDED_HISTORY # save timestamp+duration (we already have this, but safe)
setopt SHARE_HISTORY    # already in 01-history.zsh — duplicate is harmless

# Globbing & filename handling
setopt EXTENDED_GLOB     # #, ~, ^ operators in patterns
setopt GLOB_DOTS         # match dotfiles without .*
setopt NO_CASE_GLOB      # case-insensitive globbing (macOS default is case-insensitive anyway)
setopt NUMERIC_GLOB_SORT # 10-file sorts after 2-file

# Job control & interactivity
setopt AUTO_CONTINUE  # auto `cont` suspended jobs on disown
setopt LONG_LIST_JOBS # show PID with `jobs`
setopt NOTIFY         # report status of background jobs immediately
setopt NO_BG_NICE     # don’t nice background jobs
setopt NO_HUP         # don’t SIGHUP background jobs on shell exit

# Prompt & input behavior
setopt TRANSIENT_RPROMPT # remove right prompt after command finishes (great with p10k gitstatus)
setopt PROMPT_SUBST      # enable parameter/command substitution in prompt

# Completion system niceties
setopt ALWAYS_TO_END    # move cursor to end after completion
setopt COMPLETE_IN_WORD # allow completion from middle of word
setopt NO_LIST_BEEP     # silence the annoying beep when completion list is ambiguous

# Miscellaneous sanity
setopt COMBINING_CHARS      # proper handling of combining chars (accents, etc.)
setopt INTERACTIVE_COMMENTS # allow # comments in interactive shell
setopt RM_STAR_SILENT       # don’t ask for confirmation on `rm *`

# Things people usually want OFF
unsetopt BEEP          # no bell ever
unsetopt FLOW_CONTROL  # disable Ctrl-S/Ctrl-Q (so Ctrl-S works for reverse search)
unsetopt MENU_COMPLETE # don’t auto-select the first completion entry
