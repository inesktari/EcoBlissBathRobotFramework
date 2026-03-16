*** Settings ***
Documentation       Test suite for EcoBlissBath product features

Resource            ../resources/keywords.resource


*** Test Cases ***
User Can Add Product To Cart
    [Documentation]    Verify that a user can add a product to the shopping cart
    Open EcoBlissBath Website
    Add First Product To Cart
    Open Cart
    Close Browser Session
