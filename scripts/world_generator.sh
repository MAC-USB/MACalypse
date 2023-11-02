#!/bin/bash

### Variables ###
WORLD_DIR=$SCRIPT_DIR/world

# Se cambia al directorio del mundo
cd $WORLD_DIR

# Se borra cualquier posible archivo basura
rm -rf *

# Se crean los directorios y archivos del mundo
mkdir {bootville,etceteria,bincity,home}
touch bootville/{grubcito.cfg,linuz100realnofake.txt,initrd.img,grub.old,blacklist.txt}
touch etceteria/{sysctl.conf,magic.mike,etceterio.txt,passwd,profilactico.cpp,profile,blutu.conf,system32}
touch bincity/{nicolas.cage,tesis_final_definitiva_no_borrar.docx,cat,ls,jajajajja,emacs,binario.bio,JML}

# Se regresa al directorio anterior
cd -