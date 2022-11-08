# .files

dotfiles repository targeting Linux systems.

## Requisites
.files uses `stow` to create links to the config files. 
```
apt-get -y install stow
```

## Installation

1. Download the repository to your system following one of the available methods:
    - Run the command below to clone or download (depending on `git`, `curl`, `wget` availability) the dotfiles repository to `~/.dotfiles`.
      ```
      bash -c "`curl -fsSL https://raw.githubusercontent.com/oravla5/dotfiles/master/remote-install.sh`"
      ```

    - Clone the repository
      ```
      git clone https://github.com/oravla5/dotfiles.git ~/.dotfiles
      ```
1. `cd` into the repository directory and configure the dotfiles using `make`
   ```
   cd ~/.dotfiles
   ```
   ```
   make all
   ```

## Credits
This `dotfiles` repository is heavily inspired by [webpro/dotfiles](https://github.com/webpro/dotfiles).




