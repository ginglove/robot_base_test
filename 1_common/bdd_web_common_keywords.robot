*** Settings ***
Resource    ../0_resources/imports.robot


*** Keywords ***
Open browser with ${url}
    ${browser}    convert to lowercase    ${browser}
    ${true}       convert to boolean      true
    ${list_options}      Create List    --no-sandbox	--headless     --ignore-certificate-errors      --disable-web-security     --disable-impl-side-painting    --enable-features=NetworkService,NetworkServiceInProcess

    ${args}        Create Dictionary    args=${list_options}
    ${desired_capabilities}     create dictionary
    ...         acceptSslCerts=${true}
    ...         acceptInsecureCerts=${true}
    ...         ignore-certificate-errors=${true}
    ...         chromeOptions=${args}
    Run Keyword If    '${browser}' == 'phantomjs'         Run Keywords
    ...              Open PhantomJS Browser with ${url}
    ...        AND     Maximize browser window
    ...     ELSE IF   '${browser}' == 'chrome'            Run Keywords
    ...             Open Browser    ${url}    ${browser}
    ...        AND    Maximize browser window
    ...     ELSE IF   '${browser}' == 'headlesschrome'    Run keywords
    ...             Open Browser    ${url}    ${browser}    desired_capabilities=${desired_capabilities}
    ...        AND     Maximize browser window
    ...     ELSE        should be true  ${FALSE}


Open Chrome Headless Browser with ${url} and ${downloadDir}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${prefs} =    Create Dictionary    download.default_directory=${downloadDir}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --test-type
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --disable-web-security
    Call Method    ${chrome_options}    add_argument    --allow-running-insecure-content
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-impl-side-painting
    Create Webdriver    Chrome        chrome_options=${chrome_options}
    Go To    ${url}

Open PhantomJS Browser with ${url}
    ${service_args}=    Create List    --ignore-ssl-errors=true
    Create Webdriver    PhantomJS    service_args=${service_args}
    Go To    ${url}

Open Safari browser with ${url}
    Create Webdriver  Safari  executable_path=/Applications/Safari Technology Preview.app/Contents/MacOS/safaridriver
    Go To   ${url}


Open Browser with ${url} and ${downloadDir}
    Run Keyword If    '${browser}' == 'phantomjs'         Run Keywords
    ...              Open PhantomJS Browser with ${url}
    ...        AND     Maximize browser window
    ...     ELSE IF   '${browser}' == 'chrome'            Run Keywords
    ...             Open Chrome Browser with ${url} and ${downloadDir}
    ...        AND     Maximize browser size to fit screen
    ...     ELSE IF   '${browser}' == 'headlesschrome'    Run keywords
    ...             Open Chrome Headless Browser with ${url} and ${downloadDir}
    ...        AND     Maximize browser size to fit screen
    ...     ELSE        should be true  ${FALSE}


Open Chrome Browser with ${url} and ${downloadDir}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${prefs} =    Create Dictionary    download.default_directory=${downloadDir}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --test-type
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --disable-web-security
    Call Method    ${chrome_options}    add_argument    --allow-running-insecure-content
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-impl-side-painting
    Create Webdriver    Chrome        chrome_options=${chrome_options}
    Go To    ${url}


Input ${value} into ${element}
    [Documentation]    input element location with value
	Wait Until Element Is Visible    ${element}   5s
    Input Text    ${element}    ${value}

Click on ${element}
    [Documentation]    Click element Button
	Wait Until Element Is Visible    ${element}    10s
    Click Element    ${element}

Validate text of ${element} should be ${expected_value}
    Wait Until Element Is Visible    ${element}    10 Seconds
    Element Text Should Be    ${element}    ${expected_value}

Button ${element} should Be Disabled
    [Documentation]    Verify Payment History export button should be Disabled
    Element Should Be Disabled    ${element}

Page should not contain button ${element}
#    TODO will update to allow @{buttons} as web_locator arguments
    Page Should Not Contain Element     ${element}