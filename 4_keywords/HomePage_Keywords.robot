*** Settings ***
Documentation    Suite description
Resource      ../imports.robot


*** Keywords ***
[Kw] - Open browser     
     [Common] - Open Chrome Browser with mode           ${url}
[Kw] - Click login button 
     [Common] - click element           //div[@id='myvne_taskbar']//div[@id='myvne']

[Kw] - Click login button and wait for Login txtbox display
     [Common] - click element     ${btn_login}
     [Common] - Select Iframe     ${iframe_login}
     [Common] - Input text into textbox     ${txtbox_form_account}        abcd
