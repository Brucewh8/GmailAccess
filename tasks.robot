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
    # Add Gmail Labels    CT_Invoice    (FROM "cthb10000@189.cn" RECENT)
    Save Messages    (FROM "cthb10000@189.cn" UNSEEN)    target_folder=${CURDIR}${/}mail    overwrite=True
    # @{emails}    List Messages    (FROM "cthb10000@189.cn" UNSEEN)
    # FOR    ${email}    IN    @{emails}
    #     Log    ${email}[Subject]
    #     Log    ${email}[Received]
        # Add Gmail Labels    CT_Invoice    Mail-ID ${email}[Mail-Id]
        # Save Attachment    ${email}    target_folder=${CURDIR}${/}pdf    overwrite=True
    END

