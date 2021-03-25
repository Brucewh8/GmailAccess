*** Settings ***
Documentation   Template robot main suite.
Library    RPA.Email.ImapSmtp
Library    RPA.Robocloud.Secrets


*** Variables ***
${Account}    wangzhiwh


*** Keywords ***
Authorize
    ${secret}=    Get Secret    ${Account}
    Authorize IMAP
    ...    ${secret}[username]
    ...    ${secret}[password]
    ...    imap.gmail.com
    ...    993


*** Keywords ***
Create folder and move mails in
    [Arguments]    ${SENDER}
    Run Keyword And Ignore Error
    ...    Create Folder
    ...    ${SENDER}
    Move Messages
    ...    criterion=FROM "${SENDER}"
    ...    target_folder=${SENDER}


*** Tasks ***
Access CMB Email
    Authorize
    Create folder and move mails in    招商银行信用卡

    