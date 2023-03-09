#!/bin/bash
set -e

echo "Verifying location of Scratch source is known"
if [ -z "$SCRATCH_SRC_HOME" ]; then
    echo "Error: SCRATCH_SRC_HOME environment variable is not set."
    exit 1
fi

echo "Checking if Scratch source has already been customized"
if [ -e $SCRATCH_SRC_HOME/patched ]; then
    exit 1
fi

echo "Getting the location of this script"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR

echo "Adding extension to Scratch source"
cd $SCRATCH_SRC_HOME/scratch-vm/src/extensions
ln -s $DIR/your-scratch-extension your-scratch-extension

echo "Patching Scratch source to enable extension"
cd $SCRATCH_SRC_HOME/scratch-vm
git apply $DIR/patches/scratch-vm.patch
mv package.json $DIR/dependencies/package.json
ln -s $DIR/dependencies/package.json .
mv package-lock.json $DIR/dependencies/package-lock.json
ln -s $DIR/dependencies/package-lock.json .
cd $SCRATCH_SRC_HOME/scratch-gui
git apply $DIR/patches/scratch-gui.patch

echo "Copying in the Scratch extension files"
mkdir -p src/lib/libraries/extensions/yourextension
cd src/lib/libraries/extensions/yourextension
ln -s $DIR/your-extension-background.png your-extension-background.png
ln -s $DIR/your-extension-icon.png your-extension-icon.png

echo "Marking the Scratch source as customized"
touch $SCRATCH_SRC_HOME/patched