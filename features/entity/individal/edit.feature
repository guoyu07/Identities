@app @entity @individual @edit
Feature: Edit individuals
  In order to edit individuals
  As a system identity
  I should be able to send api requests related to individuals

  Background:
    Given I am authenticated as the "system" identity

  @createSchema @loadFixtures
  Scenario: Edit a individual
    When I add "Accept" header equal to "application/json"
    And I add "Content-Type" header equal to "application/json"
    And I send a "PUT" request to "/individuals/9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42" with body:
    """
    {
      "ownerUuid": "325e1004-8516-4ca9-a4d3-d7505bd9a7fe"
    }
    """
    Then the response status code should be 200
    And the header "Content-Type" should be equal to "application/json; charset=utf-8"
    And the response should be in JSON
    And the JSON node "ownerUuid" should be equal to the string "325e1004-8516-4ca9-a4d3-d7505bd9a7fe"

  Scenario: Confirm the edited individual
    When I add "Accept" header equal to "application/json"
    And I send a "GET" request to "/individuals/9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42"
    Then the response status code should be 200
    And the header "Content-Type" should be equal to "application/json; charset=utf-8"
    And the response should be in JSON
    And the JSON node "ownerUuid" should be equal to the string "325e1004-8516-4ca9-a4d3-d7505bd9a7fe"

  Scenario: Edit a individual's read-only properties
    When I add "Accept" header equal to "application/json"
    And I add "Content-Type" header equal to "application/json"
    And I send a "PUT" request to "/individuals/9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42" with body:
    """
    {
      "id": 9999,
      "uuid": "0f431ab6-bf5e-41f9-888a-5b7c3526746f",
      "createdAt":"2000-01-01T12:00:00+00:00",
      "updatedAt":"2000-01-01T12:00:00+00:00",
      "deletedAt":"2000-01-01T12:00:00+00:00"
    }
    """
    Then the response status code should be 200
    And the header "Content-Type" should be equal to "application/json; charset=utf-8"
    And the response should be in JSON
    And the JSON node "id" should be equal to the number 1
    And the JSON node "uuid" should be equal to the string "9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42"
    And the JSON node "createdAt" should not contain "2000-01-01T12:00:00+00:00"
    And the JSON node "updatedAt" should not contain "2000-01-01T12:00:00+00:00"
    And the JSON node "deletedAt" should not contain "2000-01-01T12:00:00+00:00"

  Scenario: Confirm the unedited individual
    When I add "Accept" header equal to "application/json"
    And I send a "GET" request to "/individuals/9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42"
    Then the response status code should be 200
    And the header "Content-Type" should be equal to "application/json; charset=utf-8"
    And the response should be in JSON
    And the JSON node "id" should be equal to the number 1
    And the JSON node "uuid" should be equal to the string "9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42"
    And the JSON node "createdAt" should not contain "2000-01-01T12:00:00+00:00"
    And the JSON node "updatedAt" should not contain "2000-01-01T12:00:00+00:00"
    And the JSON node "deletedAt" should not contain "2000-01-01T12:00:00+00:00"

  @dropSchema
  Scenario: Edit a individual with an invalid optimistic lock
    When I add "Accept" header equal to "application/json"
    And I add "Content-Type" header equal to "application/json"
    And I send a "PUT" request to "/individuals/9ce3bdb9-47e1-43c9-81ee-0dcc2106ba42" with body:
    """
    {
      "ownerUuid": "fca01292-2e1e-49ff-8c84-fc0b030ac51b",
      "version": 1
    }
    """
    Then the response status code should be 500
    And the header "Content-Type" should be equal to "application/problem+json; charset=utf-8"
    And the response should be in JSON
