*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}     http://localhost:8080/
${BROWSER}    Chrome

*** Test Cases ***
Test Logo Presence
    Open Browser    ${URL}    ${BROWSER}
    Element Should Be Visible    xpath=//a[@data-cy='nav-link-home-logo']/img
    Close Browser