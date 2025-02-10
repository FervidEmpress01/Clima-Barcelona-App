#!/bin/bash

# Ruta del repositorio en WSL
REPO_DIR="/root/Proyecto"

# Mensaje de commit con fecha y hora
COMMIT_MSG="Auto commit: $(date '+%Y-%m-%d %H:%M:%S')"

# Entrar al directorio del repositorio
cd "$REPO_DIR" || exit

# Verificar si hay cambios en los archivos
if [[ -n $(git status --porcelain) ]]; then
    echo "Se detectaron cambios, haciendo commit..."

    # Agregar todos los archivos al commit
    git add .

    # Hacer commit con un mensaje automático
    git commit -m "$COMMIT_MSG"

    # Hacer push al repositorio remoto
    git push origin main  # Cambia 'main' si usas otra rama

    echo "Commit y push realizados correctamente."
else
    echo "No hay cambios para hacer commit."
fi

