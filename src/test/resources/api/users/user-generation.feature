Feature: User registration API

  Background:
    * url baseUrl
    * def username = 'karate_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * def password = 'Password123!'

  @regression
  Scenario: Register a new user

    Given path 'api', 'users'
    And request
    """
    {
      "username": "#(username)",
      "password": "#(password)"
    }
    """

    When method POST
    And print response
    Then status 201

    And match response contains
    """
    {
      username: '#string'
    }
    """

    And match response.username == username

    And print 'USERNAME GENERADO:', username
    And print 'RESPONSE:', response
    And print 'RESPONSE USERNAME:', response.username

    * def result =
    """
    {
      username: '#(username)',
      password: '#(password)'
    }
    """