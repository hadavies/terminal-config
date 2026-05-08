#!/bin/bash
set -e

echo "Installing terminal config..."

# Get the absolute path to the repo
REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIR_NAME="$(basename "$REPO_PATH")"
DIR_PARENT="$(dirname "$REPO_PATH")"

# If the directory doesn't start with a dot, rename it
if [[ "$DIR_NAME" != .* ]]; then
  echo "Renaming $DIR_NAME to .$DIR_NAME..."
  NEW_REPO_PATH="$DIR_PARENT/.$DIR_NAME"
  mv "$REPO_PATH" "$NEW_REPO_PATH"
  REPO_PATH="$NEW_REPO_PATH"
  DIR_NAME=".$DIR_NAME"
  echo "✓ Renamed to hidden directory"
fi

# Create necessary directories
mkdir -p ~/.config/ghostty

# Create symlinks
echo "Setting up symlinks..."
ln -sf "$REPO_PATH/zsh/zshrc" ~/.zshrc
ln -sf "$REPO_PATH/config/ghostty/config" ~/.config/ghostty/config
ln -sf "$REPO_PATH/config/starship.toml" ~/.config/starship.toml

# Check for Homebrew
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew not found. Install from https://brew.sh"
  exit 1
fi

echo "Installing dependencies..."
brew install starship fzf zsh-syntax-highlighting zsh-autosuggestions bat fd

echo "✓ Terminal config installed!"
echo "→ Restart your terminal or run: exec zsh"
