*** Settings ***
Documentation       Keywords for the certification level II.
Library             RPA.Browser.Selenium
Library             RPA.Tables
Library             RPA.PDF
Library             RPA.Archive
Library             RPA.Dialogs
Library             OperatingSystem
Variables           variables.py


*** Keywords ***
Close order form modal
    Wait Until Page Contains Element    alias:RobotSpareBinIndustries.Modal.OK
    Click Element    alias:RobotSpareBinIndustries.Modal.OK

*** Keywords ***
Fill the form
    [Arguments]     ${order}
    Wait Until Element Is Visible    alias:RobotSpareBinIndustries.Form.Select.Head
    ${head_nr}=     Evaluate    ${order}[Head]  
    Select From List By Index    alias:RobotSpareBinIndustries.Form.Select.Head     ${head_nr}
    Select Radio Button    body    ${order}[Body]
    Input Text  alias:RobotSpareBinIndustries.Form.Input.Legs   ${order}[Legs]
    Input Text  alias:RobotSpareBinIndustries.Form.ShippingAddress   ${order}[Address]

*** Keywords ***
Preview the robot
    Click Element    id:preview

*** Keywords ***
Submit the order
    Wait Until Keyword Succeeds     ${global_retry_amount}  ${global_retry_interval}
    ...   Submit the order until it succeeds

*** Keywords ***
Submit the order until it succeeds
    Click Element    id:order
    Element Should Be Visible      id:order-completion

*** Keywords ***
Store the receipt as a PDF file
    [Arguments]   ${order_number}
    Wait Until Element Is Visible    id:receipt
    ${receipt_html}=    Get Element Attribute    id:receipt    outerHTML
    Html To Pdf     ${receipt_html}   ${OUTPUT_DIR}${/}receipts${/}receipt${order_number}.pdf
    Wait Until Created      ${OUTPUT_DIR}${/}receipts${/}receipt${order_number}.pdf
    [Return]    ${OUTPUT_DIR}${/}receipts${/}receipt${order_number}.pdf

*** Keywords ***
Take a screenshot of the robot
    [Arguments]   ${order_number}
    Screenshot    id:robot-preview-image    ${OUTPUT_DIR}${/}screenshot${order_number}.png
    Wait Until Created      ${OUTPUT_DIR}${/}screenshot${order_number}.png
    [Return]    ${OUTPUT_DIR}${/}screenshot${order_number}.png

*** Keywords ***
Embed the robot screenshot to the receipt PDF file
    [Arguments]   ${screenshot}     ${pdf}
    Open Pdf       ${pdf}
    Add Watermark Image To Pdf    ${screenshot}   ${pdf}

*** Keywords ***
Go to order another robot
    Click Button    order-another
