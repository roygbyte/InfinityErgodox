#!/bin/bash

# Script for installing a QMK layout from JSON.
# This script comes with no warranty! Be-ware!
#
# TODO: Replace custom_layout with something related to user's .json 
# TODO:

PROJECT_DIR=$PWD

echo "Hi! Welcome to the EZ-Walk QMK firmware installer."
echo "Please execute this script from inside a directory"
echo "that also contains your QMK json file."
echo "--------------------------------------------------"

# Ask user to confirm correct setup

read -p "Is this something you have done? (y/n): " CONTINUE

if test $CONTINUE == "n"
then
    echo "Please correctly setup script as per above!"
    exit
fi
    
# Ask user for the json file

read -p "Please enter QMK json filename: " FILE_NAME

# Check if file exists

if test -f $PWD/$FILE_NAME
then
    echo "-- Found your QMK file"
else
    echo "-- File does not exist!"
    exit
fi
 
# Check to see if we need to clone QMK firmware repo

if test -d "$PWD/qmk_firmware"
then
   echo "-- Found QMK firmware repo"
   read -p "Overwrite? (y/n):" OVERWRITE
else
   OVERWRITE="y"
fi

if test $OVERWRITE == "y"
then
    git clone --recursive https://github.com/qmk/qmk_firmware.git
fi

# Change into firmware directory, bring our JSON file too

cp $FILE_NAME qmk_firmware/$FILE_NAME
cd qmk_firmware

# Install dependencies

echo "-- Installing dependencies"
util/qmk_install.sh

# Compile JSON

echo "-- Compiling JSON"
bin/qmk json2c --output keymap.c $FILE_NAME

# Move keymap into directory

mkdir keyboards/ergodox_infinity/keymaps/custom_keymap
mv keymap.c keyboards/ergodox_infinity/keymaps/custom_keymap

# Make layout, set left master as a default

MASTER="left"

echo "Preparing to build layout"
read -p "Master on left or right side? (left/right): " MASTER
make ergodox_infinity:custom_keymap

# Flash it

echo "Please plug in keyboard that is *not* the $MASTER side"
make ergodox_infinity:custom_keymap:dfu-util

# Make layout for other side

make ergodox_infinity:custom_keymap MASTER=$MASTER
echo "Please plug in keyboard that *is* $MASTER side"
make ergodox_infinity:custom_keymap:dfu-util MASTER=$MASTER

# Finish up

echo "All done! Would you like this script to cleanup the directory?"
read -p "Delete installation files (y/n): " CLEANUP

if test $CLEANUP == "n"
then
   exit
fi

cd $PROJECT_DIR

if test -d "qmk_firmware"
then
    rm -R qmk_firmware
fi

   
