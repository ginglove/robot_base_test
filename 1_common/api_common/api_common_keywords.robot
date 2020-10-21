*** Settings ***
Resource        ../0_resources/imports.robot


*** Variables ***
${UPPER_CASES}       ABCDEFGHIJKLMNOPQRSTUVWXYZ
${LOWER_CASES}       abcdefghijklmnopqrstuvwxyz
${NUMBERS}           0123456789
${LETTERS}           ${UPPER_CASES}${LOWER_CASES}


*** Keywords ***
[Common] - Create string param
    [Arguments]  ${key}     ${value}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   '${value}'!='${param_not_used}'   set variable   "${key}":"${value}",
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   '${value}'=='${param_is_null}'   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Create int param
    [Arguments]  ${key}     ${value}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   '${value}'!='${param_not_used}'   set variable   "${key}":${value},
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   '${value}'=='${param_is_null}'   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Create boolean param
    [Arguments]  ${key}     ${value}
    ${param_Json}     set variable    ${empty}
    ${has_value}    Run keyword and return status   should not be equal as strings  ${value}    ${param_not_used}
    ${value}=     run keyword if  ${has_value}    convert to string    ${value}
    ${value_lower}=     run keyword if  ${has_value}    convert to lowercase    ${value}
    ${param_Json}=      run keyword if  ${has_value}    set variable    "${key}":${value_lower},
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   '${value}'=='${param_is_null}'   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Create Json data for list param with quote
    [Arguments]  ${key}     ${list}
    ${convert_list}      convert list to string with quote   ${list}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   "${list}"!="${param_not_used}"   set variable   "${key}":[${convert_list}],
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   "${list}"=="${param_is_null}"   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Create Json data for list param without quote
    [Arguments]  ${key}     ${list}
    ${convert_list}      convert list to string without quote   ${list}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   "${list}"!="${param_not_used}"   set variable   "${key}":[${convert_list}],
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   "${list}"=="${param_is_null}"   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Create Json data for integer value in array
    [Arguments]  ${value}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   '${value}'!='${param_not_used}'   set variable   ${value},
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   "${value}"=="${param_is_null}"   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Set default value for keyword in dictionary
    [Arguments]  ${dic}     ${key}      ${default_value}
    ${get_key_result}         Evaluate            $dic.get("${key}", "${default_value}")
    Set to dictionary           ${dic}          ${key}       ${get_key_result}
    [Return]      ${dic}

[Common] - Set default value for non-string keyword in dictionary
    [Arguments]  ${dic}     ${key}      ${default_value}
    ${get_key_result}         Evaluate            $dic.get("${key}", ${default_value})
    Set to dictionary           ${dic}          ${key}       ${get_key_result}
    [Return]      ${dic}

[Common] - Create int param in dic
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create int param		${key}		${arg_dic.${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create int param of object in dic
    [Arguments]    ${arg_dic}      ${object_name}       ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${object_name}_${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create int param		${key}		${arg_dic.${object_name}_${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create boolean param in dic
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create boolean param      ${key}		${arg_dic.${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create boolean param of object in dic
    [Arguments]    ${arg_dic}       ${object_name}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${object_name}_${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create boolean param      ${key}		${arg_dic.${object_name}_${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create string param in dic
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create string param      ${key}		${arg_dic["${key}"]}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create string param of object in dic
    [Arguments]    ${arg_dic}       ${object_name}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${object_name}_${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create string param      ${key}		${arg_dic.${object_name}_${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create string param of object in dictionary
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create string param of object      ${key}		${arg_dic.${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create string param of object
    [Arguments]  ${key}     ${value}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   '${value}'!='${param_not_used}'   set variable   "${key}":[${value}],
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   '${value}'=='${param_is_null}'   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common] - Set '${var_name:[^\s.]+}' is '${value}'
    Set Test Variable    ${${var_name}}    ${value}
    Log    ${${var_name}}

[Common] - Get current start date
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    set test variable    ${test_current_from_date}     ${current_date}T00:00:00Z

[Common] - Get current end date
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    set test variable    ${test_current_end_date}     ${current_date}T23:59:59Z

[Suite][Common] - Get current end date
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    set suite variable  ${suite_current_end_date}     ${current_date}T23:59:59Z

[Common] - Create Json data for list param with quote in dictionary
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create Json data for list param with quote      ${key}		${arg_dic.${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create Json data for list param without quote in dictionary
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create Json data for list param without quote      ${key}		${arg_dic.${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - create json data for user id object in dic
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   create json data for user id object         ${arg_dic.payee_user_id}      ${arg_dic.payee_user_type}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - create json data for user ref object in dic
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   create json data for user ref object    ${arg_dic.payee_user_ref_type}      ${arg_dic.payee_user_ref_value}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - add new param in header
    [Arguments]  ${arg_dic}    ${key}   ${header_dic}
    ${status}   run keyword and return status   dictionary should contain key     ${arg_dic}   ${key}
    run keyword if   '${status}'=='True'     set to dictionary       ${header_dic}       ${key}       ${arg_dic.${key}}
    [Return]  ${header_dic}

[Common] - get random value from list
    [Arguments]  ${list}
    ${value}=  Evaluate  random.choice(${list})  random
    [Return]  ${value}

[Common] - verify ${date_1} less than or equal to ${date_2}
    ${date_1}            Convert Date    ${date_1}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${date_2}            Convert Date    ${date_2}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${subtracts_date}    Subtract Date From Date    ${date_2}    ${date_1}
    should be true    ${subtracts_date} >= 0.0

[Common] - verify ${date_1} equal to ${date_2}
    ${date_1}            Convert Date    ${date_1}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${date_2}            Convert Date    ${date_2}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${subtracts_date}    Subtract Date From Date    ${date_2}    ${date_1}
    should be true    ${subtracts_date} == 0.0

[Common] - verify ${date_1} less than ${date_2}
    ${date_1}            Convert Date    ${date_1}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${date_2}            Convert Date    ${date_2}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${subtracts_date}    Subtract Date From Date    ${date_2}    ${date_1}
    should be true    ${subtracts_date} > 0.0
[Common] - verify date_1 less than date_2
    [Arguments]     ${date_1}       ${date_2}
    ${date_1}            Convert Date    ${date_1}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${date_2}            Convert Date    ${date_2}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${subtracts_date}    Subtract Date From Date    ${date_2}    ${date_1}
    should be true    ${subtracts_date} > 0.0

[Common] - build body request dict from list
    [Arguments]     ${key_dict}     ${src_dict}
    ${dict}     create dictionary
    FOR    ${key}  IN  @{key_dict.keys()}
       ${status}   run keyword and return status   get from dictionary     ${src_dict}     ${key}
       run keyword if  ${status}   set to dictionary   ${dict}     ${key}  ${src_dict['${key}']}
    END
    [Return]    ${dict}

[Common] - build json pair with type none
    [Arguments]     ${arg_dic}
    ${json}     catenate    "${arg_dic.key}"    :   null    ,
    ${old_json}     evaluate    $arg_dic.get("json", "")
    ${new_json}     catenate    ${old_json}     ${json}
    set to dictionary   ${arg_dic}  json=${new_json}

[Common] - build json pair with type string
    [Arguments]     ${arg_dic}
    ${value}    convert to string   ${arg_dic.value}
    ${json}     catenate    "${arg_dic.key}"    :   "${value}"  ,
    ${old_json}     evaluate    $arg_dic.get("json", "")
    ${new_json}     catenate    ${old_json}     ${json}
    set to dictionary   ${arg_dic}  json=${new_json}

[Common] - build json pair with type numeric
    [Arguments]     ${arg_dic}
    ${value}    convert to number   ${arg_dic.value}
    ${json}     catenate    "${arg_dic.key}"    :   ${arg_dic.value}    ,
    ${old_json}     evaluate    $arg_dic.get("json", "")
    ${new_json}     catenate    ${old_json}     ${json}
    set to dictionary   ${arg_dic}  json=${new_json}

[Common] - build json pair with type bool
    [Arguments]     ${arg_dic}
    ${value}    convert to string  ${arg_dic.value}
    ${value}    convert to lowercase    ${value}
    ${json}     catenate    "${arg_dic.key}"    :   ${value}    ,
    ${old_json}     evaluate    $arg_dic.get("json", "")
    ${new_json}     catenate    ${old_json}     ${json}
    set to dictionary   ${arg_dic}  json=${new_json}

[Common] - create json string from dict
    [Arguments]  ${arg_dic}     ${key_dict}
    ${json_dict}  create dictionary     json=${EMPTY}
    FOR    ${key}  IN  @{arg_dic.keys()}
       ${value}    get from dictionary     ${arg_dic}  ${key}
       ${type}     get from dictionary     ${key_dict}     ${key}
       set to dictionary  ${json_dict}     key=${key}  value=${value}
       ${is_none}  run keyword and return status   should be equal     ${value}    ${NONE}
       run keyword if  ${is_none}  [Common] - build json pair with type none   ${json_dict}
       run keyword if  ${is_none}  continue for loop
       ${is_str}   run keyword and return status   should be equal as strings  ${type}     str
       run keyword if  ${is_str}   [Common] - build json pair with type string     ${json_dict}
       run keyword if  ${is_str}   continue for loop
       ${is_num}   run keyword and return status   should be equal as strings  ${type}     num
       run keyword if  ${is_num}   [Common] - build json pair with type numeric    ${json_dict}
       run keyword if  ${is_num}   continue for loop
       ${is_bool}  run keyword and return status   should be equal as strings  ${type}     bool
       run keyword if  ${is_bool}  [Common] - build json pair with type bool  ${json_dict}
       run keyword if  ${is_bool}  continue for loop
    END
    ${json_str}     get from dictionary     ${json_dict}     json
    ${json_str}     get substring   ${json_str}     0   -1
    ${json_str}     catenate    {   ${json_str}
    ${json_str}     catenate    ${json_str}     }
    log     ${json_str}
    [Return]    ${json_str}

[Common] - create json string from dict with value empty check
    [Arguments]  ${arg_dic}     ${key_dict}
    ${json_dict}  create dictionary     json=${EMPTY}
    FOR    ${key}  IN  @{arg_dic.keys()}
       ${value}    get from dictionary     ${arg_dic}  ${key}
       ${type}     get from dictionary     ${key_dict}     ${key}
       Run Keyword If    '${value}'=='${EMPTY}'    continue for loop
       set to dictionary  ${json_dict}     key=${key}  value=${value}
       ${is_none}  run keyword and return status   should be equal     ${value}    ${NONE}
       run keyword if  ${is_none}  [Common] - build json pair with type none   ${json_dict}
       run keyword if  ${is_none}  continue for loop
       ${is_str}   run keyword and return status   should be equal as strings  ${type}     str
       Run Keyword If    '${type}'!='${EMPTY}'    run keyword if  ${is_str}   [Common] - build json pair with type string     ${json_dict}
       Run Keyword If    '${type}'!='${EMPTY}'    run keyword if  ${is_str}   continue for loop
       ${is_num}   run keyword and return status   should be equal as strings  ${type}     num
       run keyword if  ${is_num}   [Common] - build json pair with type numeric    ${json_dict}
       run keyword if  ${is_num}   continue for loop
       ${is_bool}  run keyword and return status   should be equal as strings  ${type}     bool
       run keyword if  ${is_bool}  [Common] - build json pair with type bool  ${json_dict}
       run keyword if  ${is_bool}  continue for loop
    END
    ${json_str}     get from dictionary     ${json_dict}     json
    ${json_str}     get substring   ${json_str}     0   -1
    ${json_str}     catenate    {   ${json_str}
    ${json_str}     catenate    ${json_str}     }
    log     ${json_str}
    [Return]    ${json_str}

[Common] - Subtract time to current start date
    [Arguments]  ${total_days}
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    ${active_date_from}=    Subtract Time From Date     ${current_date}T00:00:00Z	${total_days}
    ${active_date_from}     Convert Date    ${active_date_from}     date_format=%Y-%m-%d %H:%M:%S.%f  exclude_millis=False  result_format=%Y-%m-%dT%H:%M:%SZ
    set test variable   ${test_active_date_from}    ${active_date_from}

[Common] - Add time to current end date
    [Arguments]  ${total_days}
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    ${active_date_to}=      Add Time To Date     ${current_date}T23:59:59Z	${total_days}
    ${active_date_to}   Convert Date    ${active_date_to}   date_format=%Y-%m-%d %H:%M:%S.%f  exclude_millis=False  result_format=%Y-%m-%dT%H:%M:%SZ
    set test variable   ${test_active_date_to}  ${active_date_to}

[Suite][Common] - Add time to current end date
    [Arguments]  ${total_days}
    ${active_date_to}=      Add Time To Date     ${suite_current_end_date}	${total_days}
    ${active_date_to}   Convert Date    ${active_date_to}   date_format=%Y-%m-%d %H:%M:%S.%f  exclude_millis=False  result_format=%Y-%m-%dT%H:%M:%SZ
    set suite variable   ${suite_active_date_to}  ${active_date_to}

Prepare current start date
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    ${current_from_date}    set variable    ${current_date}T00:00:00Z
    [Return]    ${current_from_date}

Prepare current end date
    ${current_date}       Get Current Date    result_format=%Y-%m-%d
    ${current_end_date}     set variable    ${current_date}T23:59:59Z
    [Return]    ${current_end_date}
    
[Common] - Get test id
    [Arguments]  ${test_name}
    ${result}    Fetch From Left    ${test_name}     ${SPACE}
    [Return]     ${result}
    
[Common] - List should not contain
    [Arguments]    ${list}    ${list_not}
    ${list_not_count}    get length    ${list_not}
    FOR    ${i}    IN RANGE    0    ${list_not_count}
        list should not contain value    ${list}    ${list_not[${i}]}
    END

[Common] - List should contain
    [Arguments]    ${list}    ${list_in}
    ${list_in_count}    get length    ${list_in}
    FOR    ${i}    IN RANGE    0    ${list_in_count}
        list should contain value    ${list}    ${list_in[${i}]}
    END

[Common][Prepare] - Authorization headers
    [Arguments]
        ...     ${client_id}
        ...     ${client_secret}
        ...     ${access_token}
        ...     ${content_type}=application/json
        ...     ${output}=headers
    ${headers}   create dictionary
        ...     client_id=${client_id}
        ...     client_secret=${client_secret}
        ...     content-type=${content_type}
        ...     Authorization=Bearer ${access_token}
    [Common] - Set variable       name=${output}       value=${headers}

[Common] - Set variable
    [Arguments]     ${name}     ${value}
    ${is_suite_var}       Run Keyword And Return Status      Should Match     ${name}       suite_*
    ${has_test_case}      Run Keyword And Return Status      Variable Should Exist     ${TEST_NAME}
    run keyword if      '${is_suite_var}'=='${True}' or '${has_test_case}'=='${False}'
        ...         set suite variable      \${${name}}     ${value}
        ...     ELSE        set test variable      \${${name}}     ${value}

[Common] - Search permission by name
      [Arguments]  &{arg_dic}
      ${dic}   [200] API get all permissions    access_token=${arg_dic.access_token}
      ${response}       get from dictionary  ${dic}     response
      @{apis}    set variable    ${response.json()['data']}
      FOR      ${api}       IN       @{apis}
        run keyword if   '${api['name']}'=='${arg_dic.permission_name}'    set test variable    ${test_permisison_id}    ${api['id']}
      END

[Common] - Add time to date
    [Arguments]         ${date}         ${time}         ${output}=test_date
    ${result}=       Add time to date
        ...     date=${date}
        ...     time=${time}
        ...     result_format=%Y-%m-%dT%H:%M:%SZ
        ...     date_format=%Y-%m-%dT%H:%M:%SZ
    [Common] - Set variable       name=${output}       value=${result}
    
[Common] - Generate a random string
    [Arguments]    ${length}=10    ${output}=suite_random_string
    ${random_string}    generate random string    ${length}    [LETTERS]
    [Common] - Set variable       name=${output}       value=${random_string}

[Common] - Generate a random string with pattern
    [Arguments]    ${length}=10    ${prefix}=prefix     ${suffix}=suffix    ${output}=suite_random_string_pattern
    ${random_string}    generate random string    ${length}    [LETTERS]
    ${final_string}     set variable      ${prefix}${random_string}${suffix}
    [Common] - Set variable       name=${output}       value=${final_string}

[Common] - Generate a random integer
    [Arguments]    ${length}=4    ${output}=suite_random_integer
    ${random_string}    generate random string    ${length}    [NUMBERS]
    ${random_integer}    convert to integer    ${random_string}
    [Common] - Set variable       name=${output}       value=${random_integer}

[Common] - Get test case ID
    [Arguments]     &{arg_dic}
    ${result}    Fetch From Left    ${arg_dic.test_name}     ${SPACE}
    [Common] - Set variable     ${arg_dic.output}       ${result}

[Common] - Verify datetime is changed
    [Arguments]       ${datetime_before}   ${datetime_after}
    ${datetime_before}            Convert Date    ${datetime_before}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${datetime_after}            Convert Date    ${datetime_after}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${subtracts_date}    Subtract Date From Date    ${datetime_after}    ${datetime_before}
    should be true       ${subtracts_date} > 0
    
[Common] - verify dictionary ${actual_dic} with ${expected_dic}
    FOR    ${key}    IN    @{expected_dic.keys()}
        ${actual}    get from dictionary    ${actual_dic}    ${key}
        ${expected}    get from dictionary    ${expected_dic}    ${key}
        should be equal as strings    ${actual}    ${expected}
    EMD

[Common] - Verify datetime is not changed
    [Arguments]       ${datetime_before}   ${datetime_after}
    ${datetime_before}            Convert Date    ${datetime_before}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${datetime_after}            Convert Date    ${datetime_after}   date_format=%Y-%m-%dT%H:%M:%SZ
    ${subtracts_date}    Subtract Date From Date    ${datetime_after}    ${datetime_before}
    should be equal as strings       ${subtracts_date}      0.0

[Common] - Add to integer
    [Arguments]     ${first}        ${second}       ${output}
    ${sum}      sum decimal     ${first}        ${second}       0
    [Common] - Set variable     name=${output}      value=${sum}

[Common] - Random elements in list
    [Arguments]     ${list}     ${output}
    ${length}   get length      ${list}
    ${index}    Evaluate    random.sample(range(${length}), 1)    random
    ${value}    set variable        ${list[${index[0]}]}
    [Common] - Set variable     name=${output}      value=${value}

[Common] Verify pagination - first page
    ${total_pages}      REST.integer        $.data.page.total_pages
    REST.boolean    $.data.page.has_previous    false
    REST.integer    $.data.page.current_page    1
    REST.integer    $.data.page.total_elements
    run keyword if      '${total_pages}'=='[1]'          REST.boolean    $.data.page.has_next    false
        ...     ELSE        REST.boolean    $.data.page.has_next    true

[Common] Verify pagination - last page
    [Arguments]         ${total_pages}
    REST.integer    $.data.page.total_pages         ${total_pages}
    REST.boolean    $.data.page.has_next    false
    REST.integer    $.data.page.current_page    ${total_pages}
    REST.integer    $.data.page.total_elements
    run keyword if      '${total_pages}'=='[1]'          REST.boolean    $.data.page.has_previous    false
        ...     ELSE        REST.boolean    $.data.page.has_previous    true

[Common] Verify pagination - non existed page
    REST.integer    $.data.page.total_pages
    REST.null       $.data.page.has_next
    REST.null       $.data.page.has_previous
    REST.null       $.data.page.current_page
    REST.integer    $.data.page.total_elements

[Common] - Create array param in dic
    [Arguments]    ${arg_dic}      ${key}
    ${param_json}   set variable   ${empty}
    ${status}   run keyword and return status       Dictionary Should Contain Key     ${arg_dic}          ${key}
    ${param_json}     run keyword if      '${status}'=='True'   [Common] - Create array param		${key}		${arg_dic.${key}}
    ...   ELSE    set variable    ${empty}
    [Return]   ${param_json}

[Common] - Create array param
    [Arguments]  ${key}     ${value}
    ${param_Json}     set variable    ${empty}
    ${param_Json}=    run keyword if   '${value}'!='${param_not_used}'   set variable   "${key}":[${value}],
    ...   ELSE    set variable    ${empty}
    ${temp}     set variable    ${param_Json}
    ${param_Json}=    run keyword if   '${value}'=='${param_is_null}'   set variable   "${key}":null,
    ...   ELSE    set variable    ${temp}
    [Return]  ${param_Json}

[Common][Extract] - Convert list object with atribute to list
    [Documentation]  In: list_obj = [{"key": 1},{"key": 2}]   => return [1,2]
    [Arguments]     ${list_obj}           ${key}
    ${list_result}=      create list
    FOR    ${row}    IN    @{list_obj}
        Append To List	    ${list_result}	${row['${key}']}
    END
    [Return]      ${list_result}

[Common] - Set test variable default
    [Arguments]     ${variable_name}   ${default_value}=${EMPTY}
    ${is_not_exist} =  run_keyword_and_return_status    Variable Should Not Exist  ${${variable_name}}
    run keyword if  ${is_not_exist}     set test variable      ${${variable_name}}     ${default_value}

[Common] - Converting to JSON
    [Arguments]  ${json_string}
    ${MY_DATA_TABLE_VALUES}    evaluate  json.loads('''${json_string}''')    json
    [Return]  ${MY_DATA_TABLE_VALUES}

[Common] - Get value from JSON
    [Documentation]  json_path sample: $.items[?(@.name=="item1")].name => $ is root json, ?() to filter. [] to loop in child list, @ is current element
    [Arguments]  ${json}     ${json_path}
    ${name}=    Get Value From Json    ${json}    ${json_path}
    [Return]  ${name}

[Common] - Get value from JSON string
    [Documentation]  json_path sample: $.items[?(@.name=="item1")].name => $ is root json, ?() to filter. [] to loop in child list, @ is current element
    [Arguments]  ${json_string}     ${json_path}
    ${json_string}=     replace string  ${json_string}  u'  "
    ${json_string}=     replace string  ${json_string}  '  "
    ${json_string}=     replace string  ${json_string}  None  ""
    ${json_string}=     replace string  ${json_string}  : False,  : false,
    ${json}=    [Common] - Converting to JSON   ${json_string}
    ${name}=    Get Value From Json    ${json}    ${json_path}
    [Return]  ${name}
