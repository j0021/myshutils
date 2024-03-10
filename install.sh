#!/bin/bash

# SPDX-License-Identifier: Unlicense

INSTALL_PATH="$HOME/myshutils"
PATH_CONFIG_FLAG="$HOME/.myshutilspath"

function print_log {
    echo "myshutils: $1"
}

function copy_scripts {
    print_log "installing scripts to $INSTALL_PATH"
    cp -v ./scripts/*.sh $INSTALL_PATH
    chmod +x $INSTALL_PATH/*.sh
}

function config_path {
    if [ -f $PATH_CONFIG_FLAG ]
    then
        print_log "PATH already set, skipping..."
    else
        print_log "configuring PATH on $HOME/.$1"
        echo "PATH=$PATH:$INSTALL_PATH; export PATH" >> "$HOME/.$1"
        touch $PATH_CONFIG_FLAG
    fi 
    
}


if [ -d $INSTALL_PATH ]
then
    copy_scripts
else
    mkdir $INSTALL_PATH
    copy_scripts
fi


if [ $SHELL == "/bin/zsh" ]
then
    config_path zshrc
elif [ $SHELL == "/bin/bash" ]
then
    config_path bashrc
fi

print_log "done installing scripts!"
