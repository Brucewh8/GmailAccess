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
    @{emails}    List Messages    FROM "cthb10000@189.cn"
    # FOR    ${email}    IN    @{emails}
    #     Save Attachment    ${email}    target_folder=${CURDIR}${/}pdf    overwrite=True
    # END

