*** Settings ***
Documentation       Centralized UI locators for the EcoBlissBath application.


*** Variables ***
${HOME_TITLE}               EcoBlissBath
${PRODUCT_CARD}    css:[data-cy="product-home"]
${PRODUCT_DETAILS_LINK}      css:[data-cy="product-home-link"]
${ADD_TO_CART_BUTTON}        css:[data-cy="detail-product-add"]
${CART_ICON}    css:[data-cy="nav-link-cart"]
${CHECKOUT_BUTTON}          css:.checkout
${LOGOUT_LINK}    xpath=//a[@data-cy='nav-link-logout']
${CART_PRODUCT_NAME}    css:[data-cy="cart-line-name"]
${CART_PRODUCT_QUANTITY}    css:[data-cy="cart-line-quantity"]
${CART_DELETE_BUTTON}    css:[data-cy="cart-line-delete"]
${CART_LINE_TOTAL}    css:[data-cy="cart-line-total"]
