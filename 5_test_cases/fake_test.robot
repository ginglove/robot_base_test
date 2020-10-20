*** Settings ***
Documentation    Suite description
Resource      ../imports.robot

*** Variables ***
${browser}    chrome
${url}    https://vnexpress.net/
${DownloadDir}      ../0_resources/chromedriver


*** Test Cases ***
Test title
     [Kw] - Open browser
     [Kw] - Click login button and wait for Login txtbox display 
     [Common] - Close Browser