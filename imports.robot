*** Settings ***

#### ROBOT LIBRARY ####
Library           SeleniumLibrary
Library           String
Library           RequestsLibrary
Library           SSHLibrary
Library           Collections
Library           DateTime
Library           OperatingSystem
Library           DatabaseLibrary
Library           REST          ssl_verify=${False}

#### PYTHON3 LIBRARY ####
Library           ./0_resources/pythonlibs/convert_list_to_string.py
Library           ./0_resources/pythonlibs/convert_to_json.py
Library           ./0_resources/pythonlibs/createcsvfile.py
Library           ./0_resources/pythonlibs/csv_util.py
Library           ./0_resources/pythonlibs/encodebase64.py
Library           ./0_resources/pythonlibs/excel_util.py
Library           ./0_resources/pythonlibs/ExcellentLibrary.py
Library           ./0_resources/pythonlibs/filesearch.py
Library           ./0_resources/pythonlibs/get_all_value_of_specific_key.py
Library           ./0_resources/pythonlibs/javaexecutor.py
Library           ./0_resources/pythonlibs/json_generator.py
Library           ./0_resources/pythonlibs/math_util.py
Library           ./0_resources/pythonlibs/readcsvfile.py
Library           ./0_resources/pythonlibs/remove_quote_string_sql.py
Library           ./0_resources/pythonlibs/rsa_encryption.py
Library           ./0_resources/pythonlibs/rest_util.py
Library           ./0_resources/pythonlibs/urlparse_compat.py
Library           ./0_resources/pythonlibs/RabbitMq.py

#### ROBOT WEB COMMON KEYWORDS ####

Resource          ./1_common/bdd_web_common_keywords.robot
Resource          ./1_common/rabbitmq_common_keywords.robot
Resource          ./1_common/sql_common_keywords.robot
Resource          ./1_common/web_common_keywords.robot

#### ROBOT WEB COMMON KEYWORDS ####
Resource          ./1_common/api_common/api_common_keywords.robot
Resource          ./1_common/api_common/1_pre_request/common.robot
Resource          ./1_common/api_common/2_request/common.robot
Resource          ./1_common/api_common/3_post_request/common.robot


#### ROBOT ELEMENT ####
Resource     ./2_elements/homepage.robot


#### ROBOT KEYWORDS ####
Resource     ./4_keywords/HomePage_Keywords.robot

