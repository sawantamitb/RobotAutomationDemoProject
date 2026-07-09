*** Settings ***
Documentation    Test Suite for validate the login here
Library    SeleniumLibrary
Library    OperatingSystem
Default Tags    Positive
Suite Setup    Initial Setup
Test Setup    Open the URL with the login URL    ${URL}   ${BROWSER}
Test Teardown    Close Browser

# Resource

*** Variables ***
${INVALID_ERROR_MESSAGE}    xpath://li[normalize-space()='Authentication failed.']
${URL}        https://automationpractice.techwithjatin.com/
${BROWSER}    Chrome
${SIGN_OUT_LINK}    css:a[title='Log me out']
${SCREENSHOT_DIR}    ${CURDIR}/../screenshots

*** Test Cases ***
Login user with valid credential
    Fill Login Form    labisok230@hidevak.com    Test@12311
    Validate Successful Login

Login user with invalid credential
    Fill Login Form    labisok230@hidevak.com    Test@1234
    Validate Invalid Login

*** Keywords ***
Initial Setup
    Prepare Screenshot Directory
    Delete Old Screenshots

Prepare Screenshot Directory
    Set Screenshot Directory    ${SCREENSHOT_DIR}
    Log To Console    Screenshot directory: ${SCREENSHOT_DIR}
    Delete Old Screenshots

Delete Old Screenshots
    Run Keyword And Ignore Error    Remove Files    ${SCREENSHOT_DIR}${/}*.png

Open the URL with the login URL
    [Arguments]     ${URL}    ${BROWSER}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Click Link    xpath://a[normalize-space()='Sign in']

Fill Login Form
    [Arguments]    ${email}    ${password}
    Input Text    id:email    ${email}
    Input Text    id:passwd   ${password}
    Click Button  id:SubmitLogin

Validate Successful Login
    Wait Until Element Is Visible    ${SIGN_OUT_LINK}
    ${username}=    Get Text    css:a[title='View my customer account'] span
    Should Be Equal As Strings    ${username}    Amit Sawant
    Log To Console    User Name: ${username}

Validate Invalid Login
    Wait Until Element Is Visible    ${INVALID_ERROR_MESSAGE}
    ${error}=    Get Text    ${INVALID_ERROR_MESSAGE}
    Should Be Equal As Strings    ${error}    Authentication failed.
    Element Text Should Be    ${INVALID_ERROR_MESSAGE}    Authentication failed.
    Log To Console    Error: ${error}
