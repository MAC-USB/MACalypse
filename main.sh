#!/bin/bash

### Directorio del script ###
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

### Dependencias ###
source $SCRIPT_DIR/src/colors.sh
source $SCRIPT_DIR/src/config.sh

### Variables ###
TEMP=$SCRIPT_DIR/tmp
SCRIPTS_DIR=$SCRIPT_DIR/scripts
FINALES_DIR=$SCRIPTS_DIR/finales
ASCII_DIR=$SCRIPT_DIR/src/ascii
WORLD_GEN=$SCRIPTS_DIR/world_generator.sh
START=$SCRIPTS_DIR/start.sh
ANIMATION=$SCRIPT_DIR/animation/animation.sh
INTRO=$SCRIPTS_DIR/intro.sh
WORLD=$SCRIPTS_DIR/world.sh
FINALES=$SCRIPTS_DIR/finales.sh
CREDITS=$SCRIPTS_DIR/credits.sh

### Exec ###
honey_trap
source $WORLD_GEN
source $START
charger_screen
source $ANIMATION
charger_screen
source $INTRO
charger_screen
source $WORLD