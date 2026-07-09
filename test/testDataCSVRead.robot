*** Settings ***
Documentation    Test Suite for validate the login here
Library        SeleniumLibrary
Library        OperatingSystem
Library        Collections
Library        String
Library        DataDriver      file=../data/data.csv   encoding=utf_8  dialect=unix

Suite Setup     Initial Setup
Test Setup      Open The URL With The Login URL  ${URL}    ${BROWSER}
Test Teardown   Close Browser
Test Template   Validate Unsuccessful Login
Default Tags    Positive
Resource         ../pages/Generic.robot
#Resourcecls


*** Variables ***
${ERROR_MESSAGE_LOGIN}     css:.alert-danger
${SHOP_PAGE_LOAD}          css:.nav-link

*** Test Cases ***
Login with user ${username} and password ${password}        default     default

*** Keywords ***
Validate Unsuccessful Login
   [Arguments]    ${username}    ${password}
   #Open the URL with the login URL    ${URL}    ${BROWSER}
   Fill the login Form     ${username}    ${password}
   wait until it checks and display error message     ${ERROR_MESSAGE_LOGIN}
   verify error message is correct

Fill the login Form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Text    id:password    ${password}
    Click Button  signInBtn

wait until it checks and display error message
    [Arguments]    ${ERROR_MESSAGE_LOGIN}
    Wait Until Element Is Visible       ${ERROR_MESSAGE_LOGIN}

verify error message is correct
   ${result}=   Get Text    ${ERROR_MESSAGE_LOGIN}
   Should Be Equal As Strings     ${result}     Incorrect username/password.
   Element Text Should Be       ${ERROR_MESSAGE_LOGIN}      Incorrect username/password.


