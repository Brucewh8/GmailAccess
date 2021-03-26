*** Settings ***
Documentation   Template robot main suite.
Library    RPA.Email.ImapSmtp
...    smtp_server=smtp.gmail.com
...    smtp_port=587
# ...    imap_server=imap.gmail.com
# ...    imap_port=993
Library    RPA.Robocloud.Secrets


*** Keywords ***
Authorize account
    ${secret}=    Get Secret    wz
    Authorize
    ...    account=${secret}[username]
    ...    password=${secret}[password]


*** Tasks ***
Access ChinaTel invoice
    Authorize account
    @{emails}    List Messages    SUBJECT "中国电信湖北公司电子发票"
    FOR    ${email}    IN    @{emails}
        Save Attachment    ${email}    target_folder=${CURDIR}${/}pdf    overwrite=True
    END

    