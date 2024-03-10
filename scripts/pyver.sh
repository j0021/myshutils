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
