*** Settings ***
Documentation    Suite description
Resource      ../imports.robot
Suite Setup       [Kw] - Open browser
Test Teardown     [Common] - Close Browser

*** Variables ***
${browser}    chrome
${url}    https://vnexpress.net/
${DownloadDir}      ../0_resources/chromedriver


*** Test Cases ***
Test title    
     [Kw] - Click login button and wait for Login txtbox display 