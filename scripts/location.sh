#!/bin/bash

### Variables ###
LOCATION=$1
PROMPT_LOCATION="${GREEN}${PLAYER}@world${NC}:${BLUE}/$LOCATION${NC}$ "

### Main ###
function main {
    clear
    instructions_location
    location
}

### Funciones ###
function instructions_location {
    echo ""
    echo -e "${bold}Comandos disponibles:${NC}" | pv -qL100
    echo -e "${YELLOW}ls${NC}: para listar los archivos con los que puedes hablar." | pv -qL100
    echo -e "${YELLOW}cd${NC}: sin argumentos para regresar al mapa mundi." | pv -qL100
    echo -e "${YELLOW}cat [ARCHIVO]${NC}: para hablar con dicho archivo." | pv -qL100
    echo -e "${YELLOW}rm [ARCHIVO(s)]${NC}: para ${RED}eliminar${NC} uno o varios archivos." | pv -qL100
    echo -e "${YELLOW}help${NC}: para mostrar las instrucciones de nuevo." | pv -qL100
    echo ""
}

function location {
    while true
    do
        read -e -p "$( echo -e "${PROMPT_LOCATION}" )" COMMAND
        history -s "$COMMAND"
        case $COMMAND in
            "ls")
                if [[ -n $( ls 2> /dev/null ) ]]
                then
                    echo ""
                    echo -e "Listando ${YELLOW}archivos${NC}..." | pv -qL100
                    echo ""
                    ls --color=auto
                    echo ""
                else
                    echo ""
                    echo -e "No hay archivos que listar... :(" | pv -qL100
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
                        source $SCRIPTS_DIR/world/$LOCATION/$FILE
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
                    break
                elif [ $ARGS -eq 2 ]
                then
                    echo "cd: $DIR: No existe el fichero o el directorio"
                else
                    echo "cd: demasiados argumentos"
                fi
            ;;
            "rm"*)
                ARGS=$(wc -w <<< "$COMMAND")
                if [ $ARGS -eq 1 ]
                then
                    echo "rm: falta un operando"
                elif [ $ARGS -gt 1 ]
                then
                    FILES="$(echo "${COMMAND}" | cut -d' ' -f2-)"
                    IFS=" " read -r -a FILES_ARRAY <<< "${FILES}"
                    for FILE in "${FILES_ARRAY[@]}"
                    do
                        if [[ -f $FILE ]]
                        then
                            rm $FILE
                            echo "El archivo ${FILE} ha sido eliminado"
                        else
                            echo "rm: ${FILE}: No existe el fichero o el directorio"
                        fi
                    done
                fi
            ;;
            "help")
                instructions_location
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