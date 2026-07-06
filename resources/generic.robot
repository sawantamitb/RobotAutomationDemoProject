*** Settings ***
Documentation    Test Suite for validate the login here
...
...             The system specific keywords created here from our own
...             domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.

*** Variables ***
${URL}                     https://rahulshettyacademy.com/loginpagePractise/
${BROWSER}                 Chrome
${USERNAME}                rahulshettyacademy
${PASSWORD}                Learning@830$3mK2
${INVALID_PASSWORD}        1earning@830$3mK2
${SCREENSHOT_DIR}          ${CURDIR}/../screenshots


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
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    ...    profile.password_manager_leak_detection=${False}

    Call Method    ${options}    add_experimental_option    prefs    ${prefs}

    Create Webdriver    ${BROWSER}    options=${options}
    Go To    ${URL}
    Maximize Browser Window

Close Browser session
    Close Browser
