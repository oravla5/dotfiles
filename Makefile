SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)

all: linux 

linux: link

stow-linux:
	is-executable stow || (echo -e "\033[1;91mstow is not installed.\033[0m Please install with 'apt-get install stow'"; sh -c 'exit 1')

link: stow-linux
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(XDG_CONFIG_HOME) config

unlink: stow-linux
	stow --delete -t $(XDG_CONFIG_HOME) config