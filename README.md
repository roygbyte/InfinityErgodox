Huzzah! Files for flashing my Infinity Ergodox Rev 1.2b with a juicy Dvorak layout. 

## How to do 'er
First of all, a person can make their own changes to this layout by using the [QMK Configurator](https://config.qmk.fm/#/ergodox_infinity/LAYOUT_ergodox). Simply click "Import QMK keymap from JSON" and paste in the URL for the raw dvorak.json file. Then, when you've made your changes and are happy with your keymap, download the JSON again. If you just want to use what I've got here, then don't do this and just go on to the next step.

So... First we need to clone the QMK Firmware project to a directory on your computer.
```
$ git clone --recursive https://github.com/qmk/qmk_firmware.git
```

Now change into that directory and download the JSON file contained in this repo (or use your own JSON file).
```
$ cd qmk_firmware
$ curl -O https://raw.githubusercontent.com/roygbyte/InfinityErgodox/master/dvorak.json
```

Install dependencies required by QMK Configurator (may need sudo to complete this!)
```
$ util/qmk_install.sh
```  

Compile the JSON
```
$ bin/qmk json2c --output keymap.c dvorak.json
```

Move the keymap into its own directory
```
$ mkdir keyboards/ergodox_infinity/keymays/dvorak
$ mv keymap.c keyboards/ergodox_infinity/keymaps/dvorak
```

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
$ make ergodox_infinity:dvorak:dfu-util MASTER=left
```

