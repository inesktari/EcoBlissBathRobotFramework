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
    Click Element    ${PRODUCT_DETAILS_LINK}
    Wait Until Element Is Visible    ${ADD_TO_CART_BUTTON}    ${TIMEOUT}
    Element Should Be Enabled    ${ADD_TO_CART_BUTTON}
    Click Button    ${ADD_TO_CART_BUTTON}
    Wait Until Element Is Visible    ${CART_ICON}    ${TIMEOUT}
    Element Should Be Visible    ${CART_ICON}

Open Cart
    [Documentation]    Opens the shopping cart page
    Click Element    ${CART_ICON}

Open Login Page
    [Documentation]    Navigate to the login page
    Open Browser    ${URL}#/login    ${BROWSER}
    Maximize Browser Window

Go To Login Page
    [Documentation]    Navigates to the login page in the current browser session
    Go To    ${URL}#/login

Input Username
    [Documentation]    Input valid username into login form
    Wait Until Element Is Visible    id=username
    Input Text    id=username    ${USERNAME}

Input Password
    [Documentation]    Input valid password into login form
    Wait Until Element Is Visible    id=password
    Input Text    id=password    ${PASSWORD}

Submit Login
    [Documentation]    Click the login submit button
    Wait Until Element Is Visible    xpath=//button[@data-cy='login-submit']
    Click Element    xpath=//button[@data-cy='login-submit']

Verify Product Is In Cart
    [Documentation]    Verifies that a product is displayed in the shopping cart
    Wait Until Element Is Visible    ${CART_PRODUCT_NAME}    ${TIMEOUT}
    Element Should Be Visible    ${CART_PRODUCT_NAME}
