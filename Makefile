SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BIN_DIR := $(DOTFILES_DIR)/bin
PROGRAMS_DIR := $(HOME)/.programs
PATH := $(BIN_DIR):$(BIN_DIR)/install:$(BIN_DIR)/clean:$(PATH)
sudo := $(shell is-supported "is-executable sudo" sudo) 

NVIM_VERSION = v0.8.0
FZF_VERSION = 0.34.0
GIT_VERSION = 2.26.0
ALACRITTY_VERSION = 0.10.1

export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)

.PHONY: clean

all: setup-linux 

setup-linux: link install

stow-linux:
	@(is-executable stow || (echo -e "\033[1;91mstow is not installed.\033[0m Please install with 'apt-get install stow'"; sh -c 'exit 1'))

link: stow-linux
	@(for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done)
	@(mkdir -p $(XDG_CONFIG_HOME))
	@(stow -t $(HOME) runcom)
	@(stow -t $(XDG_CONFIG_HOME) config)

unlink: stow-linux
	@(stow --delete -t $(HOME) runcom)
	@(stow --delete -t $(XDG_CONFIG_HOME) config)
	@(for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done)

install: setup-fonts setup-fzf setup-nvim 

setup-nvim: link setup-fonts
	@(install-nvim $(NVIM_VERSION) $(PROGRAMS_DIR) $(XDG_CONFIG_HOME) || (echo -e "\033[1;91m[ERROR] Error installing Neovim\033[0m"; sh -c 'exit 1'))

setup-fzf:
	@(install-fzf $(FZF_VERSION) $(PROGRAMS_DIR) || (echo -e "\033[1;91m[ERROR] Error installing fzf.\033[0m"; sh -c 'exit 1'))

setup-fonts:
	@(install-fonts JetBrainsMono $(PROGRAMS_DIR) || (echo -e "\033[1;91m[ERROR] Error installing fonts.\033[0m"; sh -c 'exit 1'))

setup-alacritty:
	@(install-alacritty $(PROGRAMS_DIR) || (echo -e "\034[1;91m[ERROR] Error installing alacritty.\033[0m"; sh -c 'exit 1'))

clean: unlink
	@(clean-nvim $(PROGRAMS_DIR) $(XDG_CONFIG_HOME) || (echo -e "\033[1;91m[ERROR] Error cleaning Neovim.\033[0m"; sh -c 'exit 1'))
	@(clean-fzf $(PROGRAMS_DIR) || (echo -e "\033[1;91m[ERROR] Error cleaning fzf.\033[0m"; sh -c 'exit 1'))
	@(clean-fonts $(PROGRAMS_DIR) || (echo -e "\033[1;91m[ERROR] Error cleaning fonts.\033[0m"; sh -c 'exit 1'))
