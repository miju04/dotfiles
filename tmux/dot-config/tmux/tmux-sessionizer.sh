#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  directories=(
    "$HOME/dev/"
    "$HOME/dotfiles/"
  )

  selected=$(fd -HI -t d '^\.git$' "${directories[@]}" --max-depth 5 --exclude 'dot*' \
    --exec dirname {} | while IFS= read -r directory; do
      printf '%s\n' "${directory#"$HOME"/}"
    done | fzf)

  if [[ -n $selected ]]; then
    selected="$HOME/$selected"
  fi
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -n nvim -c "$selected" nvim
  tmux new-window -t "$selected_name" -n opencode -c "$selected" opencode
  tmux new-window -t "$selected_name" -c "$selected"
  tmux select-window -t "$selected_name:zsh"
fi

if [[ -z $TMUX ]]; then
  tmux attach -t "$selected_name"
else
  tmux switch-client -t "$selected_name"
fi
