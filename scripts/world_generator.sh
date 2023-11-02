#!/bin/bash

### Variables ###
WORLD_DIR=$SCRIPT_DIR/world

function world_generator {
    # Se cambia al directorio del mundo
    cd $WORLD_DIR &&

    # Se borra cualquier posible archivo basura
    rm -rf * &&

    # Se borran los archivos temporales
    rm -rf $TEMP/* &&

    # Se crean los directorios y archivos del mundo
    mkdir {bootville,etceteria,bincity,home} &&
    touch bootville/{grubcito.cfg,linuz100realnofake.txt,initrd.img,grub.old,blacklist.txt} &&
    touch etceteria/{sysctl.conf,magic.mike,etceterio.txt,passwd,profilactico.cpp,profile,blutu.conf,system32} &&
    touch bincity/{nicolas.cage,tesis_final_definitiva_no_borrar.docx,cat,ls,jajajajja,emacs,binario.bio,JML} &&
    touch home/{channing.tatum,elixir-de-la-vida,tengo.fe} &&
    return 0 ||
    return 1
}

if world_generator &> /dev/null
then
    :
else
    echo -e "${RED}Error${NC} al generar el mundo"
    exit
fi

# Se regresa al directorio anterior
cd -
