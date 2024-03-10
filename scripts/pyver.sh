#!/bin/bash

# SPDX-License-Identifier: Unlicense

SED_ENV=`uname`

# files config
if [ -f ".pyver" ]
then
    FILES=`cat .pyver | grep files | cut -d "=" -f 2`
else
    echo "error: .pyver config not found"
    echo "please add it in the current dir with 'files=' config with the files that need modification (separated by spaces)"
    exit 1
fi

# get current version
file_checker=`echo $FILES | cut -d " " -f 1`
current_version=`cat $file_checker | grep progver= | sed 's/\"//g' | cut -d "=" -f 2`
major_ver=`echo $current_version | cut -d "." -f 1`
minor_ver=`echo $current_version | cut -d "." -f 2`
patch_ver=`echo $current_version | cut -d "." -f 3`

# update version
if [ $1 == "patch" ]
then
    patch_ver=$(($patch_ver + 1))
elif [ $1 == "minor" ]
then
    minor_ver=$(($minor_ver + 1))
    patch_ver=0
elif [ $1 == "major" ]
then
    major_ver=$(($major_ver + 1))
    minor_ver=0
    patch_ver=0
else
    echo "Invalid option: $1"
    echo "Valid options: major minor patch"
    exit 1
fi

new_version="$major_ver.$minor_ver.$patch_ver"

# modify files with the new version
for pyfile in $FILES
do
    if [ $current_version != $new_version ]
    then
        if [ $SED_ENV == "Darwin" ]
        then
            sed -i '' s"/$current_version/$new_version/"g $pyfile
        else
            sed -i s"/$current_version/$new_version/"g $pyfile
        fi
    fi
done
