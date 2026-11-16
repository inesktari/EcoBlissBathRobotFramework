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
        Should Be True    isinstance($response.json(), dict)
        Dictionary Should Contain Key    ${response.json()}    orderLines
    END