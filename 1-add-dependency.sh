#!/bin/bash
set -e

MODULE=$1

echo "Verifying location of Scratch source is known"
if [ -z "$SCRATCH_SRC_HOME" ]; then
    echo "Error: SCRATCH_SRC_HOME environment variable is not set."
    exit 1
fi

echo "Adding new dependency"
cd $SCRATCH_SRC_HOME/scratch-vm
npm install --save $MODULE

