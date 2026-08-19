Feature: User authentication API

  Background:
    * url baseUrl
    * def user = call read('classpath:api/users/user-generation.feature')
    * header Content-Type = 'application/json'

  Scenario: Login with valid credentials

    * print 'USER OBJECT:', user
    * print 'USERNAME:', user.result.username
    * print 'PASSWORD:', user.result.password
    Given path 'api', 'users', 'token', 'login'
    And param set_cookie = true
    * def Thread = Java.type('java.lang.Thread')
    * eval Thread.sleep(2000)
    And request
    """
    {
      "username": "default",
      "password": "12345678"
    }
    """
    * print 'LOGIN REQUEST:', user
    When method POST
    Then status 200

    * print 'LOGIN RESPONSE', response

    And match response.token == '#string'
    And match response.token == '#regex .{16}'