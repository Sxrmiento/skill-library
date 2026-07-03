---
name: escribir-skills
description: Meta-skill — cómo escribir buenas skills para Claude Code. Úsala al crear una skill nueva para claude-os o skill-library, al notar que repites la misma instrucción por tercera vez (señal de que hay una skill esperando existir), o al revisar por qué una skill no se activa o no se obedece.
metadata:
  version: 1.0.0
  audited: "propia"
---

# Escribir skills

Una skill son instrucciones que se inyectan en la sesión cuando su trigger coincide. Su calidad se mide en dos momentos: ¿se activa cuando debe? y ¿se obedece bajo presión?

## Cuándo nace una skill (y cuándo no)

- **Por extracción, no por diseño**: la tercera vez que repites una instrucción o corriges el mismo fallo, eso es una skill. Las mejores nacen de un incidente real (`proceso-de-trabajo` nació de 260 tests rotos) — el incidente da el porqué, y el porqué es lo que resiste la presión.
- **No "por si acaso"**: una skill que no responde a algo que ya pasó dos veces es inventario muerto que compite por atención con las que sí importan.
- ¿Universal o de librería? Si aplica a TODO proyecto → claude-os. Si aplica a algunos → skill-library, instalada por proyecto.

## La description es el 80%

El modelo decide activar la skill leyendo SOLO la description. Por eso:

- **Describe cuándo usarla, no qué contiene**: con los verbos y palabras que el usuario diría ("úsalo cuando pida generar una imagen…"), no un resumen del contenido.
- Incluye el caso no obvio: "aplica aunque el cambio parezca pequeño", "especialmente cuando hay prisa" — los triggers fallan justo en los bordes.
- Si tiene requisitos duros (API key, dependencia), decláralos en la description para que la skill falle rápido y claro.

## El cuerpo

- **Corto**: si pasa de ~100 líneas, o son dos skills o sobra prosa. Cada línea compite por atención; la skill perfecta es la que no se puede recortar.
- **Reglas con su porqué**: "corre el suite completo PORQUE el fallo real fue no correr los tests existentes". Una regla sin porqué se racionaliza y se salta bajo presión; el porqué crea la fricción que lo impide.
- **Anti-patrones explícitos**: lista los atajos exactos que parecerán justificados en el momento ("arreglo rápido ahora, investigo luego"). Ver el propio atajo listado como error es la defensa más efectiva.
- **Sección "Qué NO es"**: una skill sin límites se aplica a todo, se vuelve ceremonia, y una regla pesada aplicada a todo se empieza a saltar.
- **Calibración**: distingue el camino corto (cambio trivial) del completo — el protocolo máximo para todo mata al protocolo.
- Lenguaje directo: "haz X", "prohibido Y". Los "deberías considerar" se ignoran.

## Probarla antes de darla por hecha

1. **Activación**: sesión nueva, frase natural del caso de uso — ¿se activó sola? Si hubo que invocarla a mano, la description no dispara.
2. **Obediencia bajo presión**: pruébala en el caso donde duele seguirla (con prisa, con el atajo obvio delante). Si el modelo la racionaliza, faltan porqués o anti-patrones (superpowers valida así, con escenarios de presión — funciona).
3. Registro: propia → librería con `audited: "propia"` y fila en el catálogo; externa → `auditar-skill` primero, siempre.
