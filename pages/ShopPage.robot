*** Settings ***
Documentation    Page Objects for Home Page & Keywords of Shop Page
Library        SeleniumLibrary
Resource    ../pages/Generic.robot

*** Variables ***
${SHOP_PAGE_LOAD}          css:.nav-link

*** Keywords ***

wait until Element is located in the page
   [Arguments]    ${SHOP_PAGE_LOAD}
   wait until element is visible located on the page       ${SHOP_PAGE_LOAD}

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

