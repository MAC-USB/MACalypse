#!/bin/bash

### Variables ###
LOCATION=$1
LOCATION_DIR=$SCRIPTS_DIR/world/$LOCATION
PROMPT_LOCATION="${GREEN}${PLAYER}@world${NC}:${BLUE}/$LOCATION${NC}$ "

### Main ###
function main {
    while true
    do
        clear
        cat $ASCII_DIR/$LOCATION.ascii | pv -qL 5000
        instructions_location
        if location
        then
            break
        fi
    done
}

### Funciones ###
function instructions_location {
    echo ""
    echo -e "${bold}Comandos disponibles:${NC}" | pv -qL100
    echo -e "${YELLOW}ls${NC}: para listar los archivos con los que puedes hablar."
    echo -e "${YELLOW}cd${NC}: sin argumentos para regresar al mapa mundi."
    echo -e "${YELLOW}cat [ARCHIVO]${NC}: para hablar con dicho archivo."
    echo -e "${YELLOW}rm [ARCHIVO(s)]${NC}: para ${RED}eliminar${NC} uno o varios archivos. Usa * para eliminar todos a la vez."
    echo -e "${YELLOW}help${NC}: para mostrar las instrucciones de nuevo."
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
                        source $LOCATION_DIR/$FILE
                        if grep -Fxq "${FILE}" $TEMP/$LOCATION
                            then
                                :
                            else
                                echo $FILE >> $TEMP/$LOCATION
                        fi
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
            "rm"*)
                if [[ $(ls $LOCATION_DIR | sort) = $(sort $TEMP/$LOCATION 2> /dev/null) ]]
                then
                    ARGS=$(wc -w <<< "$COMMAND")
                    if [ $ARGS -eq 1 ]
                    then
                        echo "rm: falta un operando"
                    elif [ $ARGS -gt 1 ]
                    then
                        FILES="$(echo "${COMMAND}" | cut -d' ' -f2-)"
                        IFS=" " read -r -a FILES_ARRAY <<< "${FILES}"
                        VALUE='^\*$'
                        if [[ "${FILES_ARRAY[@]}" =~ $VALUE ]]
                        then
                            if [[ $LOCATION == "bincity" ]]
                            then
                                source finales.sh neutral
                            else
                                echo -e "${RED}Eliminando${NC} todos los archivos"
                                rm *
                            fi
                        else
                            for FILE in "${FILES_ARRAY[@]}"
                            do
                                if [[ -f $FILE ]]
                                then
                                    if [[ $LOCATION == "bincity" ]]
                                    then
                                        case $FILE in
                                            "tesis_final_definitiva_no_borrar.docx")
                                                source finales.sh malo
                                            ;;
                                            "emacs")
                                                source finales.sh bueno
                                            ;;
                                            *)
                                                :
                                            ;;
                                        esac
                                    else
                                        rm $FILE
                                        echo "El archivo ${FILE} ha sido eliminado"
                                    fi
                                else
                                    echo "rm: ${FILE}: No existe el fichero o el directorio"
                                fi
                            done
                        fi
                    fi
                else
                    echo "rm: Primero debes hablar con todos los lugareños para poder usar este comando"
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