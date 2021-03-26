*** Settings ***
Documentation   Template robot main suite.
Library    RPA.Email.ImapSmtp
...    smtp_server=smtp.gmail.com
...    smtp_port=587
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
    Add Gmail Labels    CT_Invoice    FROM "cthb10000@189.cn"
    @{emails}    List Messages    FROM "cthb10000@189.cn"
    FOR    ${email}    IN    @{emails}
        Log    ${email}[Has-Attachments]
        Save Attachment    ${email}    target_folder=${CURDIR}${/}output    overwrite=True
    END

