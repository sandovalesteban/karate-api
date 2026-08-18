Feature: QuickPizza API - Recomendación de pizzas
  # API pública de Grafana (la misma que usaste para pruebas de performance con k6)
  # Doc: https://github.com/grafana/quickpizza

  Background:
    * url baseUrl
    * header Authorization = 'Token ' + authToken
    * header Content-Type = 'application/json'

  @smoke
  Scenario: La home de QuickPizza responde 200
    Given path '/'
    When method GET
    Then status 200

  @smoke
  Scenario: Generar una recomendación de pizza válida
    Given path 'api/pizza'
    And header X-User-ID = 1
    And request { maxCaloriesPerSlice: 1000, mustBeVegetarian: false, excludedIngredients: [], excludedTools: [], maxNumberOfToppings: 5, minNumberOfToppings: 2 }
    When method POST
    Then status 200
    And match response.pizza == '#present'
    And match response.pizza.name == '#string'
    And match response.pizza.ingredients == '#array'

  Scenario: Recomendación vegetariana respeta la restricción
    Given path 'api/pizza'
    And header X-User-ID = 2
    And request { maxCaloriesPerSlice: 1200, mustBeVegetarian: true, excludedIngredients: [], excludedTools: [], maxNumberOfToppings: 6, minNumberOfToppings: 1 }
    When method POST
    Then status 200
    And match response.vegetarian == true

  Scenario Outline: Distintos límites de calorías siempre devuelven una pizza coherente
    Given path 'api/pizza'
    And header X-User-ID = 3
    And request { maxCaloriesPerSlice: <calorias>, mustBeVegetarian: false, excludedIngredients: [], excludedTools: [], maxNumberOfToppings: 5, minNumberOfToppings: 1 }
    When method POST
    Then status 200
    And match response.pizza.name == '#string'

    Examples:
      | calorias |
      | 300      |
      | 600      |
      | 1500     |

  Scenario: Respetar ingredientes excluidos
    Given path 'api/pizza'
    And header X-User-ID = 4
    And request { maxCaloriesPerSlice: 1000, mustBeVegetarian: false, excludedIngredients: ['Pepperoni'], excludedTools: [], maxNumberOfToppings: 5, minNumberOfToppings: 1 }
    When method POST
    Then status 200
    And print response
    And match each response.pizza.ingredients[*].name != 'Pepperoni'

  # Nota: ajusta el código esperado según lo que confirmes corriendo el test una vez
  # (algunas APIs devuelven 400, otras 422 o 500 ante un tipo de dato inválido)
  Scenario: Payload inválido debe fallar
    Given path 'api/pizza'
    And header X-User-ID = 5
    And request { maxCaloriesPerSlice: 'no-es-un-numero' }
    When method POST
    Then assert responseStatus >= 400
