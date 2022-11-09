SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BIN_DIR := $(DOTFILES_DIR)/bin
PROGRAMS_DIR := $(HOME)/.programs
PATH := $(BIN_DIR):$(BIN_DIR)/install:$(BIN_DIR)/clean:$(PATH)
sudo := $(shell is-supported "is-executable sudo" sudo) 

NVIM_VERSION = v0.8.0

export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)

.PHONY: clean

all: setup-linux 

setup-linux: link linux-nvim 

stow-linux:
	@(is-executable stow || (echo -e "\033[1;91mstow is not installed.\033[0m Please install with 'apt-get install stow'"; sh -c 'exit 1'))

link: stow-linux
	@(mkdir -p $(XDG_CONFIG_HOME))
	@(stow -t $(XDG_CONFIG_HOME) config)

unlink: stow-linux
	@(stow --delete -t $(XDG_CONFIG_HOME) config)

linux-nvim:
	@(install-nvim $(NVIM_VERSION) $(PROGRAMS_DIR) || (echo -e "\033[1;91m[ERROR] Error installing Neovim\033[0m"; sh -c 'exit 1'))
	@(nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'; printf '\n'  || (echo -e "\033[1;91m[ERROR] Error syncing Packer."; sh -c 'exit 1'))

clean: unlink
	@(clean-nvim $(PROGRAMS_DIR) || (echo -e "\033[1;91m[ERROR] Error cleaning Neovim.\033[0m"; sh -c 'exit 1'))