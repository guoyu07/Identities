@app @entity @anonymous @read
Feature: Read anonymouses
  In order to read anonymouses
  As a system identity
  I should be able to send api requests related to anonymouses

  Background:
    Given I am authenticated as the "system" identity

  @createSchema @loadFixtures @dropSchema
  Scenario: Read a anonymous
    When I add "Accept" header equal to "application/json"
    And I send a "GET" request to "/anonymouses/73aab537-f174-4bf9-b986-afedbb23b7bc"
    Then the response status code should be 200
    And the header "Content-Type" should be equal to "application/json; charset=utf-8"
    And the response should be in JSON
    And the JSON node "id" should exist
    And the JSON node "id" should be equal to the number 1
    And the JSON node "uuid" should exist
    And the JSON node "uuid" should be equal to the string "73aab537-f174-4bf9-b986-afedbb23b7bc"
    And the JSON node "createdAt" should exist
    And the JSON node "updatedAt" should exist
    And the JSON node "deletedAt" should exist
    And the JSON node "deletedAt" should be null
    And the JSON node "owner" should exist
    And the JSON node "owner" should be equal to the string "BusinessUnit"
    And the JSON node "ownerUuid" should exist
    And the JSON node "ownerUuid" should be equal to the string "325e1004-8516-4ca9-a4d3-d7505bd9a7fe"
    And the JSON node "version" should exist
    And the JSON node "version" should be equal to the number 1
