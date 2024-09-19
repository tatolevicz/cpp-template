#!/bin/bash

# Verifica se o nome do projeto foi passado como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 <nome_do_projeto>"
    exit 1
fi

# Nome do novo projeto
PROJECT_NAME=$1

# Detecta o sistema operacional
OS=$(uname)

# Nome do script para excluí-lo das modificações
SCRIPT_NAME=$(basename "$0")

# Remove diretórios de build, se existirem
echo "Removendo diretórios de build..."
rm -rf cmake-build-* build-*

# Exclui diretórios de build como cmake-build-* e build-*
EXCLUDE_DIRS="cmake-build-* build-*"

# Substitui template pelo nome do projeto em todos os arquivos, exceto o script
find . -type f ! -name "$SCRIPT_NAME" ! -path "./${EXCLUDE_DIRS}/*" -exec grep -Il "template" {} + | while read -r file; do
    if [ "$OS" == "Darwin" ]; then
        # Para macOS (usar sed com extensão vazia para backup)
        sed -i '' "s/template/${PROJECT_NAME}/g" "$file"
    else
        # Para Linux
        sed -i "s/template/${PROJECT_NAME}/g" "$file"
    fi
done

# Renomeia arquivos e diretórios que contenham template, exceto o script
find . -name "*template*" ! -name "$SCRIPT_NAME" ! -path "./${EXCLUDE_DIRS}/*" | while read -r file; do
    new_file=$(echo "$file" | sed "s/template/${PROJECT_NAME}/g")
    mv "$file" "$new_file"
done

echo "Projeto ${PROJECT_NAME} criado com sucesso!"

rm -rf .git

git init