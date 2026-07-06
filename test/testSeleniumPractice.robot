*** Settings ***
Documentation    Test Suite for validate the login here
Library        SeleniumLibrary
Library        OperatingSystem
Library        Collections
Library        String

Suite Setup    Initial Setup
Test Setup     Open The URL With The Login URL  ${URL}    ${BROWSER}
Test Teardown  Close Browser
Default Tags    Positive
Resource    resource/generic.robot
#Resource

*** Variables ***
${ERROR_MESSAGE_LOGIN}     css:.alert-danger
${SHOP_PAGE_LOAD}          css:.nav-link

*** Test Cases ***

Validate Unsuccessful Login
    [Tags]      SMOKE
    Fill the login Form     ${USERNAME}    ${INVALID_PASSWORD}
    wait until it checks and display error message     ${ERROR_MESSAGE_LOGIN}
    verify error message is correct

Validate Cards display in the Shopping Page
    [Tags]      SANITY
    Fill the login Form     ${USERNAME}    ${PASSWORD}
    wait until Element is located in the page     ${SHOP_PAGE_LOAD}
    Verify Card titles in the Shop page
    Select the Card     Nokia Edge

Select the Form and navigate to Child window
    [Tags]      SMOKE
    Fill the Login Details and Login Form    ${USERNAME}    ${PASSWORD}

Validate Child window Functionality
    [Tags]      NEWFEATURE
    Select the link of Child window
    Verify the user is Switched to Child window
    Grab the Email id in the Child Window
    Switch to Parent window and enter the Email

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
    [Arguments]     ${SHOP_PAGE_LOAD}
    Wait Until Element Is Visible       ${SHOP_PAGE_LOAD}

Verify Card titles in the Shop page
   @{expectedList} =    Create List     iphone X    Samsung Note 8      Nokia Edge       Blackberry
   ${elements} =  Get WebElements     css:.card-title
   @{actualList} =   Create List
   FOR  ${element}  IN      @{elements}
      Log To Console    ${element.text}
      Log   ${element.text}
      Append To List    ${actualList}     ${element.text}
   END
   Lists Should Be Equal   ${expectedList}    ${actualList}

Select the Card
    [Arguments]    ${cardName}
    ${elements} =  Get WebElements     css:.card-title
    ${index}=   Set Variable    1
     FOR  ${element}  IN      @{elements}
         Exit For Loop If      '${cardName}' == '${element.text}'
         ${index}=  Evaluate   ${index} + 1
     END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

Fill the Login Details and Login Form
    [Arguments]        ${email}     ${password}
    Input Text          id:username     ${email}
    Input Password      id:password     ${password}
    Click Element       css:input[value='user']
    Wait Until Element Is Visible       css:.modal-body
    #Click Button        id:okayBtn
    Click Button        id:okayBtn
    Wait Until Element Is Not Visible   css:.modal-body
    Select From List By Value       css:select.form-control       teach
    Select Checkbox     terms
    Checkbox Should Be Selected     terms

Select the link of Child window
    click element       css:.blinkingText
    Sleep               5

Verify the user is Switched to Child window
    switch window       NEW
    Element Text Should Be       css:h1     DOCUMENTS REQUEST

Grab the Email id in the Child Window
    ${text}=    get text    css:.red
    @{words}=   Split String    ${text}     at
    #0 ->Please email u
    #1-> mentor@rahulshettyacademy.com with below template to receive response
    ${text_split}=      Get From List       ${words}    1
    log     ${text_split}
    Log To Console    ${text_split}
     @{words_2}=   Split String    ${text_split}
     #0->mentor@rahulshettyacademy.com
     ${email}=      Get From List    ${words_2}    0
     Set Global Variable         ${email}
     log     ${email}
     Log To Console    ${email}
     
Switch to Parent window and enter the Email
    switch window       MAIN
    Title Should Be     LoginPage Practise | Rahul Shetty Academy
    Input Text          id:username     ${email}

