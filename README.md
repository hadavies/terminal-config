# Terminal Config

Fast, modern terminal setup with Ghostty, Starship, and optimized zsh.

## Quick Setup

```bash
git clone https://github.com/hadavies/terminal-config.git
cd terminal-config
chmod +x install.sh
./install.sh
exec zsh
```

## What's Included

- **Ghostty** — Modern GPU-accelerated terminal emulator
- **Starship** — Git-aware prompt with real-time status
- **zsh** — Enhanced shell with:
  - Syntax highlighting
  - Auto-suggestions
  - FZF integration for history & file search
  - Git aliases & functions
- **Dependencies** — fzf, fd, bat for better CLI

## Features

### Git Integration
- Real-time branch and status display in prompt
- Quick aliases: `g` (git), `ga` (add), `gp` (push), etc.
- Fuzzy branch checkout: `gco-fzf`
- Fuzzy log search: `glf`

### Shell Keybindings
- `Ctrl+R` — Fuzzy search command history
- `Ctrl+T` — Fuzzy find files
- `Ctrl+L` — Accept auto-suggestion
- `↑/↓` — Search history backwards/forwards
- `Ctrl+W` — Delete word backwards
- `Ctrl+U` — Delete line backwards

### Better Tools
- `cat` → `bat` (syntax highlighting)
- `find` → `fd` (faster, friendlier)
- `ls` → `ls -lh` (always human-readable)

## Notes

- Auth tokens and session data stay local (not synced)
- Requires Homebrew for dependency installation
- Tested on macOS with zsh

## Customize

Edit individual files in the `config/` and `zsh/` directories to suit your preferences.
