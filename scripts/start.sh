#!/bin/bash

### Variables ###
CONTINUE="Presiona [Enter] para continuar."
EXIT="Escribe 'exit' para salir."

### Main ###
function main {
    clear
    start_game
    while true
    do
        clear
        player_name
        clear
        if confirm_name
        then
            break
        fi
    done
    clear
    instructions
    sleep 1
}

### Funciones ###
function press_enter {
    echo ""
    echo $CONTINUE
    echo ""
    read -p "$ "
}

function start_game {
    echo ""
    echo $CONTINUE
    echo $EXIT
    echo ""

    read -p "$ " INPUT

    if [[ $INPUT == "exit" ]]
    then
        clear
        exit
    fi
}

function player_name {
    echo ""
    echo "Escribe un nombre." | pv -qL30
    echo "Sólo puede contener letras, números, '-', '_' y '.'"
    echo ""
    while true
    do
        read -e -p "$ " INPUT
        PATTERN="^[0-9a-zA-Z_\.-]+$"
        N_CHARACTERS=$(wc -c <<< "$INPUT")
        if [[ $INPUT == '' ]]
        then
            :
        elif [[ ! $INPUT =~ $PATTERN ]]
        then
            echo "Te dije que el nombre sólo puede contener letras, números, '-', '_' y '.'"
        elif [[ $N_CHARACTERS -gt 20 ]]
        then
            echo "Te pedí un nombre, no la historia de tu vida... (Acorta el nombre)"
        else
            PLAYER=$INPUT
            break
        fi
    done
}

function confirm_name {
    echo ""
    echo "$PLAYER... ¿Seguro que quieres usar ese nombre? [y/n]" | pv -qL30
    echo ""
    while true
    do
        read -e -p "$ " INPUT
        case $INPUT in
            "")
                :
            ;;
            [yY]|[yY][eE][sS])
                echo ""
                echo "¿En serio? No es el mejor nombre... Pero ya que." | pv -qL30
                press_enter
                return 0
            ;;
            [nN]|[nN][oO])
                echo ""
                echo "Decídete rápido y cambiálo." | pv -qL30
                press_enter
                return 1
            ;;
            *)
                echo "Por favor, responde con 'yes' o 'no'"
            ;;
        esac
    done
}

function instructions {
    echo ""
    echo "Antes de seguir, debes tomar en cuenta lo siguiente:

> Lee todo lo que aparece en pantalla.
> Sigue las intrucciones al pie de la letra.
> Aprovecha el tiempo.
> Y sobre todo, diviértete." | pv -qL30
    press_enter
    clear
    echo ""
    echo "Mucha suerte." | pv -qL5
    echo ""
}

### Exec ###
main