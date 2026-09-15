*** Settings ***
Documentation       Test suite for authentication features

Resource            ../../resources/keywords.resource

Test Teardown     Close Browser Session

*** Test Cases ***
User Can Login With Valid Credentials
    [Documentation]    Verify that a user can login with valid credentials
    Open Login Page
    Input Username
    Input Password
    Submit Login
    Verify User Is Logged In