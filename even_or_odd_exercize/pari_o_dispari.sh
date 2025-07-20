#!/bin/bash

evenOrOdd() {
    local number=$1
    for i in $(seq 1 $number) ; do
        
        if (( i % 2 == 0 )); then
            echo "$i è pari"
        else
            echo "$i è dispari"
        fi
    done
}

while true; do
    read -p "Inserisci un numero: " user_input

    if [[ "$user_input" =~ ^[0-9]+$ ]]; then
        evenOrOdd "$user_input"
        break 
    else
        echo "Errore: Devi inserire un numero, non una stringa! Riprova."
    fi
done

