*** Settings ***
Documentation    Page Objects for Home Page & Keywords of Landing Page
Library        SeleniumLibrary
Resource    ../pages/Generic.robot

*** Variables ***
${ERROR_MESSAGE_LOGIN}     css:.alert-danger
${LOGIN_POPUP}    css:.modal-body

*** Keywords ***

Fill the login Form
    [Arguments]    ${email}    ${password}
    Input Text    id:username    ${email}
    Input Text    id:password    ${password}
    Click Button  signInBtn
    
wait until element is located on the page
    [Arguments]    ${ERROR_MESSAGE_LOGIN}
    wait until element is visible located on the page  ${ERROR_MESSAGE_LOGIN}

verify error message is correct
   ${result}=   Get Text    ${ERROR_MESSAGE_LOGIN}
   Should Be Equal As Strings     ${result}     Incorrect username/password.
   Element Text Should Be       ${ERROR_MESSAGE_LOGIN}      Incorrect username/password.

Fill the Login Details and Login Form
    [Arguments]        ${email}     ${password}     ${loginpopup}
    Input Text          id:username     ${email}
    Input Password      id:password     ${password}
    Click Element       css:input[value='user']
    wait until element is visible located on the page      ${loginpopup}
    #Click Button        id:okayBtn
    Click Button        id:okayBtn
    wait until element is not visible located on the page   ${loginpopup}
    Select From List By Value       css:select.form-control       teach
    Select Checkbox     terms
    Checkbox Should Be Selected     terms