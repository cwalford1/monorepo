#!/usr/bin/env bash
set -e

cp ~/.bashrc ~/.bashrc_old_$(date -I)
cp ~/.inputrc ~/.inputrc_old_$(date -I)

ln -sfn "$(pwd)/bashrc" "$HOME/.bashrc"
ln -sfn "$(pwd)/inputrc" "$HOME/.inputrc"

mkdir -p $HOME/.config/tmux/
cp "$(pwd)/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
