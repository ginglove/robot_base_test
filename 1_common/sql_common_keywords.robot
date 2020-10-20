*** Settings ***
Resource        ../0_resources/imports.robot
*** Keywords ***

[Common] - Connect to MySQL database
    [Arguments]  ${DB_Name}    ${DB_User}   ${DB_Pass}  ${DB_Host}  ${DB_Port}
    Connect To Database     pymysql   ${DB_Name}    ${DB_User}   ${DB_Pass}  ${DB_Host}  ${DB_Port}


[Common] - Disconnect database
    Disconnect From Database


[Common] - Execute SQL string
    [Arguments]     ${SQL_string}
    ${output} =    Execute SQL string   ${SQL_string}
    log     ${output}

[Common] - Execute SQL with Query string
    [Arguments]     ${SQL_string}
    ${output} =    Query   ${SQL_string}
    log     ${output}

[Common] - Execute SQL string and compare result
    [Arguments]     ${SQL_string}   ${input_result}
    ${output} =    Query   ${SQL_string}
    @{input_list_results}   Create List     ${input_result}   0
    ${output_res}  remove quote string from sql     ${output}
    ${input_res}    remove quote string       ${input_result}
    Should Be Equal As Strings    ${output_res}    ${input_res}  


[Common] - Execute SQL string and compare row count
    [Arguments]         ${SQL_string}   ${input_row_count}
    ${output} =    Row Count         ${SQL_string}
    log     ${output}
    log     ${input_row_count}
    Should Be Equal As Strings    ${output}    ${input_row_count}   


[Common] - Execute SQL string and compare row count is great than input
    [Arguments]         ${SQL_string}   ${input_row_count}
    Row Count Is Greater Than X        ${SQL_string}      ${input_row_count}

[Common] - Execute SQL string and compare row count is less than input
    [Arguments]         ${SQL_string}       ${input_row_count}
    Row Count Is Less Than X        ${SQL_string}      ${input_row_count}

[Common] - Execute SQL string and compare list of results
    [Arguments]         ${SQL_string}      ${input_list_results}
    ${input_SQL_result} =    Query   ${SQL_string}
    ${number_results} =    Row Count   ${SQL_string}
    :FOR  ${i}  IN RANGE     0  ${number_results}
    \   ${item_input_SQL_result} =	Get From Dictionary	    ${input_SQL_result}	    ${i}
    \   ${item_input_list_results} =	Get From Dictionary	${input_list_results}	    ${i}
    \   Should Be Equal As Strings   ${item_input_SQL_result}   ${item_input_list_results}

[Common] - Verify table is exist
    [Arguments]         ${table_name}
    Table Must Exist    ${table_name}

[Common] - Verify delete all rows in table
    [Arguments]     ${table}
    Delete All Rows From Table     ${table}
    Comment    Sleep    2s

[Common] - Verify data is exist in DB
    [Arguments]     ${input_select_query}
    ${output_result}    Check If Exists In Database       ${input_select_query}

[Common] - Verify data is not exist in DB 
    [Arguments]     ${input_select_query}
    ${output_result}    Check If Not Exists In Database       ${input_select_query}


