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

Logged In User Sees Empty Cart After Removing Last Product
    [Documentation]    Verify the empty cart state after removing the last product.
    Add First Product From Homepage
    Open Cart
    Verify Product Is In Cart
    Remove Product From Cart
    Verify Empty Cart State

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

Cart Total Equals Sum Of Two Different Products
    [Documentation]    Verify the cart total for two distinct products.
    Open First Available Product
    ${first_product_name}=    Get Text    css:[data-cy="detail-product-name"]
    Click Button    ${ADD_TO_CART_BUTTON}

    ${second_product_name}=    Add Another Available Product To Cart    ${first_product_name}

    Open Cart
    Verify Cart Total Equals Sum Of Line Totals

Logged In User Can Submit Valid Order
    [Documentation]    Verify that a logged-in user can submit an order with valid checkout information.
    Add First Product From Homepage
    Open Cart
    Fill Checkout Form
    Submit Checkout Order
    Verify Order Confirmation Page

Logged In User Cannot Submit Order With Empty Required Fields
    [Documentation]    Verify that an order cannot be submitted when required fields are empty.
    Add First Product From Homepage
    Open Cart
    Wait Until Element Is Visible    ${CHECKOUT_LASTNAME}    ${TIMEOUT}
    
    Clear Checkout Field    ${CHECKOUT_LASTNAME}
    Clear Checkout Field    ${CHECKOUT_FIRSTNAME}
    Clear Checkout Field    ${CHECKOUT_ADDRESS}
    Clear Checkout Field    ${CHECKOUT_ZIPCODE}
    Clear Checkout Field    ${CHECKOUT_CITY}

    Submit Checkout Order
    Textfield Value Should Be    ${CHECKOUT_LASTNAME}    ${EMPTY}
    Verify Checkout Required Fields Are Invalid
    Location Should Be    ${URL}/#/cart

Logged In User Cannot Submit Order With Short Zip Code
    [Documentation]    Verify that a 4-character zip code is rejected.
    [Template]    Verify Order Is Rejected With Invalid Zip Code
    7500

Logged In User Cannot Submit Order With Long Zip Code
    [Documentation]    Verify that a 6-character zip code is rejected.
    [Template]    Verify Order Is Rejected With Invalid Zip Code
    750001

Logged In User Cannot Submit Order With Alphabetic Zip Code
    [Tags]    known_issue    issue_2
    [Documentation]    Verify that checkout rejects alphabetic zip codes.
    Add First Product From Homepage
    Open Cart
    Fill Checkout Form
    Clear Checkout Field    ${CHECKOUT_ZIPCODE}
    Input Text    ${CHECKOUT_ZIPCODE}    ABCDE
    Submit Checkout Order
    ${status}    ${_}=    Run Keyword And Ignore Error
    ...    Wait Until Location Is    ${URL}/#/confirmation    ${TIMEOUT}
    Should Be Equal    ${status}    FAIL    Checkout accepted an alphabetic zip code (ABCDE).
    Location Should Be    ${URL}/#/cart