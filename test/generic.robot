*** Settings ***
Documentation    Test Suite for validate the login here
...
...             The system specific keywords created here from our own
...             domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.
Library        SeleniumLibrary
Library        OperatingSystem
Suite Setup    Initial Setup
Test Setup      Open The URL With The Login URL  ${URL}    ${BROWSER}
Test Teardown  Close Browser

*** Variables ***
${URL}                     https://rahulshettyacademy.com/loginpagePractise/
${BROWSER}                 Chrome
${USERNAME}                rahulshettyacademy
${PASSWORD}                Learning@830$3mK2
${INVALID_PASSWORD}        1earning@830$3mK2

*** Keywords ***
Initial Setup
    Prepare Screenshot Directory
    Delete Old Screenshots

Prepare Screenshot Directory
    Create Directory    ${SCREENSHOT_DIR}
    Set Screenshot Directory    ${SCREENSHOT_DIR}
    Log To Console    Screenshot directory: ${SCREENSHOT_DIR}
    Delete Old Screenshots

Delete Old Screenshots
    Run Keyword And Ignore Error    Remove Files    ${SCREENSHOT_DIR}${/}*.png

Open the URL with the login URL
    [Arguments]     ${URL}    ${BROWSER}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Close Browser session
    Close Browser