---
name: depurar
description: Protocolo de debugging sistemático por causa raíz. Úsalo ante CUALQUIER bug, test que falla, comportamiento inesperado o error que no entiendes — ANTES de proponer arreglos. Especialmente obligatorio cuando hay prisa, cuando "un arreglo rápido" parece obvio, o cuando ya intentaste un fix y no funcionó: ahí es donde adivinar sale más caro.
metadata:
  version: 1.0.0
  audited: "propia — adaptada de superpowers/systematic-debugging (MIT, obra/superpowers@d884ae04), auditada 2026-07-03: APTA"
---

# Depurar

**La ley de hierro: ningún fix sin investigación de causa raíz primero.** Arreglar el síntoma es fallar: el bug vuelve con otra cara. Y no, "este bug es simple" no exime — los bugs simples también tienen causa raíz, y el proceso es rápido en los simples.

## Fase 1 — Investigar (antes de tocar nada)

1. **Lee el error completo.** Stack trace entero, número de línea, código de error. La mitad de las veces la solución está escrita ahí y se saltó por leer en diagonal.
2. **Reproduce de forma consistente.** ¿Puedes dispararlo siempre? ¿Con qué pasos exactos? Si no es reproducible, junta más datos — no adivines.
3. **Mira qué cambió.** `git diff`, commits recientes, dependencias nuevas, config, entorno.
4. **En sistemas de varias capas** (API → servicio → DB, CI → build → deploy): instrumenta cada frontera — loggea qué entra y qué sale de cada componente, corre UNA vez, y la evidencia te dice EN QUÉ capa se rompe. Después investigas esa capa, no todas.
5. **Rastrea hacia atrás.** El error aparece hondo en el stack, pero el valor malo nació arriba. ¿Qué llamó a esto con ese valor? ¿Y a eso? Sube hasta el origen. **Se arregla en el origen, no donde explotó.**

## Fase 2 — Comparar

- Busca código similar que SÍ funciona en el mismo repo. Lista TODAS las diferencias con el roto, sin descartar ninguna por "eso no puede importar".
- Si implementas un patrón de referencia, léelo COMPLETO antes de adaptarlo. Adaptar lo que se entendió a medias garantiza bugs.

## Fase 3 — Hipótesis (método científico)

1. **Una sola hipótesis, escrita:** "creo que X es la causa raíz porque Y".
2. **El cambio MÍNIMO que la comprueba.** Una variable a la vez, jamás varios arreglos juntos (no puedes aislar cuál funcionó y creas bugs nuevos).
3. ¿No funcionó? Hipótesis nueva — **no apiles otro fix encima**.
4. ¿No entiendes algo? Dilo tal cual: "no entiendo X". Fingir que se entiende es la forma más cara de perder tiempo.

## Fase 4 — Arreglar

1. **Test que reproduce el bug ANTES del fix** — y lo ves fallar. Después del fix: verde. Verificación rojo-verde: si reviertes el fix, el test DEBE volver a fallar; un test de regresión que no falló nunca no prueba nada.
2. Un solo cambio: sin "ya que estoy aquí" ni refactors empaquetados.
3. Suite completo verde (regla 2 de `proceso-de-trabajo`).
4. **Defensa en profundidad:** encontrada la causa, valida en cada capa por la que pasó el dato malo (entrada, lógica, guard de entorno). Un solo check se bypasea; varios hacen el bug estructuralmente imposible. Y busca el mismo patrón en el resto del código: los bugs vienen en familias.

## La regla de los 3 fixes

**Si 3 arreglos fallaron, no intentes el cuarto.** Cada fix que revela un problema nuevo en otro sitio no es mala suerte: es señal de arquitectura equivocada. Para, cuestiona el patrón de fondo con el usuario, y decide si se refactoriza en vez de seguir parcheando síntomas.

## Caso especial: tests flaky

Un test con `sleep(N)` es una adivinanza de timing que falla bajo carga. **Espera la condición, no el tiempo**: poll cada ~10ms de la condición real (`waitFor(() => estado === 'listo')`) con timeout y mensaje claro. Un timeout arbitrario solo se justifica midiendo comportamiento temporal real (debounce, ticks) — y documentado con el porqué.

## Señales de que lo estás haciendo mal (para y vuelve a Fase 1)

"Arreglo rápido ahora e investigo luego" · "pruebo a cambiar X a ver si funciona" · "meto varios cambios y corro los tests" · "probablemente es X, lo arreglo" · "no lo entiendo del todo pero esto podría funcionar" · proponer soluciones antes de rastrear el flujo del dato. La depuración sistemática tarda 15-30 min; el prueba-y-error, horas — la prisa es el argumento A FAVOR del proceso, no en contra.
