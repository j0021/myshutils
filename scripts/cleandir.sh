#!/bin/bash

# SPDX-License-Identifier: Unlicense

DOWNLOADS_DIR=$HOME/Downloads
FILE_EXT="dmg zip jpeg jpg txt csv"

for file_ext in $FILE_EXT
do
    rm -f $DOWNLOADS_DIR/*.$file_ext
done

