---
name: publicar-libreria
description: Checklist obligatorio para publicar o liberar código público — paquete pip/npm, herramienta CLI, repo open source. Úsalo antes del primer release y antes de cada versión nueva. Publicar es irreversible — lo que sale al registro o a un repo público queda cacheado e indexado aunque se borre — así que la puerta se pasa ANTES del push, no después.
metadata:
  version: 1.0.0
  audited: "propia"
---

# Publicar una librería

## Puerta de seguridad (bloqueante, antes que todo)

1. **Escaneo de secretos en TODO el historial de git**, no solo en HEAD: `gitleaks detect` (o equivalente). Un token commiteado y "borrado" en un commit posterior sigue en el historial público.
2. **Sin datos personales** en ejemplos, fixtures, tests o commits (emails reales, nombres de clientes, datos de usuarios). Datos de ejemplo = datos inventados.
3. **Dependencias auditadas**: `pip-audit` / `npm audit` limpio; cada dependencia justificada (¿de verdad necesitas esa lib para 10 líneas?).
4. Nada se publica sin revisión explícita del usuario — constitución.

## Pre-flight del paquete

- **Licencia** elegida y en el repo (MIT por defecto salvo decisión contraria).
- **Nombre libre** en el registro (PyPI/npm) y no confundible con un paquete popular (tú también puedes ser el typosquat accidental).
- **Semver desde 0.1.0**: mientras sea 0.x puedes romper API; desde 1.0.0, romper API = major.
- **API pública mínima**: exporta solo lo que quieres mantener para siempre; el resto, privado (`_interno`, sin exportar). Todo lo público es un contrato que alguien va a usar del modo que no imaginaste.
- **Tipos incluidos** (py.typed / .d.ts) y metadatos completos (description, keywords, URLs, python_requires/engines).
- **README según `documentar-proyecto`** + changelog con la versión que sale.

## Build y CI

- Tests en TODAS las versiones de runtime que declaras soportar (matrix de CI) — soportar "3.10+" sin CI en 3.10 es una promesa sin test.
- Build del paquete y **instalación de prueba desde el artefacto** (`pip install dist/*.whl` en venv limpio, importar, correr el quickstart) — el bug clásico de release es el paquete al que le falta un archivo.
- Publicación con **trusted publishing** (OIDC desde CI) o token con scope mínimo a ese solo paquete. Jamás un token global en local.

## Release

1. Versión + changelog en un commit; tag `vX.Y.Z`.
2. Publicar → **verificar desde el registro** en entorno limpio: `pip install <paquete>` y correr el quickstart. Medido ahora, no asumido.
3. Release notes en GitHub (el changelog de esa versión).

## Después

- Los breaking changes se anuncian en el changelog con guía de migración, nunca se esconden en un patch.
- Issue repetido dos veces → hueco de docs o de API; se arregla en la fuente.
