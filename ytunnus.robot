*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://www.ytj.fi/
${BROWSER}        Chrome

*** Test Cases ***
Checking the ytunnus data
    Open browser to login page
    Search company    AAC Global Oy
    Open ytunnus
    ${var} =    Save ytunnus to variable
    Click Palaa
    Search saved ytunnus    ${var}
    Checking the data
    [Teardown]    Close browser

*** Keywords ***
Open browser to login page
    Open browser    ${LOGIN URL}    ${BROWSER}
    Title should be    YTJ - Etusivu

Search company
    [Arguments]    ${company_name}
    Input text     search-term    ${company_name}
    #Click button    Etsi
    Press Keys     search-term    RETURN
    Sleep     3s

Open ytunnus
   Click link    //*[@id="search-result"]/table/tbody/tr[2]/td[1]/a
   Sleep     3s

Save ytunnus to variable
    ${variable} =   Get Text    //*[@id="_ctl0_cphSisalto_lblytunnus"]
    [return]     ${variable}

Click Palaa
    Click link    lnkPaluu

Search saved ytunnus
    [Arguments]    ${variable}
    Input text    //*[@id="_ctl0_cphSisalto_ytunnus"]    ${variable}
    Click button   //*[@id="_ctl0_cphSisalto_Hae"]

Checking the data
    ${var1} =    Get Value     //*[@id="search-result"]/table/tbody/tr[2]/td[1]/a
    Page should contain link    ${var1}

    Page should contain element    ${var2}
    //*[@id="search-result"]/table/tbody/tr[2]/td[2]
    Page should contain element      //*[@id="search-result"]/table/tbody/tr[2]/td[3]
