#!/usr/bin/env bash

cd "$HOME" || exit 1

if [[ $# -eq 1 ]]; then
  selected=${1%/}
else
  directories=(
    "$HOME/dev/"
    "$HOME/dotfiles/"
  )

  declare -A running
  while IFS= read -r path; do
    running[$path]=1
  done < <(tmux list-sessions -F '#{session_path}' 2>/dev/null)

  # Each line is "<path>\t<label>": fzf shows the label, the script reads the path
  active=()
  inactive=()
  while IFS= read -r directory; do
    relative=${directory#"$HOME"/}
    if [[ -n ${running[$directory]} ]]; then
      active+=("$relative"$'\t\e[32m●\e[0m '"$relative")
    else
      inactive+=("$relative"$'\t  '"$relative")
    fi
  done < <(fd -HI -t d '^\.git$' "${directories[@]}" --max-depth 5 --exclude 'dot*' --exec dirname {})

  selected=$(printf '%s\n' "${active[@]}" "${inactive[@]}" |
    fzf --ansi --delimiter='\t' --with-nth=2 \
      --preview 'eza -1 --icons=always --group-directories-first --color=always "$HOME"/{1}' |
    cut -f1)

  if [[ -n $selected ]]; then
    selected="$HOME/$selected"
  fi
fi

if [[ -z $selected ]]; then
  exit 0
fi

name=${selected##*/}
session=${name//./_}

if ! tmux has-session -t="$session" 2>/dev/null; then
  tmux new-session -ds "$session" -n nvim -c "$selected" nvim
  tmux new-window -t "$session" -n opencode -c "$selected" opencode
  tmux new-window -t "$session" -c "$selected"
  tmux select-window -t "$session:zsh"
fi

if [[ -z $TMUX ]]; then
  tmux attach -t "$session"
else
  tmux switch-client -t "$session"
fi
