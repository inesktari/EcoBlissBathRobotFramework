*** Settings ***
Documentation    Reusable keywords for EcoBlissBath API tests
Library    RequestsLibrary
Library    Collections

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

Validate Product Structure
    [Documentation]    Verify that a product contains the expected fields.
    [Arguments]    ${product}
    Should Be True    isinstance($product, dict)
    Dictionary Should Contain Key    ${product}    id
    Dictionary Should Contain Key    ${product}    name
    Dictionary Should Contain Key    ${product}    description
    Dictionary Should Contain Key    ${product}    price
    Dictionary Should Contain Key    ${product}    picture

Register With Invalid JSON
    [Documentation]    Send malformed JSON to the registration endpoint.
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST    http://localhost:8081/register    data={"email":    headers=${headers}    expected_status=400
    RETURN    ${response}

Register With Valid Data
    [Documentation]    Register a new user with a unique email address.
    ${unique_id}=    Evaluate    __import__('uuid').uuid4().hex
    ${email}=    Set Variable    robot_${unique_id}@example.com
    ${passwords}=    Create Dictionary    first=RobotTest123!    second=RobotTest123!
    ${user}=    Create Dictionary
    ...    email=${email}
    ...    firstname=Robot
    ...    lastname=Framework
    ...    plainPassword=${passwords}
    ${response}=    POST    http://localhost:8081/register    json=${user}    expected_status=200
    RETURN    ${response}    ${email}

Create Review With Invalid JSON
    [Documentation]    Verify that malformed review JSON is rejected for an authenticated user.
    ${login_response}=    Login With Valid Credentials
    ${token}=    Set Variable    ${login_response.json()}[token]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    POST    http://localhost:8081/reviews    data={"title":    headers=${headers}    expected_status=400
    RETURN    ${response}

Create Review With Valid Data
    [Documentation]    Create a review using an authenticated user.
    ${login_response}=    Login With Valid Credentials
    ${token}=    Set Variable    ${login_response.json()}[token]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${review}=    Create Dictionary
    ...    title=Robot Framework Review
    ...    comment=Automated API test review.
    ...    rating=5
    ${response}=    POST    http://localhost:8081/reviews    json=${review}    headers=${headers}    expected_status=200
    RETURN    ${response}

Validate Current Order
    [Documentation]    Validate the current order for an authenticated user.
    ${login_response}=    Login With Valid Credentials
    ${token}=    Set Variable    ${login_response.json()}[token]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${order_data}=    Create Dictionary
    ...    firstname=Robot
    ...    lastname=Framework
    ...    address=10 Test Street
    ...    zipCode=75001
    ...    city=Paris
    ${response}=    POST    http://localhost:8081/orders    json=${order_data}    headers=${headers}    expected_status=200
    RETURN    ${response}

Add Product To Current Order
    [Documentation]    Add one product to the authenticated user's current order.
    ${login_response}=    Login With Valid Credentials
    ${token}=    Set Variable    ${login_response.json()}[token]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${products_response}=    Get All Products
    ${products}=    Set Variable    ${products_response.json()}
    ${product_id}=    Set Variable    ${products}[0][id]
    ${order_line}=    Create Dictionary    product=${product_id}    quantity=1
    ${response}=    PUT    http://localhost:8081/orders/add    json=${order_line}    headers=${headers}    expected_status=200
    RETURN    ${response}