#!/bin/bash

# SPDX-License-Identifier: Unlicense

function fail {
    echo "pydeploy.sh: $1 failed, aborting deploy"
    exit 1
}

python -m build --sdist
if [ $? != "0" ]
then
    fail "sdist"
fi

python -m build --wheel
if [ $? != "0" ]
then
    fail "wheel"
fi

twine upload dist/*
if [ $? != "0" ]
then
    fail "twine"
fi
