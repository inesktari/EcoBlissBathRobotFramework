*** Settings ***
Documentation       Test suite for authentication features

Resource            ../resources/keywords.resource


*** Test Cases ***
User Can Login With Valid Credentials
    [Documentation]    Verify that a user can login with valid credentials
    Open Login Page
    Input Username
    Input Password
    Submit Login
    Wait Until Element Is Visible    xpath=//a[@data-cy='nav-link-logout']
    Element Should Be Visible    xpath=//a[@data-cy='nav-link-logout']
