# Skill Library

Catálogo personal de skills reutilizables para Claude Code. Estas skills **no** son universales (esas viven en [claude-os](https://github.com/Sxrmiento/claude-os)): se instalan por proyecto, cuando aplican.

## Reglas de la librería

1. **Nada entra sin auditoría.** Toda skill de origen externo pasa por la skill `auditar-skill` de claude-os ANTES de llegar aquí. El veredicto queda registrado en el frontmatter (`audited:`) y en el catálogo de abajo. Las skills propias se marcan `audited: "propia"`.
2. **Instalación por proyecto**, no global: `./install.sh <skill> <ruta-del-proyecto>` copia la skill a `<proyecto>/.claude/skills/`.
3. Al arrancar un proyecto (skill `arrancar` de claude-os), se revisa este catálogo y se instalan solo las skills relevantes.
4. Actualizar una skill desde su origen externo = re-auditar desde cero.

## Catálogo

| Skill | Qué hace | Cuándo instalarla | Origen / Auditoría |
|-------|----------|-------------------|--------------------|
| `depurar` | Debugging sistemático por causa raíz (4 fases, regla de los 3 fixes, espera por condición) | Todo proyecto con código no trivial | Propia, adaptada de superpowers/systematic-debugging (MIT, `obra/superpowers@d884ae04`) — auditada 2026-07-03: APTA |
| `tdd` | Ciclo rojo→verde→refactor, test de comportamiento primero | Proyectos con ámbito de tests declarado al máximo | Propia |
| `documentar-proyecto` | README quickstart <5 min, ejemplos ejecutables que no mienten, changelog | Proyectos que se comparten o publican (ámbito DX) | Propia |
| `publicar-libreria` | Checklist de release público: puerta de seguridad, semver, CI matrix, trusted publishing | Librerías y herramientas públicas | Propia |
| `evals-llm` | Evaluaciones para features con LLM: dataset de casos, graders, regresión contra baseline | Todo proyecto con LLMs en el producto | Propia |
| `optimizar-prompts` | Ingeniería de prompts iterando contra el eval, una variable a la vez, prompts versionados | Proyectos con prompts de producción | Propia |
| `escribir-skills` | Meta: cómo escribir skills que se activan y se obedecen (extracción, description, anti-patrones) | Donde se estén creando skills nuevas | Propia |
| `media-gen` | Genera imágenes y video con Fal.ai (texto→imagen, imagen→video, upscale Topaz) | Proyectos que generan media | Script externo de repo git — auditado 2026-07-03: APTA CON CONDICIONES (sube archivos de referencia a Fal.ai → prohibido pasarle datos personales o contenido de menores) |

## Añadir una skill nueva

1. Externa: descarga en cuarentena y corre `auditar-skill` (claude-os). Propia: escríbela siguiendo `escribir-skills`.
2. Copia a `skills/<nombre>/`, completa su SKILL.md (frontmatter con `audited:`), añade la fila al catálogo.
