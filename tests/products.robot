*** Settings ***
Documentation       Test suite for EcoBlissBath product features

Resource            ../resources/keywords.resource


*** Test Cases ***
User Can Add Product To Cart
    [Documentation]    Verify that a logged-in user can add a product to the shopping cart
    Open EcoBlissBath Website
    Go To Login Page
    Input Username
    Input Password
    Submit Login
    Add First Product To Cart
    Close Browser Session
