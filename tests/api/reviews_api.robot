*** Settings ***
Documentation    API tests for EcoBlissBath reviews
Library    Collections
Resource    ../../resources/api_keywords.resource

*** Test Cases ***
Get All Reviews Returns A List
    [Documentation]    Verify that GET /reviews returns HTTP 200 and a JSON list
    ${response}=    Get All Reviews
    Should Be Equal As Integers    ${response.status_code}    200
    ${reviews}=    Set Variable    ${response.json()}
    Should Be True    isinstance($reviews, list)

    FOR    ${review}    IN    @{reviews}
        Should Be True    isinstance($review, dict)
        Dictionary Should Contain Key    ${review}    id
        Dictionary Should Contain Key    ${review}    title
        Dictionary Should Contain Key    ${review}    comment
        Dictionary Should Contain Key    ${review}    rating
        Dictionary Should Contain Key    ${review}    author
    END