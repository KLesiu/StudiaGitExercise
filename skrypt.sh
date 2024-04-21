#!/bin/bash

if [ "$1" == "--date" ]; then
    date
else
    echo "Użycie: ./skrypt.sh --date"
fi

if [ "$1" == "--logs" ]; then
    if [ -z "$2" ]; then
        for ((i=1; i<=100; i++)); do
            filename="log${i}.txt"
            echo "Nazwa pliku: $filename" > "$filename"
            echo "Skrypt: $0" >> "$filename"
            echo "Data utworzenia: $(date)" >> "$filename"
        done
        echo "Utworzono 100 plików z logami."
        exit 1
    fi

    num_files="$2"
    
    if ! [[ "$num_files" =~ ^[0-9]+$ ]]; then
        echo "Podana wartość nie jest liczbą całkowitą dodatnią."
        exit 1
    fi
    
    for ((i=1; i<=$num_files; i++)); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" > "$filename"
        echo "Skrypt: $0" >> "$filename"
        echo "Data utworzenia: $(date)" >> "$filename"
    done
    echo "Utworzono $num_files plików z logami."
fi
