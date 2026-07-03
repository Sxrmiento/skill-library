#!/usr/bin/env bash
# Instala una skill de la librería en el .claude/skills/ de un proyecto.
# Uso: ./install.sh <nombre-skill> <ruta-proyecto>
set -euo pipefail

LIB_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL="${1:?Uso: ./install.sh <nombre-skill> <ruta-proyecto>}"
PROJECT="${2:?Uso: ./install.sh <nombre-skill> <ruta-proyecto>}"

SRC="$LIB_DIR/skills/$SKILL"
if [[ ! -d "$SRC" ]]; then
  echo "ERROR: la skill '$SKILL' no existe en la librería. Disponibles:" >&2
  ls "$LIB_DIR/skills" >&2
  exit 1
fi
if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "ERROR: '$SKILL' no tiene SKILL.md — no es instalable." >&2
  exit 1
fi
if ! grep -q "audited:" "$SRC/SKILL.md"; then
  echo "ERROR: '$SKILL' no tiene registro de auditoría (audited:) en su SKILL.md." >&2
  echo "Pasa auditar-skill antes de instalarla. La librería no instala skills sin auditar." >&2
  exit 1
fi
if [[ ! -d "$PROJECT" ]]; then
  echo "ERROR: el proyecto '$PROJECT' no existe." >&2
  exit 1
fi

DEST="$PROJECT/.claude/skills/$SKILL"
mkdir -p "$PROJECT/.claude/skills"
if [[ -e "$DEST" ]]; then
  echo "AVISO: $DEST ya existe. Se reemplaza (la librería es la fuente de verdad)." >&2
  rm -rf "$DEST"
fi
cp -R "$SRC" "$DEST"
echo "OK: '$SKILL' instalada en $DEST"
