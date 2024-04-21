#!/bin/bash

if [[ "$1" == "--date" || "$1" == "-d" ]]; then
    date
    exit 0
elif [[ "$1" == "--logs" || "$1" == "-l" ]]; then
    if [ -z "$2" ]; then
        for ((i=1; i<=100; i++)); do
            filename="log${i}.txt"
            echo "Nazwa pliku: $filename" > "$filename"
            echo "Skrypt: $0" >> "$filename"
            echo "Data utworzenia: $(date)" >> "$filename"
        done
        echo "Utworzono 100 plików z logami."
        exit 0
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
    exit 0
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Użycie: ./skrypt.sh [OPCJA]"
    echo "OPCJE:"
    echo "  --date, -d       Wyświetla aktualną datę."
    echo "  --logs [N], -l [N]   Tworzy pliki z logami, gdzie N to liczba plików do utworzenia."
    echo "                     Jeśli N nie zostanie podane, utworzy 100 plików z logami."
    echo "  --help, -h       Wyświetla pomoc."
    exit 0
elif [[ "$1" == "--init" ]]; then
    if [ -z "$2" ]; then
        echo "Błąd: Podaj nazwę katalogu docelowego."
        exit 1
    fi
    
    git clone <url_repozytorium> "$2"
    export PATH="$PATH:$(pwd)/$2"
    echo "Repozytorium zostało sklonowane do katalogu $2 i dodane do zmiennej środowiskowej PATH."
    exit 0
elif [[ "$1" == "--error" || "$1" == "-e" ]]; then
    num_files="${2:-100}"
    
    if ! [[ "$num_files" =~ ^[0-9]+$ ]]; then
        echo "Błąd: Podana wartość nie jest liczbą całkowitą dodatnią."
        exit 1
    fi

    mkdir -p errorx
    for ((i=1; i<=$num_files; i++)); do
        filename="errorx/error${i}.txt"
        echo "Nazwa pliku: $filename" > "$filename"
        echo "Skrypt: $0" >> "$filename"
        echo "Data utworzenia: $(date)" >> "$filename"
    done
    echo "Utworzono $num_files plików w katalogu errorx."
    exit 0
elif [[ "$1" == "--gitignore" ]]; then
    echo "errorx/" >> .gitignore
    echo "Zaktualizowano plik .gitignore."
    exit 0
else
    echo "Błąd: Niepoprawna opcja. Użyj ./skrypt.sh --help, aby wyświetlić dostępne opcje."
    exit 1
fi
