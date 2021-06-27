*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.
Resource          init.robot
Resource          main.robot
Resource          end.robot


# +
*** Keywords ***
Initialize
    Open robot order website

End Process
    Create a ZIP file of the receipts
    Close the browser
# -

*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    [Setup]    Initialize
    
    ${url_csv}=    Ask user where to get the CSV
    ${orders}=     Get orders   ${url_csv}

    FOR    ${order}   IN  @{orders}
        Close order form modal
        Fill the form   ${order}
        Preview the robot
        Submit the order
        ${pdf}=    Store the receipt as a PDF file    ${order}[Order number]
        ${screenshot}=    Take a screenshot of the robot    ${order}[Order number]
        Embed the robot screenshot to the receipt PDF file    ${screenshot}    ${pdf}
        Go to order another robot
    END
    
    [Teardown]    End Process


