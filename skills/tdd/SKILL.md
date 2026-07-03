---
name: tdd
description: Protocolo de desarrollo guiado por tests (rojo→verde→refactor). Úsalo en proyectos cuyo contrato de calidad declare el ámbito de tests, al implementar features nuevas con comportamiento definible, y SIEMPRE al arreglar un bug (el test que lo reproduce va antes del fix). El test se escribe primero y se ve fallar: un test que nunca falló no prueba nada.
metadata:
  version: 1.0.0
  audited: "propia"
---

# TDD

El orden importa: el test primero obliga a definir el comportamiento antes de implementarlo, y garantiza que el test es capaz de fallar. Escribirlo después produce tests que certifican lo que el código ya hace — incluido lo que hace mal.

## El ciclo

1. **ROJO** — Escribe el test del comportamiento (no de la implementación). Córrelo y **míralo fallar con el error que esperabas**. Si falla por otra razón (import roto, fixture mal montado), arregla eso primero: todavía no tienes un test.
2. **VERDE** — El código mínimo que lo pasa. Sin generalizar "por si acaso": si el caso general hace falta, habrá un test que lo pida.
3. **REFACTOR** — Con el suite verde, limpia: nombres, duplicación, estructura. El verde es tu red; refactorizar en rojo es caminar sin ella.

Un comportamiento por ciclo. Ciclos cortos (minutos, no horas).

## Reglas

- **Testea comportamiento, no implementación**: el test dice "con esta entrada, esta salida/efecto", no "llama a este método interno". Un test acoplado a la implementación se rompe con cada refactor y no detecta bugs reales.
- **Bugs**: primero el test que reproduce el bug (rojo), luego el fix (verde). Es la Fase 4 de `depurar` — sin excepción, aunque el fix sea de una línea.
- **Dobles (mocks/stubs) solo en los bordes**: red, reloj, disco, APIs externas. Mockear tu propia lógica de negocio es testear el mock.
- **Nombres que describen el comportamiento**: `test_carrito_vacio_no_permite_checkout`, no `test_checkout_2`.
- **El caso borde va en su propio test**, no como assert número 14 de un test gigante: cuando falle, el nombre te dice qué se rompió.

## Cuándo NO aplica el ciclo estricto

- **Exploración / spikes**: cuando no sabes aún qué construir, explora sin tests — pero el spike **se tira** y la versión real se hace con TDD. El spike que "se queda porque ya funciona" es deuda desde el día uno.
- **Código sin lógica** (config declarativa, glue trivial): un test de humo basta. Testear que un getter devuelve el atributo es ceremonia.
- Si el contrato de calidad del proyecto declara tests a nivel básico, este protocolo aplica solo a la lógica central que el contrato cubra.

## Al terminar

Suite completo verde + las reglas 2 y 3 de `proceso-de-trabajo` (verificación medida ahora). En proyectos con mutation testing en el contrato: el mutante que sobrevive te está diciendo qué test falta.
