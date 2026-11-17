*** Settings ***
Documentation    API tests for EcoBlissBath orders
Library    Collections
Resource    ../../resources/api_keywords.resource

*** Test Cases ***
Get Current Order Returns Expected Status
    [Documentation]    Verify that the current order matches the documented API response
    ${response}=    Get Current Order
    Should Be True    ${response.status_code} in [200, 404]
        IF    ${response.status_code} == 200
        ${order}=    Set Variable    ${response.json()}
        Should Be True    isinstance($order, dict)
        Dictionary Should Contain Key    ${order}    id
        Dictionary Should Contain Key    ${order}    validated
        Dictionary Should Contain Key    ${order}    orderLines
        Should Be True    isinstance($order['orderLines'], list)
    END

Validate Order With Valid Data Returns Status 200
    [Documentation]    Verify that an authenticated user can validate an order.
    ${add_response}=    Add Product To Current Order
    Should Be Equal As Integers    ${add_response.status_code}    200
    ${response}=    Validate Current Order
    Should Be Equal As Integers    ${response.status_code}    200
    ${order}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${order}[firstname]    Robot
    Should Be Equal As Strings    ${order}[lastname]    Framework
    Should Be Equal As Strings    ${order}[city]    Paris
    Should Be True    ${order}[validated]
    Dictionary Should Contain Key    ${order}    id
    Dictionary Should Contain Key    ${order}    orderLines