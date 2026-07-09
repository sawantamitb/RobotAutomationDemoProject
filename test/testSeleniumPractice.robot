*** Settings ***
Documentation    Test Suite for validate the login here
Library        Collections
Library        String
Library        SeleniumLibrary
Library        ../customlibraries/Shop.py
Library        DataDriver      file=../data/data.csv   encoding=utf_8  dialect=unix

Suite Setup    Initial Setup
Test Setup     Open The URL With The Login URL  ${URL}    ${BROWSER}
Test Teardown  Close Browser
Test Template  Validate Unsuccessful Login
Default Tags    Positive
Resource    ../pages/Generic.robot
Resource    ../pages/HomePage.robot
Resource    ../pages/ShopPage.robot
Resource    ../pages/CheckoutPage.robot
Resource    ../pages/ConfirmationPage.robot

*** Variables ***
@{ListofProducts}         iphone X     Samsung Note 8
${country_name}     India

*** Test Cases ***

Login with multiple test data user ${username} and password ${password}        default     default
    [Tags]      DATADRIVEN

Validate Unsuccessful Login
    [Tags]      SMOKE
    HomePage.Fill the login Form     ${USERNAME}    ${INVALID_PASSWORD}
    HomePage.wait until element is located on the page    ${ERROR_MESSAGE_LOGIN}
    HomePage.verify error message is correct

End to end ecommerce Product validation
    [Tags]      REGRESSION
    HomePage.Fill the login Form     ${USERNAME}    ${PASSWORD}
    ShopPage.wait until Element is located in the page     ${SHOP_PAGE_LOAD}
    ShopPage.Verify Card titles in the Shop page
    add items to cart and checkout     ${ListofProducts}
    CheckoutPage.Verify items in the Checkout Page and proceed
    ConfirmationPage.Enter the Country and select the terms     ${country_name}     
    ConfirmationPage.Purchase the Product and Confirm the Purchase

Select the Form and navigate to Child window
    [Tags]      SANITY
    HomePage.Fill the Login Details and Login Form    ${USERNAME}    ${PASSWORD}   ${LOGIN_POPUP}


*** Keywords ***

Validate Unsuccessful Login
   [Arguments]    ${username}    ${password}
   HomePage.Fill the login Form   ${username}    ${password}
   HomePage.wait until element is located on the page    ${ERROR_MESSAGE_LOGIN}
   HomePage.verify error message is correct