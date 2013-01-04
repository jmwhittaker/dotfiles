#!/bin/bash

#######################
# This script will create symlinks from dotfiles directory to
# the correct places
#######################

DOTFILES_DIRECTORY="${HOME}/dotfiles"

cd ${DOTFILES_DIRECTORY}

source ./lib/utils

link() {
    #Force create/replace the symlink
    ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

mirrorfiles() {
    # Create the symbolic links between the 'dotfiles' and 'HOME' directory
    # 'bash_profile' sources other files directly from the 'dotfiles' repository

    link "bash/bashrc"              ".bashrc"
    link "bash/bash_profile"        ".bash_profile"
    link "bash/inputrc"             ".inputrc"

    e_success "Dotfiles updated successfully."
}

# Verify that we want to proceed
printf "\n"
e_error "Warning: This step MAY overwrite your existing dotfiles!"
read -p "Continue? (y/n) " -n 1
printf "\n"

if [[ $REPLY =~ ^[Yy]$ ]]; then
    mirrorfiles
    source ${HOME}/.bash_profile
else
    printf "Aborting..\n"
    exit 1
fi
