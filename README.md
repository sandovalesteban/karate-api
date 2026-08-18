# karate-quickpizza

Proyecto Karate listo para abrir en IntelliJ / VS Code, apuntando a la API pública de
[QuickPizza](https://github.com/grafana/quickpizza) (Grafana) — la misma app que ya usaste
para pruebas de performance con k6.

Base URL por defecto: `https://quickpizza.grafana.com` (no requiere levantar nada localmente).

## Requisitos
- JDK 17+
- Maven 3.8+

## Cómo abrir en tu IDE
1. Descomprime el zip.
2. En IntelliJ: `File > Open` → selecciona la carpeta → deja que importe como proyecto Maven.
3. Espera a que baje las dependencias (`karate-junit5`).

## Ejecutar todos los tests
```bash
mvn test
```

## Ejecutar solo los smoke tests (tag @smoke)
```bash
mvn test -Dtest=PizzaRunner#testSmoke
```

## Cambiar de entorno
Por defecto usa `prod` (la demo pública de Grafana). Si alguna vez levantas QuickPizza
localmente con Docker (`docker run -p 3333:3333 grafana/quickpizza`), corre:
```bash
mvn test -Dkarate.env=local
```

## Estructura
```
src/test/java/
  karate-config.js              -> config por entorno (baseUrl)
  api/quickpizza/
    pizza.feature                -> escenarios (smoke, negativos, data-driven)
    PizzaRunner.java              -> runner JUnit5
src/test/resources/
  logback-test.xml               -> logging limpio en consola
```

## Reportes
Después de `mvn test`, revisa:
- `target/karate-reports/karate-summary.html` — resumen HTML
- `target/surefire-reports/` — reportes JUnit estándar

## Próximos pasos sugeridos
- Agregar feature de `ratings` (POST/DELETE) y `users` (registro/login) siguiendo el
  mismo patrón que `pizza.feature`.
- Integrar a GitHub Actions como job separado, en paralelo a tu suite Playwright.
- Ajustar el escenario "Payload inválido" con el código de status real una vez lo corras
  (dejé un `assert responseStatus >= 400` genérico como placeholder).
