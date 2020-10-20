*** Settings ***
Resource    ../0_resources/imports.robot




*** Keywords ***

[Common] - Create rabbitmq connection
    [Arguments]  ${host}    ${http_port}    ${amqp_port}    ${username}    ${password}  ${vhost}
    Create Rabbitmq Connection    ${host}    ${http_port}    ${amqp_port}    ${username}    ${password}    alias=rmq   vhost=${vhost}
    ${overview}=    Overview
    log    ${overview}

[Common] - Disconnect from current rabbitmq connection
    Disconnect From Rabbitmq

[Common] - Close all rabbitmq connection
    Close All Rabbitmq Connections

[Common] - Create rabbitmq queue
    [Arguments]  ${queue_name}  ${node_name}
    Create Queue  queue_name=${queue_name}  auto_delete=false  durable=true  node=${node_name}

[Common] - Publish message from rabbitmq

    ${priority}  =	Convert To Integer	1
    ${expiration}=  Convert To Integer  1410966000
    ${prop_dict}=  Create Dictionary  priority=${priority}      expiration=1410966000    user_id=admin
    Publish Message  exchange_name=(AMQP default)  routing_key=longest  payload=Delete  props=${prop_dict} 

