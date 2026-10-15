*** Settings ***
Documentation     Test suite for EcoBlissBath shopping cart features
Resource          ../../resources/keywords.resource

Test Setup       Start With Empty Cart
Test Teardown     Close Browser Session

*** Test Cases ***
Logged In User Can View Product In Cart
    [Documentation]    Verify that a logged-in user can view an added product in the shopping cart.
    Add First Product From Homepage
    Verify Product Is In Cart
    ${initial_total}=    Verify Cart Line Total
    Increase Product Quantity In Cart
    Verify Cart Total Updates    ${initial_total}

Logged In User Can Remove Product From Cart
    [Documentation]    Verify that a logged-in user can remove a product from the shopping cart.  
    Add First Product From Homepage
    Verify Product Is In Cart
    ${removed_product}=    Remove Product From Cart
    Verify Product Is Removed From Cart    ${removed_product}

Logged In User Can Update Product Quantity
    [Documentation]    Verify that a logged-in user can update a product quantity in the shopping cart.
    Add First Product From Homepage
    Open Cart
    ${expected_quantity}=    Increase Product Quantity In Cart
    Textfield Value Should Be    ${CART_PRODUCT_QUANTITY}    ${expected_quantity}

Logged In User Can Decrease Product Quantity
    [Documentation]    Verify that a logged-in user can decrease a product quantity in the shopping cart.
    Add First Product From Homepage
    Open Cart
    ${initial_total}=    Verify Cart Line Total
    Increase Product Quantity In Cart
    Verify Cart Total Updates    ${initial_total}
    ${increased_total}=    Verify Cart Line Total
    ${expected_quantity}=    Decrease Product Quantity In Cart
    Verify Cart Total Updates    ${increased_total}
    Textfield Value Should Be    ${CART_PRODUCT_QUANTITY}    ${expected_quantity}

Logged In User Cannot Decrease Quantity Below One
    [Documentation]    Verify that product quantity cannot be decreased below one.
    Add First Product From Homepage
    Open Cart
    Wait Until Element Is Visible    ${CART_PRODUCT_QUANTITY}    ${TIMEOUT}
    Textfield Value Should Be    ${CART_PRODUCT_QUANTITY}    1
    Press Keys    ${CART_PRODUCT_QUANTITY}    ARROW_DOWN
    Textfield Value Should Be    ${CART_PRODUCT_QUANTITY}    1

Logged In User Can Access Checkout
    [Documentation]    Verify that checkout is available when the shopping cart contains a product.
    Add First Product From Homepage
    Open Cart
    Verify Checkout Is Available

Logged In User Can Submit Valid Order
    [Documentation]    Verify that a logged-in user can submit an order with valid checkout information.
    Add First Product From Homepage
    Open Cart
    Fill Checkout Form
    Click Element    ${CHECKOUT_BUTTON}
    Wait Until Location Is    ${URL}/#/confirmation    ${TIMEOUT}