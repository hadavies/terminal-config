# History configuration
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Enable zsh completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ghostty shell integration (fixes bracketed paste)
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

eval "$($HOME/.local/bin/mise activate zsh)" # added by https://mise.run/zsh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

# Starship prompt
eval "$(starship init zsh)"

# FZF integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Syntax highlighting and auto-suggestions
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  bindkey '^l' autosuggest-accept
fi

# Keybindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line

# Git aliases
alias g=git
alias ga='git add'
alias gaa='git add .'
alias gb='git branch -vv'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gco='git checkout'
alias gd='git diff'
alias gdw='git diff --word-diff'
alias gds='git diff --staged'
alias gl='git log --oneline -20'
alias gll='git log --graph --decorate --all --oneline'
alias gp='git push'
alias gpl='git pull'
alias gs='git status -s'
alias gst='git stash'
alias gr='git reset'
alias grh='git reset --hard'

# Git functions for fzf integration
# fzf + git checkout
gco-fzf() {
  git branch --format='%(refname:short)' | fzf --preview 'git log --oneline -10 {}' | xargs git checkout
}

# fzf + git log
glf() {
  git log --oneline --all | fzf --preview 'git show --stat {1}' | cut -d' ' -f1 | xargs -I {} git show {}
}

# fzf + git stash
gsf() {
  git stash list | fzf --preview 'git show {1}' | cut -d':' -f1 | xargs git stash pop
}

# Useful aliases
alias ls='ls -lh'
alias la='ls -A'
alias mkdir='mkdir -p'
alias cd='cd -P'
alias less='less -R'
alias cat='bat --style=plain'
alias find='fd'

# Check terminal-config sync status on shell start
if [ -d ~/terminal-config/.git ]; then
  {
    cd ~/terminal-config 2>/dev/null || return
    git fetch --quiet 2>/dev/null

    local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
    local changes=$(git status --porcelain 2>/dev/null)

    [ -z "$ahead" ] && ahead=0
    [ -z "$behind" ] && behind=0

    if [ "$ahead" -gt 0 ] || [ "$behind" -gt 0 ] || [ -n "$changes" ]; then
      echo ""
      [ "$ahead" -gt 0 ] && echo "📤 You have $ahead local change(s) to push"
      [ "$behind" -gt 0 ] && echo "📥 terminal-config has $behind update(s) to pull"
      [ -n "$changes" ] && echo "✏️  Uncommitted changes in terminal-config"
      echo "   → Review: cd ~/terminal-config && git status"
    fi
  } &
  disown
fi

