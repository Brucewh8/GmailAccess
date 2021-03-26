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
    ...    ${Account}
    ...    ${secret}[password]
    ...    imap.gmail.com
    ...    993


*** Tasks ***
Access ChinaTel invoice
    Authorize
    @{emails}    List Messages    SUBJECT "中国电信湖北公司电子发票"
    FOR    ${email}    IN    @{emails}
        Save Attachment    ${email}    target_folder=${CURDIR}${/}pdf    overwrite=True
    END

    