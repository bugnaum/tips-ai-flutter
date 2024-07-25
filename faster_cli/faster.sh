#!/bin/bash

# Caminho para o executável do Dart
DART_EXECUTABLE="dart"

# Caminho para o arquivo principal da CLI Dart
DART_SCRIPT="$(dirname "$0")/bin/faster_cli.dart"

# Verifica se o comando é "create"
if [[ "$1" == "create" ]]; then
    # Chama o script Dart com os argumentos fornecidos
    $DART_EXECUTABLE $DART_SCRIPT $@
else
    # Comando desconhecido
    echo "Unknown command: $1"
fi