*** Settings ***
Documentation       Reusable keywords for EcoBlissBath automated UI tests.

Library             SeleniumLibrary
Resource            ../resources/variables.resource
Resource            ../resources/locators.resource


*** Keywords ***
Open EcoBlissBath Website
    [Documentation]    Opens EcoBlissBath website in the configured browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Close Browser Session
    [Documentation]    Closes the active browser session
    Close Browser

Verify Home Page Title
    [Documentation]    Verifies that the homepage title matches the expected value
    Title Should Be    ${HOME_TITLE}

Add First Product To Cart
    [Documentation]    Adds the first visible product on the homepage to the cart
    Wait Until Element Is Visible    ${PRODUCT_CARD}    ${TIMEOUT}
    Click Element    ${ADD_TO_CART_BUTTON}

Open Cart
    [Documentation]    Opens the shopping cart page
    Click Element    ${CART_ICON}
