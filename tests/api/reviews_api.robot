*** Settings ***
Documentation    API tests for EcoBlissBath reviews
Resource    ../../resources/api_keywords.resource

*** Test Cases ***
Get All Reviews Returns A List
    [Documentation]    Verify that GET /reviews returns HTTP 200 and a JSON list
    ${response}=    Get All Reviews
    Should Be Equal As Integers    ${response.status_code}    200
    ${reviews}=    Set Variable    ${response.json()}
    Should Be True    isinstance($reviews, list)