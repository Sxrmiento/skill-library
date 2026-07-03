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
| `tdd` | Ciclo rojo→verde→refactor, test de comportamiento primero | Proyectos con ámbito de tests | Propia |
| `documentar-proyecto` | README quickstart <5 min, ejemplos ejecutables que no mienten, changelog | Proyectos que se comparten o publican (ámbito DX) | Propia |
| `publicar-libreria` | Checklist de release público: puerta de seguridad, semver, CI matrix, trusted publishing | Librerías y herramientas públicas | Propia |
| `evals-llm` | Evaluaciones para features con LLM: dataset de casos, graders, regresión contra baseline | Todo proyecto con LLMs en el producto | Propia |
| `optimizar-prompts` | Ingeniería de prompts iterando contra el eval, una variable a la vez, prompts versionados | Proyectos con prompts de producción | Propia |
| `escribir-skills` | Meta: cómo escribir skills que se activan y se obedecen (extracción, description, anti-patrones) | Donde se estén creando skills nuevas | Propia |
| `media-gen` | Genera imágenes y video con Fal.ai (texto→imagen, imagen→video, upscale Topaz) | Proyectos que generan media | Script externo de repo git — auditado 2026-07-03: APTA CON CONDICIONES (sube archivos de referencia a Fal.ai) |
| `differential-review` | Revisión de seguridad de diffs: blast radius, git blame de código de seguridad borrado, modelado adversarial (incluye agente adversarial-modeler) | Todo proyecto con código sensible; complementa al agente revisor | trailofbits/skills@cfe5d7b1 — auditada 2026-07-03: APTA — CC BY-SA 4.0 |
| `supply-chain-risk-auditor` | Evalúa riesgo de takeover/compromiso de dependencias vía gh (mantenedores, actividad, CVEs, contacto de seguridad) | Antes de adoptar dependencias; auditorías periódicas | trailofbits/skills@cfe5d7b1 — auditada 2026-07-03: APTA — CC BY-SA 4.0 |
| `semgrep` | Escaneo de seguridad con Semgrep en subagentes paralelos, SARIF merged (incluye agente semgrep-scanner) | Proyectos con ámbito de seguridad alto | trailofbits/skills@cfe5d7b1 — auditada 2026-07-03: APTA — CC BY-SA 4.0 |
| `codeql` | Análisis interprocedural con CodeQL: base de datos, data extensions, suites explícitas | Auditorías profundas de seguridad | trailofbits/skills@cfe5d7b1 — auditada 2026-07-03: APTA — CC BY-SA 4.0 |
| `sarif-parsing` | Procesa resultados SARIF: filtrado, deduplicación, fingerprints, jq/pysarif | Junto a semgrep/codeql | trailofbits/skills@cfe5d7b1 — auditada 2026-07-03: APTA — CC BY-SA 4.0 |
| `mutation-testing` | Configura campañas de mutation testing con mewt/muton (Rust, Go, TS/JS, Solidity) | Proyectos en esos lenguajes con contrato de tests máximo | trailofbits/skills@cfe5d7b1 — APTA — CONDICIÓN: atada a mewt/muton, NO cubre Python/mutmut — CC BY-SA 4.0 |
| `property-based-testing` | PBT con catálogo de propiedades (roundtrip, idempotencia, invariantes) y detección automática de patrones | Proyectos con serialización/parsing/validación | trailofbits/skills@cfe5d7b1 — auditada 2026-07-03: APTA — CC BY-SA 4.0 |
| `mcp-builder` | Construir servidores MCP de calidad (Python/TypeScript) con harness de evaluación | Herramientas para devs, integraciones LLM | anthropics/skills@9d2f1ae1 — auditada 2026-07-03: APTA — Apache-2.0 |
| `webapp-testing` | Testeo de apps web locales con Playwright + gestor de ciclo de vida de servidores | Todo proyecto con UI web | anthropics/skills@9d2f1ae1 — auditada 2026-07-03: APTA — Apache-2.0 (with_server.py usa shell=True: solo comandos propios) |
| `frontend-design` | Criterio de diseño anti-plantilla: tipografía, paleta, elemento firma, proceso de dos pasadas | Productos con UI que no deban verse genéricos | anthropics/skills@9d2f1ae1 — auditada 2026-07-03: APTA — Apache-2.0 |

## Añadir una skill nueva

1. Externa: descarga en cuarentena y corre `auditar-skill` (claude-os). Propia: escríbela siguiendo `escribir-skills`.
2. Copia a `skills/<nombre>/`, completa su SKILL.md (frontmatter con `audited:`), añade la fila al catálogo.
