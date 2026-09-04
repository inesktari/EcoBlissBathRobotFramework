*** Settings ***
Documentation     Test suite for EcoBlissBath shopping cart features

Resource          ../../resources/keywords.resource


*** Test Cases ***
Logged In User Can View Product In Cart
    [Documentation]    Verify that a logged-in user can view an added product in the shopping cart.
    Open EcoBlissBath Website
    Go To Login Page
    Input Username
    Input Password
    Submit Login
    Open Cart
    Clear Shopping Cart
    Go To    ${URL}
    Add First Product To Cart
    Verify Product Is In Cart
    ${initial_total}=    Verify Cart Line Total
    Increase Product Quantity In Cart
    Verify Cart Total Updates    ${initial_total}
    Close Browser Session

Logged In User Can Remove Product From Cart
    [Documentation]    Verify that a logged-in user can remove a product from the shopping cart.
    Open EcoBlissBath Website
    Go To Login Page
    Input Username
    Input Password
    Submit Login
    Open Cart
    Clear Shopping Cart
    Go To    ${URL}
    Add First Product To Cart
    Verify Product Is In Cart
    ${removed_product}=    Remove Product From Cart
    Verify Product Is Removed From Cart    ${removed_product}
    Close Browser Session

Logged In User Can Update Product Quantity
    [Documentation]    Verify that a logged-in user can update a product quantity in the shopping cart.
    Open EcoBlissBath Website
    Go To Login Page
    Input Username
    Input Password
    Submit Login
    Open Cart
    Clear Shopping Cart
    Go To    ${URL}
    Add First Product To Cart
    Open Cart
    ${expected_quantity}=    Increase Product Quantity In Cart
    Textfield Value Should Be    ${CART_PRODUCT_QUANTITY}    ${expected_quantity}
    Close Browser Session
