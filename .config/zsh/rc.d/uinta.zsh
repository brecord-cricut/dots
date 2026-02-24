UINTA_HOME="$HOME/src/uinta"

[[ -d "$UINTA_HOME" ]] || return 0

export UINTA_HOME

uinta() {
  emulate -L zsh
  setopt localoptions no_unset

  local cmd="${1-}"
  case "$cmd" in
  b) cmd=build ;;
  d) cmd=dir ;;
  r) cmd=repo ;;
  t) cmd=test ;;
  esac

  case "$cmd" in
  build)
    cd "$UINTA_HOME" || return 1
    if [[ ! -d build ]]; then
      echo "→ Configuring CMake..."
      cmake -B build . || return 1
    fi
    echo "→ Building..."
    make -j$(nproc) --directory build
    ;;

  dir)
    cd "$UINTA_HOME"
    echo "→ $(pwd)"
    return
    ;;

  repo)
    cd "$REPOS/uinta"
    echo "→ $(pwd)"
    return
    ;;

  test)
    shift
    cd "$UINTA_HOME" || return 1
    local build_dir="$UINTA_HOME/build"

    if [[ ! -d "$build_dir" ]]; then
      echo "Build directory not found. Run: cmake -B build . && make -j\$(nproc) --directory build"
      return 1
    fi

    local -a test_bins
    test_bins=( "$build_dir"/src/*/test/*_test(N) )

    if (( ${#test_bins[@]} == 0 )); then
      echo "No test executables found in build directory"
      return 1
    fi

    local failed=0
    for test_bin in "${test_bins[@]}"; do
      echo "\n→ Running $(basename "$test_bin")..."
      if (( $# > 0 )); then
        "$test_bin" --gtest_filter="*$1*" || failed=1
      else
        "$test_bin" || failed=1
      fi
    done

    cd - >/dev/null
    return $failed
    ;;

  "")
    cd "$UINTA_HOME"
    nvim -c "lua require('persistence').load()"
    ;;

  *)
    echo "Unknown argument: \"$1\""
    return 1
    ;;
  esac
}

# Tab completion
_uinta() {
  # Only consider the first argument
  if ((CURRENT == 2)); then
    local -a commands=(
      "b:build the project"
      "d:go to source directory"
      "r:go to repos directory"
      "t:run tests"
    )
    _describe "uinta command" commands
    return
  fi

  # Complete for tests
  if ((CURRENT == 3)) && [[ $words[2] == t ]]; then
    if [[ -d "$UINTA_HOME/build" ]]; then
      local -a tests
      local test_bin
      for test_bin in "$UINTA_HOME/build"/src/*/test/*_test(N); do
        tests+=( ${(f)"$("$test_bin" --gtest_list_tests 2>/dev/null | grep -E '^\w+\.' | sed 's/\.$//')"} )
      done
      if (( ${#tests[@]} > 0 )); then
        _describe "test suites" tests
      fi
    fi
    return
  fi
}
compdef _uinta uinta
