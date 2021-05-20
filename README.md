Huzzah! Files for flashing my Infinity Ergodox Rev 1.2b with a juicy Dvorak layout. 

## How to do 'er

### Using the QMK Configurator
First, visit the [QMK Configurator](https://config.qmk.fm/#/ergodox_infinity/LAYOUT_ergodox). 

Click "Import QMK keymap from JSON file"

Then paste the link to [dvorak.json](https://raw.githubusercontent.com/roygbyte/InfinityErgodox/master/dvorak.json)

Compile the layout and download the source code.

Extract the ZIP archive to your filesystem.

Open your favorite terminal emulator.

Change into the extracted directory
```
$ cd qmk_firmware
```

Install dependencies
```
$ util/qmk_install.sh
```  

Compile JSON
```
# Note, you may have a different .json filename... be sure to use whatever came with the source code.
$ bin/qmk json2c --output keymap.c ergodox_infinity-dvorak.json
```

Move the keymap into its own directory
```
$ mkdir keyboards/ergodox_infinity/keymays/dvorak
$ mv keymap.c keyboards/ergodox_infinity/keymaps/dvorak

Make/build the default layout for the right side
``` 
make ergodox_infinity:dvorak
```

Install the firmware on the right side. Plug the right side keyboard into your computer. Restart your keyboard in 'program' mode by pressing the tiny button on the back of the keyboard. The LCD screen should turn red.
```
$ make ergodox_infinity:dvorak:dfu-util
```

Make/build the default layout for the master (left) side
```
$ make ergodox_infinity:dvorak MASTER=left
```

Install the firmware on the goofy (left) side. Plug the left side keyboard into your computer. Likewise, restart it in program mode.
``` 
make ergodox_infinity:dvorak:dfu-util MASTER=left
```

