# If not running interactively, don't do anythin
[ -z "$PS1" ] && return

# Resolve path of current file
CURRENT_SCRIPT=$(realpath -- "$BASH_SOURCE")
if [ $? -eq 1 ] ; then
    CURRENT_SCRIPT=$(readlink -- "$BASH_SOURCE")
fi

if [ -f $CURRENT_SCRIPT ] ; then
    DOTFILES_DIR=$(dirname $(dirname $CURRENT_SCRIPT))
else
    echo -e "\033[1;91m[.bash_profile] ERROR: Failed to locate dotfiles directory.\033[0m"
    return
fi

# Source system dotfiles

for DOTFILE in "$DOTFILES_DIR"/system/.{prompt,fzf}; do
    [ -f $DOTFILE ] && . $DOTFILE
done
# Add fzf configuration to the path
# [ -f $DOTFILES_DIR/system/.fzf ] && source $DOTFILES_DIR/system/.fzf
