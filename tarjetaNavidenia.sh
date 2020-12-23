#!/bin/bash
trap "tput reset; tput cnorm; exit" 2
clear
tput civis
lin=2
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold
tput cup 1 $col; echo \+

# ARBOL
for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    }
    let lin++
    let col--
}

tput sgr0; tput setaf 3

# TRONCO
for ((i=1; i<=2; i++))
{
    tput cup $((lin++)) $c
    echo 'mWm'
}
new_year=$(date +'%Y')
let new_year++
tput setaf 1; tput bold
tput cup $lin $((c - 15)); echo Feliz Navidad y Próspero Año $new_year
tput cup $((lin+1)) $((c - 6)); echo Les desea 
let c++
k=1


# LUCES Y DECORACIONES
while true; do
    for ((i=1; i<=35; i++)) {
        # Turn off the lights
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
            unset line[$[k-1]$i]; unset column[$[k-1]$i]  # Array cleanup
        }

        li=$((RANDOM % 9 + 3))
        start=$((c-li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + start))
        tput setaf $color; tput bold   # Switch colors
        tput cup $li $co
        echo o
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color+1)%8))

        # TEXTO PARPADEANTE
        sh=3
        for l in J U A N 
        do
            tput cup $((lin+1)) $((c+sh))
            echo $l
            let sh++
            sleep 0.03
        done

        # ESTRELLA DE LA PUNTA DEL ARBOL
        for l in +
        do
            tput cup 1 $((c));
            echo $l
            sleep 0.01
        done
    }
    k=$((k % 2 + 1))
done
