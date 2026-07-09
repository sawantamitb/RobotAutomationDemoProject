*** Settings ***
Documentation     All the page objects and keywords of checkout page
Library           SeleniumLibrary

*** Variables ***
${Shop_page_load}           css:.nav-link

*** Keywords ***
Verify items in the Checkout Page and proceed
    click element   css:.btn-success
    sleep   2