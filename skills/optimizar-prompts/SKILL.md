---
name: optimizar-prompts
description: Ingeniería de prompts sistemática para los LLMs dentro de tus productos (system prompts, prompts de agentes, plantillas). Úsalo al escribir un prompt de producción nuevo, cuando un prompt "a veces funciona y a veces no", o antes de culpar al modelo. Regla: un cambio de prompt sin eval que lo mida es fe, no ingeniería.
metadata:
  version: 1.0.0
  audited: "propia"
---

# Optimizar prompts

Requiere `evals-llm`: sin un eval, "este prompt es mejor" significa "me gustaron las dos respuestas que vi". El ciclo es el mismo que TDD: caso que falla → cambio de prompt → eval completo → comparar contra baseline.

## Estructura de un prompt de producción

En este orden, cada bloque con su función:

1. **Rol y objetivo** — quién es el modelo y qué resultado se espera de él (una frase útil supera tres párrafos de personalidad).
2. **Contexto** — los datos/documentos que necesita. Solo lo relevante: el contexto irrelevante no es neutro, diluye y confunde.
3. **Instrucciones** — reglas de comportamiento, ordenadas de más a menos importante. Positivas y concretas: "responde en máximo 3 frases" funciona; "no seas verboso" no (¿cuánto es verboso?).
4. **Formato de salida** — estructura exacta esperada; si es JSON, el esquema con un ejemplo válido.
5. **Ejemplos (few-shot)** — 2-5, elegidos entre los casos DIFÍCILES del eval, no los fáciles: el modelo generaliza desde lo que le muestras. Un ejemplo que contradice una instrucción gana el ejemplo — revísalos juntos.

## El ciclo de iteración

1. Corre el eval; **lee los transcripts de los casos que fallan** (no el score: los outputs). El patrón de fallo te dice qué bloque tocar.
2. **Una variable por iteración** — una instrucción, un ejemplo, un reorden. Cambiar tres cosas y mejorar no te enseña nada (misma regla que `depurar` fase 3).
3. Eval completo contra baseline. Mejora real = sube sin romper lo que pasaba.
4. **Versiona los prompts en el repo** como el código que son: en archivos, con historial de git, no incrustados en strings de 200 líneas ni "en la cabeza". Cambio de prompt = commit revisable.

## Patrones de fallo comunes

- **Instrucción ignorada** → suele estar enterrada en medio; súbela, o conviértela en formato estructural (si quieres 3 items, pide una lista de 3, no "sé breve").
- **Formato inconsistente** → falta ejemplo del formato exacto, o hay dos instrucciones de formato en conflicto.
- **Se inventa cosas** → el contexto no contiene la respuesta y no le dijiste qué hacer en ese caso; añade la salida para "no está en el contexto".
- **Prompt de 400 líneas que nadie entiende** → el prompt también acumula deuda: instrucciones muertas de iteraciones viejas que ya nadie recuerda por qué están. Poda contra el eval (si al quitarla nada cae, sobraba).
- **Todo falla un poco** → quizá no es el prompt: modelo insuficiente para la tarea, o la tarea necesita dividirse en pasos (un prompt por paso supera al prompt-dios).

## Qué NO es

- No es para prompts de una conversación puntual conmigo — es para los prompts DENTRO de tus productos.
- No sustituye elegir bien el modelo: el mejor prompt sobre el modelo equivocado pierde contra un prompt mediocre sobre el correcto. Si el eval no mejora tras iterar en serio, prueba el siguiente modelo y compara con el mismo eval.
