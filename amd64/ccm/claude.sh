#!/bin/bash
# FILE LOCATION: /etc/profile.d/ccs.sh
# Depends on /usr/bin/ccm.sh
# MIT LICENSE

# Export claude path
export PATH="${HOME}/.local/bin":$PATH

# YOLO mode alias
alias xx="claude --dangerously-skip-permissions"

# CCI: Claude Code Init - silently setup ~/.local/bin/claude symlink
cci() {
  local local_bin="${HOME}/.local/bin"
  local claude_link="${local_bin}/claude"
  local claude_target="/usr/bin/claude"
  [[ -d "$local_bin" ]] || mkdir -p "$local_bin" 2>/dev/null
  [[ -L "$claude_link" || -e "$claude_link" || ! -x "$claude_target" ]] || ln -s "$claude_target" "$claude_link" 2>/dev/null
  return 0
}

# CCM: Shell function that applies exports to current shell
ccm() {
  cci
  local script="/usr/bin/ccm.sh"
  case "$1" in
    ""|"help"|"-h"|"--help"|"status"|"st"|"config"|"cfg")
      "$script" "$@"
      ;;
    *)
      eval "$("$script" "$@")"
      ;;
  esac
}

# CCC: Claude Code Commander - switch model and launch Claude Code
ccc() {
  cci
  if [[ $# -eq 0 ]]; then
    echo "Usage: ccc <model> [options]"
    echo ""
    echo "Models: deepseek, glm, kimi, kimi-cn, qwen, longcat, minimax, seed, claude, sonnet, opus, haiku"
    echo ""
    echo "Examples:"
    echo "  ccc opus                        # Launch with Claude Opus"
    echo "  ccc deepseek                    # Launch with DeepSeek"
    return 1
  fi

  local model="$1"; shift
  echo "Switching to $model..."
  ccm "$model" || return 1
  echo ""
  echo "Launching Claude Code..."
  echo "   Model: $ANTHROPIC_MODEL"
  echo "   Base URL: ${ANTHROPIC_BASE_URL:-Default (Anthropic)}"
  echo ""
  exec claude "$@"
}

# CCX: Claude Code eXtreme - ccc with --dangerously-skip-permissions (YOLO mode)
ccx() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: ccx <model> [options]"
    echo "Same as ccc but with --dangerously-skip-permissions (YOLO mode)"
    return 1
  fi
  ccc "$1" --dangerously-skip-permissions "${@:2}"
}
