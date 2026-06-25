#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"
cd ..

TMP_DIR=".tmp/bash-fixture-sources"
CASES_DIR="test/cases"
BASELINES_DIR="test/baselines"

TREE_SITTER_BASH_COMMIT="a06c2e4415e9bc0346c6b86d401879ffb44058f7"
MVDAN_SH_COMMIT="2255122b577bf90e563b61943ba9e06d231b6d25"
BASH_IT_COMMIT="2e652f1ef47078eeadf92a815993faf7ec3edfc1"
OH_MY_BASH_COMMIT="627913b75855036cb5af2f3ad130c66a335e7382"

clone_checkout() {
  local repo="$1"
  local commit="$2"
  local target="$3"

  git clone "$repo" "$target"
  git -C "$target" checkout "$commit"
}

copy_case() {
  local source="$1"
  local target="$2"

  cp "$source" "$CASES_DIR/$target.sh"
}

extract_tree_sitter_case() {
  local corpus_file="$1"
  local title="$2"
  local target="$3"

  awk -v target="$title" '
    /^=+$/ {
      if (state == 0) {
        state = 1
        title = ""
        next
      }
      if (state == 1) {
        gsub(/^[ \t\r\n]+|[ \t\r\n]+$/, "", title)
        state = 0
        if (title == target) {
          found = 1
          skip_blank = 1
        }
        next
      }
    }
    state == 1 {
      title = title $0
      next
    }
    found && /^---$/ {
      exit
    }
    found {
      if (skip_blank && $0 == "") {
        next
      }
      skip_blank = 0
      print
    }
  ' "$corpus_file" > "$CASES_DIR/$target.sh"

  if [ ! -s "$CASES_DIR/$target.sh" ]; then
    echo "Failed to extract tree-sitter-bash case: $title" >&2
    exit 1
  fi
}

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

rm -f "$CASES_DIR"/tree-sitter-bash-*.sh
rm -f "$CASES_DIR"/mvdan-sh-*.sh
rm -f "$CASES_DIR"/bash-it-*.sh
rm -f "$CASES_DIR"/oh-my-bash-*.sh
rm -f "$BASELINES_DIR"/tree-sitter-bash-*.txt
rm -f "$BASELINES_DIR"/mvdan-sh-*.txt
rm -f "$BASELINES_DIR"/bash-it-*.txt
rm -f "$BASELINES_DIR"/oh-my-bash-*.txt

clone_checkout "https://github.com/tree-sitter/tree-sitter-bash.git" "$TREE_SITTER_BASH_COMMIT" "$TMP_DIR/tree-sitter-bash"
clone_checkout "https://github.com/mvdan/sh.git" "$MVDAN_SH_COMMIT" "$TMP_DIR/mvdan-sh"
clone_checkout "https://github.com/Bash-it/bash-it.git" "$BASH_IT_COMMIT" "$TMP_DIR/bash-it"
clone_checkout "https://github.com/ohmybash/oh-my-bash.git" "$OH_MY_BASH_COMMIT" "$TMP_DIR/oh-my-bash"

extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/commands.txt" "Commands with environment variables" "tree-sitter-bash-commands-env"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/commands.txt" "File redirects" "tree-sitter-bash-file-redirects"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Variable expansions with operators" "tree-sitter-bash-var-expansion-operators"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Variable Expansions: Weird Cases" "tree-sitter-bash-var-expansion-weird"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Variable Expansions: Regex" "tree-sitter-bash-var-expansion-regex"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Command substitutions" "tree-sitter-bash-command-substitutions"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Process substitutions" "tree-sitter-bash-process-substitutions"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Strings containing command substitutions" "tree-sitter-bash-string-command-substitutions"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Strings with ANSI-C quoting" "tree-sitter-bash-ansi-c-strings"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/literals.txt" "Arrays and array expansions" "tree-sitter-bash-arrays"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "Pipelines" "tree-sitter-bash-pipelines"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "Lists" "tree-sitter-bash-lists"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "While statements with IO redirects" "tree-sitter-bash-while-redirects"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "For statements" "tree-sitter-bash-for-statements"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "If statements with variable assignment by command substitution" "tree-sitter-bash-if-assignment-command-substitution"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "Case statements" "tree-sitter-bash-case-statements"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "Test commands" "tree-sitter-bash-test-commands"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "Test commands with ternary" "tree-sitter-bash-test-command-ternary"
extract_tree_sitter_case "$TMP_DIR/tree-sitter-bash/test/corpus/statements.txt" "Subshells" "tree-sitter-bash-subshells"

copy_case "$TMP_DIR/mvdan-sh/syntax/canonical.sh" "mvdan-sh-canonical"

copy_case "$TMP_DIR/bash-it/aliases/available/general.aliases.bash" "bash-it-general-aliases"
copy_case "$TMP_DIR/bash-it/plugins/available/base.plugin.bash" "bash-it-base-plugin"
copy_case "$TMP_DIR/bash-it/plugins/available/dirs.plugin.bash" "bash-it-dirs-plugin"

copy_case "$TMP_DIR/oh-my-bash/oh-my-bash.sh" "oh-my-bash-core"
copy_case "$TMP_DIR/oh-my-bash/plugins/nvm/nvm.plugin.sh" "oh-my-bash-nvm-plugin"
copy_case "$TMP_DIR/oh-my-bash/themes/vscode/vscode.theme.sh" "oh-my-bash-vscode-theme"
