#!/bin/bash

# SPDX-License-Identifier: Unlicense

REPOS_DIR=`cat $HOME/.gitarchival | grep repos_dir | cut -d "=" -f 2`
REPOS=`cat $HOME/.gitarchival | grep repos | cut -d "=" -f 2`
ARCHIVE_DIR=`cat $HOME/.gitarchival | grep archive_dir | cut -d "=" -f 2`
TAR_FILE="gitarchival.tar.gz"

for repo in $REPOS
do
    echo "Updating $repo..."
    cd $REPOS_DIR/$repo && git pull
done

cd $REPOS_DIR
tar czf $TAR_FILE $REPOS
mv $TAR_FILE $ARCHIVE_DIR
