Feature: Pizza API negative tests

  Background:
    * url baseUrl
    * header Authorization = 'Token ' + authToken
    * header Content-Type = 'application/json'

  @negative
  Scenario: Request unsupported HTTP method

    Given path 'api', 'pizza'
    When method DELETE
    Then status 404

  @negative
  Scenario: Request invalid endpoint

    Given path 'api', 'pizza', 'invalid'
    When method GET
    Then status 404

  @negative
  Scenario: Invalid ingredient type
    Given path 'api', 'ingredients', 'invalid-type'
    When method GET
    Then status 400

  @negative
  Scenario: Invalid JSON
    Given path 'api', 'pizza'
    And request '{ "maxCaloriesPerSlice": 1000, '
    When method POST
    Then status 400

  @negative
  Scenario: Invalid data types
    Given path 'api', 'pizza'
    And request
    """
    {
      "maxCaloriesPerSlice": "1000",
      "mustBeVegetarian": "false",
      "excludedIngredients": [],
      "excludedTools": [],
      "maxNumberOfToppings": 5,
      "minNumberOfToppings": 2
    }
    """
    When method POST
    Then status 400