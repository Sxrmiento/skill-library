---
name: evals-llm
description: Protocolo para diseñar y mantener evaluaciones de features basadas en LLM (chatbots, agentes, generación, clasificación). Úsalo al construir cualquier feature cuyo output lo produce un modelo, antes de cambiar un prompt o de modelo en producción, y cuando el usuario pregunte "¿cómo sé si mi agente/prompt funciona bien?". Regla: una feature con LLM sin eval no está "hecha" — su calidad es una opinión, no una medida.
metadata:
  version: 1.0.0
  audited: "propia"
---

# Evals para features con LLM

El output de un LLM no es determinista: un test unitario normal no lo cubre, y "lo probé tres veces y se veía bien" no es verificación (regla 3 de `proceso-de-trabajo` aplicada a IA). El eval es al feature de LLM lo que el suite de tests al código.

## 1. El dataset de casos

- **Mínimo viable: 20-50 casos**; crece desde ahí. Composición: casos típicos reales + casos borde + casos adversarios (inputs confusos, maliciosos, fuera de dominio, el usuario que intenta romperlo).
- **Cada fallo observado en producción/pruebas se convierte en caso del dataset** — es el equivalente del test de regresión del bug.
- Los casos viven **versionados en el repo** (JSONL/YAML), con: input, contexto necesario, y criterio de aprobación por caso.
- Si hay datos de usuarios reales: anonimizados o sintéticos. El dataset se commitea; los datos personales no (constitución).

## 2. Los graders (cómo se califica)

En orden de preferencia:

1. **Código** siempre que se pueda: formato correcto, contiene/no-contiene X, JSON parseable, respuesta correcta exacta, longitud, idioma. Barato, determinista, sin deriva.
2. **LLM-judge con rúbrica** para lo subjetivo (tono, utilidad, fidelidad a la fuente): rúbrica explícita por criterio con escala anclada (qué es un 1, qué es un 5), no "¿es buena esta respuesta?". El judge usa un modelo ≥ al evaluado.
3. **Humano para calibrar**: una muestra calificada a mano cada cierto tiempo, comparada con el judge. Un judge no calibrado mide su propio sesgo.

Métricas separadas por dimensión (corrección, formato, seguridad, tono) — un score único esconde qué se rompió.

## 3. El ciclo de regresión

- **Baseline**: antes de tocar nada, corre el eval completo y guarda el resultado.
- **Todo cambio de prompt, modelo, temperatura o contexto re-corre el eval completo** y se compara contra baseline. Un prompt "mejorado" que sube 3 casos y rompe 7 es una regresión con buena publicidad.
- Los números se reportan medidos ahora, con el run al lado: "eval de hoy: 42/50, baseline 44/50, rotos estos 2 casos".
- El eval corre en CI si el proyecto tiene CI; como mínimo, antes de cada release.

## 4. Presupuesto y transcripts

- Guarda los transcripts de los runs (input → output → score): son tu herramienta de debugging (`depurar` fase 1 aplica: lee el output real completo, no tu recuerdo de él).
- Controla el costo: el eval mínimo viable con un modelo barato como judge corre en centavos; no necesitas GPT-de-lujo para verificar formato.

## Qué NO es

- No es benchmarking académico (MMLU y compañía): mide TU feature con TUS casos.
- No reemplaza los tests del código que rodea al LLM (parsing, retries, fallbacks — eso es TDD normal).
- No se hace "después de lanzar": sin eval no hay definición de mejor/peor, y cada cambio de prompt es un volado.
