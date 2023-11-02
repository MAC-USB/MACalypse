#!/bin/bash

### Variables ###
PROMPT="${GREEN}${PLAYER}@world${NC}:${BLUE}/${NC}$ "
WORLD_DIR=$SCRIPT_DIR/world
WORLD_MAP=$ASCII_DIR/world_map.ascii

### Main ###
function main {
    while true
    do
        clear
        cat $WORLD_MAP | pv -qL 5000
        instructions
        if world
        then
            break
        fi
    done
}

### Funciones ###
function instructions {
    echo ""
    echo -e "${bold}Comandos disponibles:${NC}" | pv -qL100
    echo -e "${YELLOW}ls${NC}: para listar los asentamientos que puedes visitar."
    echo -e "${YELLOW}cd [ASENTAMIENTO]${NC}: para entrar en dicho asentamiento."
    echo -e "${YELLOW}help${NC}: para mostrar las instrucciones de nuevo."
    echo ""
}

function world {
    cd $WORLD_DIR/
    while true
    do
        read -e -p "$( echo -e "${PROMPT}" )" COMMAND
        history -s "$COMMAND"
        case $COMMAND in
            "ls")
                echo ""
                echo -e "Listando ${YELLOW}asentamientos${NC}..." | pv -qL100
                echo ""
                ls --color=auto
                echo ""
            ;;
            "cd"*)
                ARGS=$(wc -w <<< "$COMMAND")
                if [ $ARGS -eq 1 ]
                then
                    :
                elif [ $ARGS -eq 2 ]
                then
                    DIR="$(echo "${COMMAND}" | cut -d' ' -f2)"
                    case $DIR in
                        bincity?(\/) )
                            echo ""
                            echo -e "Entrando a ${BLUE}bincity${NC}..." | pv -qL100
                            echo ""
                            sleep 1
                            cd $WORLD_DIR/bincity/
                            source $SCRIPTS_DIR/location.sh bincity
                            return 1
                        ;;
                        bootville?(\/) )
                            echo ""
                            echo -e "Entrando a ${BLUE}bootville${NC}..." | pv -qL100
                            echo ""
                            sleep 1
                            cd $WORLD_DIR/bootville/
                            source $SCRIPTS_DIR/location.sh bootville
                            return 1
                        ;;
                        etceteria?(\/) )
                            echo ""
                            echo -e "Entrando a ${BLUE}etceteria${NC}..." | pv -qL100
                            echo ""
                            sleep 1
                            cd $WORLD_DIR/etceteria/
                            source $SCRIPTS_DIR/location.sh etceteria
                            return 1
                        ;;
                        home?(\/) )
                            echo ""
                            echo -e "Entrando a ${BLUE}home${NC}..." | pv -qL100
                            echo ""
                            sleep 1
                            cd $WORLD_DIR/home/
                            source $SCRIPTS_DIR/home.sh
                            return 1
                        ;;
                        *)
                            echo "cd: $DIR: No existe el fichero o el directorio"
                        ;;
                    esac
                else
                    echo "cd: demasiados argumentos"
                fi
            ;;
            "help")
                instructions
            ;;
            "exit")
                echo "Saliendo del script..."
                return 0
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