*** Settings ***
Documentation       Test suite for EcoBlissBath product features

Resource            ../../resources/keywords.resource
Test Setup    Open EcoBlissBath Website
Test Teardown     Close Browser Session
Library    Collections

*** Test Cases ***
User Can Add Product To Cart
    [Documentation]    Verify that a logged-in user can add a product to the shopping cart
    Open EcoBlissBath Website
    Login As Valid User
    Add First Product To Cart
    Verify Product Is In Cart

Out Of Stock Products Cannot Be Added To Cart
    [Documentation]    Verify that the Add to Cart button is disabled for every product with zero or negative stock.
    Go To    ${URL}/#/products
    Wait Until Element Is Visible    css:.list-products article.mini-product    ${TIMEOUT}

    @{product_links}=    Get WebElements    css:.list-products article.mini-product [data-cy="product-link"]
    ${count}=    Get Length    ${product_links}
    Should Be True    ${count} > 0
    @{problematic_products}=    Create List

    FOR    ${index}    IN RANGE    ${count}
        Go To    ${URL}/#/products
        Wait Until Element Is Visible    css:.list-products article.mini-product    ${TIMEOUT}

        @{links}=    Get WebElements    css:.list-products article.mini-product [data-cy="product-link"]
        Click Element    ${links}[${index}]

        Wait Until Element Is Visible    ${PRODUCT_STOCK}    ${TIMEOUT}
        ${product_name}=    Get Text    css:[data-cy="detail-product-name"]
        ${stock_text}=    Get Text    ${PRODUCT_STOCK}
        ${stock}=    Evaluate    int($stock_text.split()[0])

        Log To Console    Product: ${product_name} | Stock: ${stock}

        IF    ${stock} <= 0
            ${enabled}=    Run Keyword And Return Status
            ...    Element Should Be Enabled    ${ADD_TO_CART_BUTTON}
            IF    ${enabled}
                Append To List    ${problematic_products}    ${product_name} (stock: ${stock})
            END
        END
    END

    ${problems}=    Evaluate    ", ".join($problematic_products)
    Should Be Empty    ${problematic_products}    Products with stock <= 0 have an enabled Add to Cart button: ${problems}