#!/usr/bin/env bash

main() {
  tmux bind G run "$XDG_CONFIG_HOME/tmux/godot/menu.sh"
}

main
