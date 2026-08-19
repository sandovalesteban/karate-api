Feature: Pizza ratings API

  Background:
    * url baseUrl
    * def login = call read('classpath:api/users/user-login.feature')
    * def token = login.response.token

  Scenario: Create and delete not permitted a pizza rating

    # Create rating

    Given path 'api', 'ratings'
    And header Authorization = 'Token ' + token
    And request
    """
    {
      "stars": 5,
      "pizza_id": 1
    }
    """

    When method POST
    Then status 201

    And match response.id == '#number'
    And match response.stars == 5
    And match response.pizza_id == 1
    * print 'RATING RESPONSE', response
    * def ratingId = response.id

    # Delete rating

    Given path 'api', 'ratings', ratingId
    And header Authorization = 'Token ' + token
    When method DELETE
    Then status 403
    * print 'RATING DELETE RESPONSE', response