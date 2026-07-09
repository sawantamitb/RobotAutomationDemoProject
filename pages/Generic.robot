*** Settings ***
Documentation    Test Suite for validate the login here
...
...             The system specific keywords created here from our own
...             domain specific language. They utilize keywords provided
...              by the imported SeleniumLibrary.

Library        OperatingSystem

*** Variables ***
${ENV}                     QA
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
    [Arguments]    ${URL}    ${BROWSER}=chrome

    ${browser}=    Convert To Lower Case    ${BROWSER}

    IF    '${browser}' == 'chrome'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

        ${prefs}=    Create Dictionary
        ...    credentials_enable_service=${False}
        ...    profile.password_manager_enabled=${False}
        ...    profile.password_manager_leak_detection=${False}

        Call Method    ${options}    add_experimental_option    prefs    ${prefs}

        Create Webdriver    Chrome    options=${options}

    ELSE IF    '${browser}' == 'edge'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver

        Create Webdriver    Edge    options=${options}

    ELSE IF    '${browser}' == 'firefox'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver

        Create Webdriver    Firefox    options=${options}

    ELSE
        Fail    Unsupported browser: ${BROWSER}
    END

    Go To    ${URL}
    Maximize Browser Window

Close Browser session
    Close Browser

wait until element is visible located on the page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible       ${page_locator}     20 seconds

wait until element is not visible located on the page
    [Arguments]    ${page_locator}
    Wait Until Element Is Not Visible       ${page_locator}     20 seconds