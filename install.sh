#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== macOS Setup Script ==="

# ----- Homebrew -----
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed."
fi

# Taps
brew tap sinelaw/fresh
brew tap manaflow-ai/cmux

# Formulae
FORMULAE=(
  act
  actionlint
  awscli
  bc
  bfg
  bind
  direnv
  duckdb
  fastfetch
  fd
  fresh-editor
  gh
  ghq
  go
  go-task
  helm
  jq
  just
  kube-ps1
  kubectx
  ls-lint
  luarocks
  mcp-toolbox
  neovim
  nodebrew
  patchutils
  peco
  pre-commit
  ripgrep
  shfmt
  sqlfluff
  stern
  terraform-docs
  tfenv
  tmux
  tree
  yq
)

echo "Installing formulae..."
brew install "${FORMULAE[@]}"

# Casks
CASKS=(
  cmux
  graphiql
  warp
)

echo "Installing casks..."
brew install --cask "${CASKS[@]}"

# ----- Node.js (nodebrew) -----
if command -v nodebrew &>/dev/null; then
  echo "Setting up nodebrew..."
  nodebrew setup
  # 最新の安定版をインストール
  nodebrew install-binary stable
  nodebrew use stable
fi

# ----- Zsh plugins -----
ZSH_DIR="$HOME/.zsh"
mkdir -p "$ZSH_DIR"

if [ ! -d "$ZSH_DIR/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_DIR/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_DIR/f-sy-h" ]; then
  echo "Installing F-Sy-H (fast-syntax-highlighting)..."
  git clone https://github.com/z-shell/F-Sy-H "$ZSH_DIR/f-sy-h"
fi

if [ ! -f "$ZSH_DIR/git-prompt.sh" ]; then
  echo "Installing git-prompt.sh..."
  curl -o "$ZSH_DIR/git-prompt.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

# ----- Copy .zshrc -----
echo "Copying .zshrc..."
if [ -f "$HOME/.zshrc" ]; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
  echo "Existing .zshrc backed up."
fi
cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# ----- Claude Code settings -----
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR/output-styles"

if [ -f "$DOTFILES_DIR/.claude/settings.json" ]; then
  echo "Copying Claude Code settings..."
  cp "$DOTFILES_DIR/.claude/settings.json" "$CLAUDE_DIR/settings.json"
fi

if [ -d "$DOTFILES_DIR/.claude/output-styles" ]; then
  cp "$DOTFILES_DIR/.claude/output-styles"/* "$CLAUDE_DIR/output-styles/"
fi

# ----- Claude Code -----
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
fi

# ----- Google Cloud SDK -----
GCLOUD_DIR="$HOME/Downloads/google-cloud-sdk"
if [ ! -d "$GCLOUD_DIR" ]; then
  echo ""
  echo "[Manual] Google Cloud SDK is not installed."
  echo "  Download from: https://cloud.google.com/sdk/docs/install"
fi

# ----- uv (Python) -----
if ! command -v uv &>/dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# ----- Rye (Python) -----
if [ ! -f "$HOME/.rye/env" ]; then
  echo "Installing Rye..."
  curl -sSf https://rye.astral.sh/get | bash
fi

echo ""
echo "=== Setup complete ==="
echo "Run 'source ~/.zshrc' or restart your terminal."
