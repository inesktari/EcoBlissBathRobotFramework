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

User Cannot Login With Invalid Password
    [Documentation]    Verify that an error message is displayed when the password is incorrect.
    Open Login Page
    Input Username
    Input Text    id=password    wrongpassword
    Submit Login
    Verify Invalid Login Error Message
    Verify Login Field Labels Have Error Class
    Verify User Is Not Logged In