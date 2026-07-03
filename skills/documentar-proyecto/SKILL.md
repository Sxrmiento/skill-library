---
name: documentar-proyecto
description: Protocolo para escribir o actualizar la documentación de un proyecto — README, quickstart, ejemplos, changelog. Úsalo cuando el usuario pida documentar, cuando un proyecto vaya a compartirse o publicarse, o cuando el contrato de calidad declare el ámbito de experiencia (DX). La medida del éxito es una sola: alguien que no eres tú lo clona y lo corre en menos de 5 minutos.
metadata:
  version: 1.0.0
  audited: "propia"
---

# Documentar un proyecto

La documentación no se mide por completa sino por **usable**: su test de aceptación es una máquina limpia y un cronómetro.

## El README (en este orden)

1. **Qué es y para quién** — un párrafo. Qué problema resuelve y qué lo diferencia de la alternativa obvia. Si no puedes decirlo en un párrafo, el problema no es el README.
2. **Quickstart** — de `git clone` a "funciona" en <5 minutos: requisitos exactos (versiones), instalación, el comando mínimo que produce un resultado visible. Sin pasos implícitos ("configura tu entorno") — cada paso es un comando copiable.
3. **Ejemplos ejecutables** — 2-3 casos de uso reales, con su salida esperada. Un ejemplo que no se puede copiar-pegar-correr es decoración.
4. **Configuración** — variables de entorno y opciones, con defaults y un `.env.example` si aplica.
5. **Cómo testear / contribuir** — el comando del suite y las reglas del repo.
6. **Licencia.**

## Reglas

- **El quickstart se verifica ejecutándolo**, pasos exactos del README en un entorno limpio (contenedor, venv nuevo, clone fresco). Un README que no se ha seguido literalmente miente en algún paso — siempre.
- **Los ejemplos no pueden mentir**: engánchalos a la verdad con doctests, tests que ejecutan los snippets, o CI que corre el quickstart. Documentación no verificada = documentación vencida en 3 commits.
- **Documenta el porqué, no solo el qué**: las decisiones de diseño no obvias (por qué X y no Y) van en el código o en `docs/decisiones.md`. El "qué hace" ya lo dice el código; el "por qué así" se pierde si no se escribe.
- **Changelog** si el proyecto tiene usuarios o versiones: qué cambió, qué rompe, cómo migrar. Formato Keep a Changelog + semver.
- **No documentes lo que el linter/tipos ya dicen**: docstrings que repiten la firma son ruido que se desincroniza.

## Señales de documentación rota

Un issue/pregunta repetida dos veces = un hueco en el README. La documentación crece por extracción de preguntas reales, igual que las skills.

## Qué NO es

- No es para docs internas de cada módulo (eso es trabajo del código legible y sus tests).
- No genera wikis kilométricas: si una sección no responde a una pregunta que alguien de verdad tendrá, sobra.
