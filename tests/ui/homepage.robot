*** Settings ***
Documentation       Tests for EcoBlissBath homepage

Resource            ../../resources/keywords.resource

Test Teardown     Close Browser Session

*** Test Cases ***
Test Logo Presence
    [Documentation]    Verify logo EcoBlissBath visibility
    Open EcoBlissBath Website
    Verify Home Page Logo Is Visible
