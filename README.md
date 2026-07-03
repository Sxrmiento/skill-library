# Skill Library

Catálogo personal de skills reutilizables para Claude Code. Estas skills **no** son universales (esas viven en [claude-os](../claude-os)): se instalan por proyecto, cuando aplican.

## Reglas de la librería

1. **Nada entra sin auditoría.** Toda skill de origen externo pasa por la skill `auditar-skill` de claude-os ANTES de llegar aquí. El veredicto queda registrado en el frontmatter (`audited:`) y en el catálogo de abajo.
2. **Instalación por proyecto**, no global: `./install.sh <skill> <ruta-del-proyecto>` copia la skill a `<proyecto>/.claude/skills/`.
3. Al arrancar un proyecto (skill `arrancar` de claude-os), se revisa este catálogo y se instalan solo las skills relevantes.
4. Actualizar una skill desde su origen externo = re-auditar desde cero.

## Catálogo

| Skill | Qué hace | Origen | Auditoría |
|-------|----------|--------|-----------|
| `media-gen` | Genera imágenes y video con Fal.ai (texto→imagen, imagen→video, upscale Topaz) | Script externo de repo git; SKILL.md/configs propios | 2026-07-03 — APTA CON CONDICIONES: sube archivos de referencia a Fal.ai → prohibido pasarle datos personales o contenido de menores |

## Añadir una skill nueva

1. Descarga en cuarentena y corre `auditar-skill` (claude-os).
2. Si es APTA: copia a `skills/<nombre>/`, completa su SKILL.md (frontmatter con `audited:`), añade la fila al catálogo.

