*** Settings ***
Documentation    Reusable keywords for EcoBlissBath API tests
Library    RequestsLibrary

*** Keywords ***
Get All Products
    [Documentation]    Retrieve all products from the API
    ${response}=    GET    http://localhost:8081/products    expected_status=200
    RETURN    ${response}

Get Random Products
    [Documentation]    Retrieve random products from the API
    ${response}=    GET    http://localhost:8081/products/random    expected_status=200
    RETURN    ${response}

Get Product By ID
    [Documentation]    Retrieve a product by its ID and verify the expected HTTP status
    [Arguments]    ${product_id}    ${expected_status}=200
    ${response}=    GET    http://localhost:8081/products/${product_id}    expected_status=${expected_status}
    RETURN    ${response}