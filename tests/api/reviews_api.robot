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

Create Review With Invalid JSON Returns Status 400
    [Documentation]    Verify that malformed JSON is rejected when creating a review.
    ${response}=    Create Review With Invalid JSON
    Should Be Equal As Integers    ${response.status_code}    400

Create Review With Valid Data Returns Status 200
    [Documentation]    Verify that an authenticated user can create a review.
    ${response}=    Create Review With Valid Data
    Should Be Equal As Integers    ${response.status_code}    200
    ${review}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${review}[title]    Robot Framework Review
    Should Be Equal As Strings    ${review}[comment]    Automated API test review.
    Should Be Equal As Integers    ${review}[rating]    5
    Dictionary Should Contain Key    ${review}    id
    Dictionary Should Contain Key    ${review}    date
    Dictionary Should Contain Key    ${review}    author

Create Review With HTML Content Returns Status 200
    [Documentation]    Verify how the API handles HTML markup in a review comment.
    ${comment}=    Set Variable    <b>Robot Framework HTML test</b>
    ${response}=    Create Review With Valid Data    Robot HTML Test    ${comment}    anything
    Log To Console    Actual HTTP status: ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    200

Create Review With XSS Payload Is Accepted By API
    [Documentation]    Verify that the API accepts a review containing an XSS test payload. Browser-side sanitization was verified manually.
    ${payload}=    Set Variable    <img src="invalid-image" onerror="alert(1)">
    ${response}=    Create Review With Valid Data    Robot XSS Test    ${payload}    anything
    Log To Console    Actual HTTP status: ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    200