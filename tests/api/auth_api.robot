*** Settings ***
Documentation    API tests for EcoBlissBath authentication
Library    Collections
Resource    ../../resources/api_keywords.resource

*** Test Cases ***
Login With Valid Credentials Returns Tokens
    [Documentation]    Verify that valid credentials return access and refresh tokens
    [Tags]    known_issue    issue_1
    ${response}=    Login With Valid Credentials
    Dictionary Should Contain Key    ${response.json()}    token
    Dictionary Should Contain Key    ${response.json()}    refresh_token

Login With Invalid Credentials Returns 401
    [Documentation]    Verify that invalid credentials are rejected
    ${response}=    Login With Invalid Credentials
    Should Be Equal As Integers    ${response.status_code}    401

Login With Invalid JSON Returns 400
    [Documentation]    Verify that malformed JSON is rejected
    ${response}=    Login With Invalid JSON
    Should Be Equal As Integers    ${response.status_code}    400