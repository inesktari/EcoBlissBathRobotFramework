*** Settings ***
Documentation       Tests for EcoBlissBath homepage

Resource            ../../resources/keywords.resource

Test Teardown     Close Browser Session

*** Test Cases ***
Test Logo Presence
    [Documentation]    Verify logo EcoBlissBath visibility
    [Tags]    smoke
    Open EcoBlissBath Website
    Verify Home Page Logo Is Visible

Homepage Displays Essential Elements
    [Documentation]    Verify that essential homepage elements are visible.
    Open EcoBlissBath Website
    Element Should Be Visible    ${HOME_LOGO}
    Element Should Be Visible    css:[data-cy="nav-link-products"]
    Element Should Be Visible    css:[data-cy="nav-link-reviews"]
    Element Should Be Visible    css:app-home h1
    Element Should Be Visible    css:app-home header button
    Wait Until Element Is Visible    ${PRODUCT_CARD}    ${TIMEOUT}
    Element Should Be Visible    css:[data-cy="product-home-name"]
    Element Should Be Visible    css:[data-cy="product-home-price"]
    Element Should Be Visible    ${PRODUCT_DETAILS_LINK}
    Element Should Be Visible    css:#main-footer
    Element Should Not Be Visible    ${CART_ICON}
    Element Should Not Be Visible    ${LOGOUT_LINK}
