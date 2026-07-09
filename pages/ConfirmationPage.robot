*** Settings ***
Documentation     All the page objects and keywords of landing page
Library           SeleniumLibrary
Resource    ../pages/Generic.robot

*** Variables ***
${selectcheckbox}   css:.checkbox label
${clickconfirm}    css:.btn-success

*** Keywords ***

Enter the Country and select the terms
    [arguments]      ${country_name}
    input text      id:country     ${country_name}
    wait until element is visible located on the page        //a[text()='${country_name}']
    click element       css:.suggestions ul li a
    Sleep           2
    click element       ${selectcheckbox}


Purchase the Product and Confirm the Purchase
    click button    ${clickconfirm}
    page should contain     Success!
