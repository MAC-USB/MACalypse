#!/bin/bash

# Comando para activar el extended pattern matching
shopt -s extglob

### Funciones ###
# Función que toma señales del sistema para evitar que el usuario salga del script.
function honey_trap {
    trap attempt_to_leave SIGHUP
    trap attempt_to_leave SIGINT
    trap attempt_to_leave SIGQUIT
    trap attempt_to_leave SIGILL
    trap attempt_to_leave SIGTRAP
    trap attempt_to_leave SIGABRT
    trap attempt_to_leave SIGBUS
    trap attempt_to_leave SIGFPE
    trap attempt_to_leave SIGUSR1
    trap attempt_to_leave SIGSEGV
    trap attempt_to_leave SIGUSR2
    trap attempt_to_leave SIGPIPE
    trap attempt_to_leave SIGALRM
    trap attempt_to_leave SIGTERM
    trap attempt_to_leave SIGSTOP
    trap attempt_to_leave SIGTSTP
    echo ""
}

# Función que muestra un mensaje cuando el usuario intenta salir del script.
function attempt_to_leave {
    echo -e '\nNo puedes irte aún. Tienes un mundo que salvar.'
}

# Función que muestra un mensaje de carga de pantalla.
function charger_screen {
    clear
    echo ""
    echo -e "..." | pv -qL1
    clear
}