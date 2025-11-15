# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Activate uwsm for Hyprland
if command -v uwsm &> /dev/null; then
  if uwsm check may-start && uwsm select; then
    exec systemd-cat -t uwsm_start uwsm start default
  fi
fi

# ZSH History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY


eval "$(starship init zsh)"


# Use Syntax Highlighting and Autosuggestions if installed
if [[ -f '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]]; then
  source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
elif [[ -f '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]]; then
  source '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
elif [[ -f '/etc/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]]; then
  source '/etc/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
fi

if [[ -f '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh' ]]; then
  source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
elif [[ -f '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' ]]; then
  source '/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh'
elif [[ -f '/etc/zsh-autosuggestions/zsh-autosuggestions.zsh' ]]; then
  source '/etc/zsh-autosuggestions/zsh-autosuggestions.zsh'
fi

alias vim='nvim'
alias c='clear'
alias update='sudo apt-get update && sudo apt-get upgrade -y'
alias weather='function _weather() { curl wttr.in/$1; }; _weather'
alias ls='eza --color=always --grid --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias ll='eza --color=always --long --git --icons=always --no-user --no-permissions'
alias la='eza --color=always --long --all --git --icons=always --no-user --no-permissions'
alias l='eza --color=always --long --git --icons=always --no-user --no-permissions'
alias ltra='eza --color=always --long --all --git --icons=always --reverse'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.profile ]; then
  . ~/.profile
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# fzf tokyonight theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"
export GCM_CREDENTIAL_STORE="gpg"


# Tmux sessionizer
bindkey -s ^f '~/.config/tmux/tmux-sessionizer.sh\n'

# Yazi cd into open directoty after closing
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Added by Toolbox App
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

[ -f ~/.config/scripts/aws-cs-login.sh ] && source ~/.config/scripts/aws-cs-login.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
