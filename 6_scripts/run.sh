#!/bin/bash
whoami
groups
pwd
ls -la
python3 --version
chromedriver --version

echo "================ "

#### start script ####
service_name=$1
#environment_path=$PWD
#echo "=== environment_path is $environment_path ==="
path="$(dirname "$(dirname $PWD)")"
echo "=== path is $path === "
#environment_name=${environment_path##*/}
#echo "=== env name is $environment_name === "
export resultsdir=$path/robot_webui_test_core/results
export configdir=$path/robot_webui_test_core/configs


test_path=$2
echo "=== PATH is $path==="

echo "=== TEST_PATH is $test_path==="

echo "=== Check current libs ==="
#pip3 list


############ RUNNING TEST ##################
echo "=== Run robot test==="
parentpath="$(dirname "$(dirname "$(dirname $PWD)")")"
TESTCASE_FOLDER="$path/robot_base_test/5_test_cases"
RESULT_FOLDER="$path/robot_base_test/results"
robot -L TRACE -v ENV:$ENV -v browser:headlesschrome -e ignore -e not-ready -d $RESULT_FOLDER $TESTCASE_FOLDER
########################### ENABLE BELOW SECTION TO DISABLE TEST ##########################
echo "=== Run Robot !!! Done !!! ==="
