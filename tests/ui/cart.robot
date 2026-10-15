*** Settings ***
Documentation     Test suite for EcoBlissBath shopping cart features
Resource          ../../resources/keywords.resource

Test Setup       Start With Empty Cart
Test Teardown     Close Browser Session

*** Test Cases ***
Logged In User Can Update Cart Total When Quantity Increases
    [Documentation]    Verify that the cart total updates when the product quantity increases.
    Add First Product From Homepage
    Verify Product Is In Cart
    ${initial_total}=    Verify Cart Line Total
    ${unit_price}=    Convert Euro Price To Number    ${initial_total}
    ${expected_quantity}=    Increase Product Quantity In Cart
    ${expected_total}=    Evaluate    $unit_price * $expected_quantity
    Wait Until Cart Line Total Is    ${expected_total}

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
    Verify Product Quantity In Cart Is    ${expected_quantity}

Logged In User Can Update Cart Total When Quantity Decreases
    [Documentation]    Verify that the cart total updates when the product quantity decreases.
    Add First Product From Homepage
    Open Cart
    ${initial_total}=    Verify Cart Line Total
    ${unit_price}=    Convert Euro Price To Number    ${initial_total}
    
    ${increased_quantity}=    Increase Product Quantity In Cart
    ${increased_total}=    Evaluate    $unit_price * $increased_quantity
    Wait Until Cart Line Total Is    ${increased_total}
    ${expected_quantity}=    Decrease Product Quantity In Cart
    ${expected_total}=    Evaluate    $unit_price * $expected_quantity
    Wait Until Cart Line Total Is    ${expected_total}
    Verify Product Quantity In Cart Is    ${expected_quantity}

Logged In User Cannot Decrease Quantity Below One
    [Documentation]    Verify that product quantity cannot be decreased below one.
    Add First Product From Homepage
    Open Cart
    Verify Product Quantity In Cart Is    1    
    Attempt To Decrease Product Quantity Below One
    Verify Product Quantity In Cart Is    1

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
    Submit Checkout Order
    Verify Order Confirmation Page