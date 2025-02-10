#!/bin/bash

REPO_DIR="/root/Proyecto"

COMMIT_MSG="Auto commit: $(date '+%Y-%m-%d %H:%M:%S')"

cd "$REPO_DIR" || exit

if [[ -n $(git status --porcelain) ]]; then
    echo "Se detectaron cambios, haciendo commit..."

    git add .

    git commit -m "$COMMIT_MSG"

    git push origin main 

    echo "Commit y push realizados correctamente."
else
    echo "No hay cambios para hacer commit."
fi

