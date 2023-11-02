#!/bin/bash

### Variables ###
HOME_DIR=$SCRIPTS_DIR/world/home
PROMPT_HOME="${GREEN}${PLAYER}@world${NC}:${BLUE}/home${NC}$ "

### Main ###
function main {
    while true
    do
        clear
        cat $ASCII_DIR/home.ascii | pv -qL 5000
        instructions_home
        if home
        then
            break
        fi
    done
}

### Funciones ###
function instructions_home {
    echo ""
    echo -e "${bold}Comandos disponibles:${NC}" | pv -qL100
    echo -e "${YELLOW}ls${NC}: para listar tus pertenencias."
    echo -e "${YELLOW}cd${NC}: sin argumentos para regresar al mapa mundi."
    echo -e "${YELLOW}cat [ARCHIVO]${NC}: para revisar con detalle tus pertenencias."
    echo -e "${YELLOW}help${NC}: para mostrar las instrucciones de nuevo."
    echo ""
}

function home {
    while true
    do
        read -e -p "$( echo -e "${PROMPT_HOME}" )" COMMAND
        history -s "$COMMAND"
        case $COMMAND in
            "ls")
                if [[ -n $( ls 2> /dev/null ) ]]
                then
                    echo ""
                    echo -e "Listando ${YELLOW}pertenencias${NC}..." | pv -qL100
                    echo ""
                    ls --color=auto
                    echo ""
                fi
            ;;
            "cat"*)
                ARGS=$(wc -w <<< "$COMMAND")
                if [ $ARGS -eq 1 ]
                then
                    :
                elif [ $ARGS -eq 2 ]
                then
                    FILE="$(echo "${COMMAND}" | cut -d' ' -f2)"
                    if [[ -f $FILE ]]
                    then
                        source $HOME_DIR/$FILE
                        return 1
                    else
                        echo "cat: $FILE: No existe el fichero o el directorio"
                    fi
                else
                    echo "cat: demasiados argumentos"
                fi
            ;;
            "cd"*)
                ARGS=$(wc -w <<< "$COMMAND")
                if [ $ARGS -eq 1 ]
                then
                    echo ""
                    echo "Regresando al mapa mundi..." | pv -qL100
                    echo ""
                    sleep 1
                    return 0
                elif [ $ARGS -eq 2 ]
                then
                    echo "cd: $DIR: No existe el fichero o el directorio"
                else
                    echo "cd: demasiados argumentos"
                fi
            ;;
            "help")
                instructions_home
            ;;
            "")
                :
            ;;
            *)
                echo "${COMMAND}: orden no encontrada"
            ;;
        esac
    done
}

### Exec ###
main