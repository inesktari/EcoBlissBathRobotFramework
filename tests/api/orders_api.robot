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

Validate Order Without Authentication Returns Status 401
    [Documentation]    Verify that an unauthenticated user cannot validate an order.
    [Tags]    known_issue    issue_6
    ${response}=    Validate Order Without Authentication
    Log To Console    Actual HTTP status: ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    401

Change Order Line Quantity Returns Status 200
    [Documentation]    Verify that the quantity of an order line can be updated.
    ${product_id}=    Get Product ID Not In Current Order
    ${add_response}=    Add Product To Current Order    ${product_id}
    ${order}=    Set Variable    ${add_response.json()}
    ${order_lines}=    Set Variable    ${order}[orderLines]
    Should Not Be Empty    ${order_lines}

    ${line_id}=    Set Variable    ${NONE}
    FOR    ${line}    IN    @{order_lines}
        IF    ${line}[product][id] == ${product_id}
            ${line_id}=    Set Variable    ${line}[id]
            BREAK
        END
    END
    Should Not Be Equal    ${line_id}    ${NONE}
    
    ${response}=    Change Order Line Quantity    ${line_id}    2
    Should Be Equal As Integers    ${response.status_code}    200
    ${updated_order}=    Set Variable    ${response.json()}
    
    ${updated_lines}=    Set Variable    ${updated_order}[orderLines]
    Should Not Be Empty    ${updated_lines}

    ${updated_line}=    Set Variable    ${NONE}
    FOR    ${line}    IN    @{updated_lines}
        IF    ${line}[id] == ${line_id}
            ${updated_line}=    Set Variable    ${line}
            BREAK
        END
    END
    Should Not Be Equal    ${updated_line}    ${NONE}
    Should Be Equal As Integers    ${updated_line}[quantity]    2
    Dictionary Should Contain Key    ${updated_line}    product

Delete Order Line Returns Status 200
    [Documentation]    Verify that an order line can be deleted from the current order.
    ${product_id}=    Get Product ID Not In Current Order
    ${add_response}=    Add Product To Current Order    ${product_id}    
    ${order}=    Set Variable    ${add_response.json()}
    ${order_lines}=    Set Variable    ${order}[orderLines]
    Should Not Be Empty    ${order_lines}

    ${line_id}=    Set Variable    ${NONE}
    FOR    ${line}    IN    @{order_lines}
        IF    ${line}[product][id] == ${product_id}
            ${line_id}=    Set Variable    ${line}[id]
            BREAK
        END
    END
    Should Not Be Equal    ${line_id}    ${NONE}

    ${response}=    Delete Order Line    ${line_id}
    Should Be Equal As Integers    ${response.status_code}    200
    ${updated_order}=    Set Variable    ${response.json()}
    ${updated_lines}=    Set Variable    ${updated_order}[orderLines]
    FOR    ${line}    IN    @{updated_lines}
        Should Not Be Equal As Integers    ${line}[id]    ${line_id}
    END

Delete Nonexistent Order Line Returns Status 404
    [Documentation]    Verify that deleting a nonexistent order line returns HTTP 404.
    ${response}=    Delete Order Line    999999999    404
    Should Be Equal As Integers    ${response.status_code}    404

Change Nonexistent Order Line Quantity Returns Status 404
    [Documentation]    Verify that changing the quantity of a nonexistent order line returns HTTP 404.
    ${response}=    Change Order Line Quantity    999999999    2    404
    Should Be Equal As Integers    ${response.status_code}    404

Add Product With Quantity Above 20 Returns Client Error
    [Documentation]    Verify that the API rejects adding more than 20 units of a product.
    [Tags]    known_issue    issue_7
    ${product_id}=    Get Product ID Not In Current Order
    ${response}=    Add Product To Current Order    ${product_id}    21    anything
    Log To Console    Actual HTTP status: ${response.status_code}
    Should Be True    ${response.status_code} in [400, 422]