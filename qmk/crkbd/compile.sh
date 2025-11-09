DIR=$HOME/.config/qmk_firmware/keyboards/crkbd/keymaps/coockoo

cp qmk/crkbd/config.h $DIR/config.h
cp qmk/crkbd/keymap.c $DIR/keymap.c

qmk compile -kb crkbd/rev4_1/standard -km coockoo
# after that you flash manually: controlled process via `qmk flash`
