#!/bin/bash

### Script para poner los créditos ###
# Se pasa como argumento el archivo de texto con los créditos

CREDITS_DIR=$SCRIPT_DIR/src/credits

python3 $CREDITS_DIR/credits.py $CREDITS_DIR/credits.txt
