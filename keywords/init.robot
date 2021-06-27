*** Settings ***
Documentation       Keywords for the certification level II
Library             RPA.Browser.Selenium
Library             RPA.HTTP
Library             RPA.Tables
Library             RPA.Dialogs
Library             RPA.Robocloud.Secrets
Variables           variables.py

*** Keywords ***
Ask user where to get the CSV
    Create Form         Where can I download the URL?
    Add Text Input      URL    endpoint
    &{response}=        Request Response
    [Return]            ${response}[endpoint]

*** Keywords ***
Get orders 
    [Arguments]    ${url_csv}
    Download    ${url_csv}    overwrite=True
    ${orders_table}=   Read Table From Csv    ${filename_csv}    header=True
    [Return]    ${orders_table}

*** Keywords ***
Open robot order website
    ${secret}=      Get Secret    robotsparebin
    Open Available Browser      ${secret}[url_orders]
