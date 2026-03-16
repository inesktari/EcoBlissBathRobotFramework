*** Settings ***
Documentation       Tests for EcoBlissBath homepage

Resource            ../resources/keywords.resource


*** Test Cases ***
Test Logo Presence
    [Documentation]    Verify logo EcoBlissBath visibility
    Open EcoBlissBath Website
    Element Should Be Visible    xpath=//a[@data-cy='nav-link-home-logo']/img
    Close Browser Session
