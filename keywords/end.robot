*** Settings ***
Documentation       Keywords for the certification level II.
Library             RPA.Browser.Selenium
Library             RPA.Archive
Variables           variables.py

*** Keywords ***
Create a ZIP file of the receipts
    Archive Folder With Zip    ${OUTPUT_DIR}${/}receipts    receipts.zip

*** Keywords ***
Close the browser
    Close Browser
