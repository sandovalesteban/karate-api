Feature: User authentication negative tests

  Background:
    * url baseUrl

  @negative
  Scenario: Login with invalid credentials

    Given path 'api', 'users', 'token', 'login'
    And request
    """
    {
      "username": "invalid_user",
      "password": "wrong_password"
    }
    """

    When method POST
    Then status 401
    * print 'LOGIN NEGATIVE RESPONSE', response