#!/bin/bash

# This is free and unencumbered software released into the public domain.

# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.

# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# For more information, please refer to <https://unlicense.org>


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
