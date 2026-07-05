*** Settings ***
Documentation    Test Suite for validate the login here
Library    SeleniumLibrary
Library    OperatingSystem
Default Tags    Positive
Resource    generic.robot
#Resource

*** Variables ***
${ERROR_MESSAGE_LOGIN}     css:.alert-danger
${SHOP_PAGE_LOAD}          css:.nav-link

*** Test Cases ***

Validate Unsuccessful Login
    [Tags]      SMOKE
    Open The URL With The Login URL  ${URL}    ${BROWSER}
    Fill the login Form     ${USERNAME}    ${INVALID_PASSWORD}
    wait until it checks and display error message     ${ERROR_MESSAGE_LOGIN}
    verify error message is correct

Validate Cards display in the Shopping Page
    Open The URL With The Login URL  ${URL}    ${BROWSER}
    Fill the login Form     ${USERNAME}    ${PASSWORD}
    wait until Element is located in the page     ${SHOP_PAGE_LOAD}
    #Verify Card titles in the Shop page
    #Select the Card     Nokia Edge

*** Keywords ***

Fill the login Form
    [Arguments]    ${email}    ${password}
    Input Text    id:username    ${email}
    Input Text    id:password    ${password}
    Click Button  signInBtn

wait until it checks and display error message
    [Arguments]    ${ERROR_MESSAGE_LOGIN}
    Wait Until Element Is Visible       ${ERROR_MESSAGE_LOGIN}

verify error message is correct
   ${result}=   Get Text    ${ERROR_MESSAGE_LOGIN}
   Should Be Equal As Strings     ${result}     Incorrect username/password.
   Element Text Should Be       ${ERROR_MESSAGE_LOGIN}      Incorrect username/password.

wait until Element is located in the page
    [arguments]     ${SHOP_PAGE_LOAD}
    Wait Until Element Is Visible       ${SHOP_PAGE_LOAD}





