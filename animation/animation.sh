#!/bin/bash

ANIMATION_NAME="mac_intro"
ANIMATION_PATH="$(dirname -- "${BASH_SOURCE[0]}")/${ANIMATION_NAME}"

# This command hides the cursor, ensuring a cleaner visual output during
# the animation.
tput civis

# This function is responsible for displaying each frame of the animation.
display_frame(){
        local text=("$@")
        local rows=${#text[@]}
        local cols=${#text[0]}
        # The start_row variable calculates the starting row position for
        # displaying the frame. It ensures that the frame is vertically
        # centered on the terminal screen by subtracting the number of
        # rows in the frame from the total number of lines in the
        # terminal and dividing by 2.
        local start_row=$(( ( $(tput lines) - rows ) / 2 ))
        # The start_col variable calculates the starting column position for
        # displaying the frame. Similar to start_row, it ensures the frame
        # is horizontally centered on the terminal screen by subtracting
        # the number of columns in the frame from the total number of
        # columns in the terminal and dividing by 2.
        local start_col=$(( ( $(tput cols) - cols ) / 2 ))
        clear
        for (( i=0; i<rows; i++ )); do
                # The tput cup command moves the cursor to the specified row
                # and column position, allowing us to print the lines of the
                # frame at the correct position.
                tput cup $(( start_row + i )) $start_col
                echo -e "${text[$i]}"
        done
        sleep 0.25
}

cd $ANIMATION_PATH

frames=$(ls -1v)

for frame in $frames; do
        frameText=()
        # This loop reads each line from the current frame file.
        while IFS= read -r line; do
                frameText+=("$line")
        done < "$frame"
        display_frame "${frameText[@]}"
done

cd -

clear

# Finally, this command restores the cursor.
tput cnorm

# Credits:
# https://codehuntsatyamasciianimation.blogspot.com/2023/06/crafting-delight-journey-into-ascii.html