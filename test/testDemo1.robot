*** Settings ***
Documentation    Test Suite for validate the login here
Library    SeleniumLibrary
Default Tags    Positive
Test Teardown    Close Browser

*** Variables ***
${INVALID_ERROR_MESSAGE}    xpath://li[normalize-space()='Authentication failed.']
${URL}        https://automationpractice.techwithjatin.com/

*** Test Cases ***
Login user with valid credential
    Open the URL with the login URL    Chrome
    Fill Login Form    labisok230@hidevak.com    Test@123
    Validate Successful Login

Login user with invalid credential
    Open the URL with the login URL    Firefox
    Fill Login Form    labisok230@hidevak.com    Test@1234
    Validate Invalid Login

*** Keywords ***

Open the URL with the login URL
    [Arguments]    ${browser}
    Create Webdriver    ${browser}
    Go To    https://automationpractice.techwithjatin.com/
    Maximize Browser Window
    Click Link    xpath://a[normalize-space()='Sign in']

Fill Login Form
    [Arguments]    ${email}    ${password}
    Input Text    id:email    ${email}
    Input Text    id:passwd   ${password}
    Click Button  id:SubmitLogin

Validate Successful Login
    Element Should Be Visible    css:a[title='Log me out']
    ${username}=    Get Text    css:a[title='View my customer account'] span
    Should Be Equal As Strings    ${username}    Amit Sawant
    Log To Console    User Name: ${username}

Validate Invalid Login
    Wait Until Element Is Visible    ${INVALID_ERROR_MESSAGE}
    ${error}=    Get Text    ${INVALID_ERROR_MESSAGE}
    Should Be Equal As Strings    ${error}    Authentication failed.
    Element Text Should Be    ${INVALID_ERROR_MESSAGE}    Authentication failed.
    Log To Console    Error: ${error}
