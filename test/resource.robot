*** Settings ***
Documentation    Test Suite for validate the login here
...             
...             The system specific keywords created here from our own 
...             domain specific language. They utilize keywords provided 
...              by the imported SeleniumLibrary.
Library    SeleniumLibrary
Library    OperatingSystem
Suite Setup    Prepare Screenshot Directory
Test Teardown    Close Browser

*** Variables ***
${URL}        https://automationpractice.techwithjatin.com/
${BROWSER}    Chrome

*** Keywords ***
Open the URL with the login URL
    [Arguments]     ${URL}    ${BROWSER}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Click Link    xpath://a[normalize-space()='Sign in']

Close Browser Session
    Close Browser


