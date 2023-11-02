#!/bin/bash

### Variables ###

FINAL=$1

### Main ###
function main {
    clear
    case $FINAL in
        "bueno")
            source $FINALES_DIR/final_bueno.sh
        ;;
        "neutral")
            source $FINALES_DIR/final_neutral.sh
        ;;
        "malo")
            source $FINALES_DIR/final_malo.sh
        ;;
    esac
    source $CREDITS
    clear
    exit
}

### Exec ###
main
