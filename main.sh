#!/bin/bash

### Directorio del script ###
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

### Dependencias ###
source $SCRIPT_DIR/src/colors.sh
source $SCRIPT_DIR/src/config.sh

### Variables ###
START=$SCRIPT_DIR/scripts/start.sh
ANIMATION=$SCRIPT_DIR/animation/animation.sh
WORLD=$SCRIPT_DIR/scripts/world.sh

### Exec ###
#honey_trap
source $START
charger_screen
source $ANIMATION
charger_screen
source $WORLD
