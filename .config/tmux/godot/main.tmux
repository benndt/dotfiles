#!/usr/bin/env bash

main() {
  tmux bind g run "$XDG_CONFIG_HOME/tmux/godot/menu.sh"
}

main
