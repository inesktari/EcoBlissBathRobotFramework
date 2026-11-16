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

Login With Valid Credentials
    [Documentation]    Authenticate a user with valid credentials
    ${body}=    Create Dictionary    username=test2@test.fr    password=testtest
    ${response}=    POST    http://localhost:8081/login    json=${body}    expected_status=200
    RETURN    ${response}

Login With Invalid Credentials
    [Documentation]    Attempt authentication with invalid credentials
    ${body}=    Create Dictionary    username=invalid@example.com    password=wrongpassword
    ${response}=    POST    http://localhost:8081/login    json=${body}    expected_status=401
    RETURN    ${response}

Login With Invalid JSON
    [Documentation]    Send malformed JSON to the login endpoint
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    http://localhost:8081/login    data={"username":    headers=${headers}    expected_status=400
    RETURN    ${response}

Get Current Order
    [Documentation]    Retrieve the current user's order using Bearer authentication
    ${login_response}=    Login With Valid Credentials
    ${token}=    Set Variable    ${login_response.json()}[token]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET    http://localhost:8081/orders    headers=${headers}    expected_status=anything
    RETURN    ${response}

Get Current User
    [Documentation]    Retrieve the authenticated user's information
    ${login_response}=    Login With Valid Credentials
    ${token}=    Set Variable    ${login_response.json()}[token]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET    http://localhost:8081/me    headers=${headers}    expected_status=200
    RETURN    ${response}

Get All Reviews
    [Documentation]    Retrieve all reviews from the API
    ${response}=    GET    http://localhost:8081/reviews    expected_status=200
    RETURN    ${response}