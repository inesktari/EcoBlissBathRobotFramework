*** Settings ***
Documentation       Test suite for EcoBlissBath product features

Resource            ../../resources/keywords.resource

Test Teardown     Close Browser Session

*** Test Cases ***
User Can Add Product To Cart
    [Documentation]    Verify that a logged-in user can add a product to the shopping cart
    Open EcoBlissBath Website
    Login As Valid User
    Add First Product To Cart
    Verify Product Is In Cart
