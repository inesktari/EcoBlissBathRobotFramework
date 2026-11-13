
*** Settings ***
Documentation    API tests for EcoBlissBath products
Library    RequestsLibrary
Resource    ../../resources/api_keywords.resource

*** Variables ***
${API_URL}    http://localhost:8081

*** Test Cases ***
Get Products Returns Status 200
    [Documentation]    Verify that the products endpoint returns a product list
    ${response}=    Get All Products
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be True    isinstance($response.json(), list)

Get Random Products Returns Product List
    [Documentation]    Verify that the random products endpoint returns a product list
    ${response}=    Get Random Products
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be True    isinstance($response.json(), list)

Get Nonexistent Product Returns Status 404
    [Documentation]    Verify that an unknown product returns HTTP 404
    ${response}=    Get Product By ID    999999999    404
    Should Be Equal As Integers    ${response.status_code}    404

Get Existing Product Returns Status 200
    [Documentation]    Verify that an existing product can be retrieved by ID
    ${list_response}=    Get All Products
    ${products}=    Set Variable    ${list_response.json()}
    Should Not Be Empty    ${products}
    ${product_id}=    Set Variable    ${products}[0][id]
    ${response}=    Get Product By ID    ${product_id}
    Should Be Equal As Integers    ${response.json()}[id]    ${product_id}