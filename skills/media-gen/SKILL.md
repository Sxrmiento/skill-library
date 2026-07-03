---
name: media-gen
description: Genera imágenes y video con Fal.ai — texto a imagen, imagen a video, y upscale con Topaz. Úsala cuando el usuario pida generar o crear una imagen, animar una imagen en video, o upscalear/mejorar la resolución de una imagen o video. Requiere FAL_KEY en el entorno y fal-client instalado.
metadata:
  version: 1.0.0
  audited: "2026-07-03 — script scripts/generate.py de repo externo, revisado línea a línea — APTA CON CONDICIONES (sube archivos de referencia a Fal.ai)"
---

# media-gen

Genera media con Fal.ai usando `scripts/generate.py`. El script imprime una línea JSON en stdout con las rutas de lo generado.

## Requisitos (verifica antes de usar)

1. `FAL_KEY` en el entorno. Si falta, el script sale con código 3 — pide al usuario configurarla, nunca la pidas en texto plano en el chat.
2. `pip install fal-client`.
3. `ffmpeg`/`ffprobe` (opcional, solo para el upscale con control de fps).

## Comandos

```bash
# Imagen desde texto
python scripts/generate.py image --prompt "<descripción>" --title "<slug>" [--aspect-ratio 16:9] [--resolution 2K] [--input-image <ruta>]

# Video desde una imagen existente (la carpeta la crea el paso anterior)
python scripts/generate.py video --image <ruta> --prompt "<movimiento>" --title "<slug>" --folder <carpeta>

# Upscale (preserva aspect ratio; --fps 30 evita que Topaz duplique el precio a 60fps)
python scripts/generate.py upscale --input <ruta> [--target-height 1080] [--fps 30]
```

Los modelos y el default se definen en `models.json`; la carpeta de salida en `config.json`. Si Fal renombra un modelo (pasa a menudo), se edita `models.json`, no el script. Verifica los ids vigentes en fal.ai/models si un modelo devuelve 404.

## Condiciones de la auditoría (obligatorias)

- Toda imagen o video pasado como referencia **se sube a los servidores de Fal.ai**. Prohibido pasarle archivos con datos personales, caras de personas reales sin permiso, o CUALQUIER contenido de menores.
- Antes de subir un archivo de referencia, decirlo explícitamente al usuario: "esto se sube a Fal".

## Origen

`scripts/generate.py` proviene de un repo git externo; auditado el 2026-07-03: allowlist de hosts para descargas, contención de rutas en output_dir, sin exfiltración, sin eval/exec/shell=True. `SKILL.md`, `config.json` y `models.json` son propios. Si se actualiza el script desde el origen, re-auditar con `auditar-skill` ANTES de reemplazarlo.
