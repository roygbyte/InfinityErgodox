Huzzah! Files for flashing my Infinity Ergodox Rev 1.2b with a juicy Dvorak layout. 

## How to do 'er
```
# Clone the Github repo
git clone --recursive https://github.com/qmk/qmk_firmware.git
# Change into the directory
cd qmk_firmware
# Install dependencies
util/qmk_install.sh
# Compile JSON
bin/qmk json2c --output keymap.c ergodox_infinity-dvorak.json
# Now move the keymap.c file to its own directory
mkdir keyboards/ergodox_infinity/keymays/dvorak
mv keymap.c keyboards/ergodox_infinity/keymaps/dvorak
# Made/build the default layout for the right side
make ergodox_infinity:dvorak
# Install the firmware on the right side
#   Run the keyboard in program mode (red screen turns on)
make ergodox_infinity:dvorak:dfu-util
# Make/build the default layout for the master
make ergodox_infinity:dvorak MASTER=left
# Install the firmware on the goofy (left) side
make ergodox_infinity:dvorak:dfu-util MASTER=left
```


