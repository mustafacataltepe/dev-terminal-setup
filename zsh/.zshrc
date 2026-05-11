# --- Instant prompt MUST stay at top ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Powerlevel10k config (MOVE THIS UP) ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# --- zoxide ---
eval "$(zoxide init zsh)"
alias cd="z"
alias j="z"

# --- Aliases ---
alias dps="docker ps"
alias dlog="docker logs -f"
alias dexec="docker exec -it"
dstop() { docker stop $(docker ps -q); }

alias gs="git status"
alias ga="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# --- fzf ---
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# Better UI
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# --- fzf installer integration ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- SDKMAN (Java version manager) ---
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# --- Docker ---
export DOCKER_BUILDKIT=1

# ── AI / LLM ──────────────────────────────────────────────────
alias ai='ollama run qwen3:8b'                          # quick chat
alias aic='ollama run qwen2.5-coder:14b'                # code chat
alias aid='aider --model ollama/deepseek-r1:14b'        # aider default
alias aidr='aider --model ollama/deepseek-r1:14b --no-auto-commits'  # manual commits
alias oc='opencode'                                     # opencode TUI
alias hm='hermes'                                       # hermes agent

# ── Dev layout ────────────────────────────────────────────────
alias dev='tmux new-window \; split-window -h -p 35 \; send-keys "aider --model ollama/deepseek-r1:14b" Enter \; select-pane -t 0'
