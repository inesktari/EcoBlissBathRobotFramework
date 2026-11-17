*** Settings ***
Documentation    API tests for EcoBlissBath user registration
Library    RequestsLibrary
Resource    ../../resources/api_keywords.resource

*** Test Cases ***
Register With Invalid JSON Returns Status 400
    [Documentation]    Verify that malformed JSON is rejected during registration.
    ${response}=    Register With Invalid JSON
    Should Be Equal As Integers    ${response.status_code}    400

Register With Valid Data Returns Status 200
    [Documentation]    Verify that a new user can register successfully.
    ${response}    ${email}=    Register With Valid Data
    Should Be Equal As Integers    ${response.status_code}    200
    ${user}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${user}[email]    ${email}
    Should Be Equal As Strings    ${user}[firstname]    Robot
    Should Be Equal As Strings    ${user}[lastname]    Framework
    Dictionary Should Contain Key    ${user}    id
    Dictionary Should Contain Key    ${user}    roles
