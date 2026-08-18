Feature: Pizza generation API

  Background:
    * url baseUrl
    * header Authorization = 'Token ' + authToken
    * header Content-Type = 'application/json'

  @smoke
  Scenario: Generate a pizza successfully

    Given path 'api', 'pizza'
    And request
    """
    {}
    """
    When method POST
    Then status 200
    And print response
    And match response.pizza.id == '#number'
    And match response.pizza.name == '#string'
    And match response.pizza.dough == '#object'
    And match response.pizza.ingredients == '#array'

  Scenario: Validate generated pizza structure

    Given path 'api', 'pizza'
    And request
    """
    {}
    """
    When method POST
    Then status 200

    And match response.pizza contains
    """
    {
      id: '#number',
      name: '#string',
      dough: '#object',
      ingredients: '#array'
    }
    """

    And match response.pizza.dough contains
    """
    {
      ID: '#number',
      name: '#string',
      caloriesPerSlice: '#number'
    }
    """