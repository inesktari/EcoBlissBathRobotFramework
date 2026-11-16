*** Settings ***
Documentation    API tests for EcoBlissBath users
Library    Collections
Resource    ../../resources/api_keywords.resource

*** Test Cases ***
Get Current User Returns User Information
    [Documentation]    Verify that the authenticated user's information matches the Swagger schema
    ${response}=    Get Current User
    Should Be Equal As Integers    ${response.status_code}    200
    ${user}=    Set Variable    ${response.json()}
    Should Be True    isinstance($user, dict)
    Dictionary Should Contain Key    ${user}    id
    Dictionary Should Contain Key    ${user}    email
    Dictionary Should Contain Key    ${user}    roles
    Should Be Equal    ${user}[email]    test2@test.fr