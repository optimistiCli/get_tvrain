#!/bin/bash

TEST_BASE="/tmp/test-o-$RANDOM"
SIMLINK_BASE="simlink-base-$RANDOM"
SIMLINK="simlink-$RANDOM"
A_FILE="a-file-$RANDOM"
TEST_FILE="test-file-$RANDOM"
NO_DIR="bla-bla-bla-$RANDOM"


function run_test {
	local RUN_ON="$1" ; shift
	local MESSSAGE="$1" ; shift 

	echo "==========================================="
	echo "$MESSSAGE: $RUN_ON"
	ls -ld "$RUN_ON" 2>&1
	echo "-------------------------------------------"
	./get_tvrain -o "$RUN_ON"
	echo "-------------------------------------------"
	ls -ld "$RUN_ON" 2>&1
	echo $'===========================================\n'
}


# Writable files and dirs

mkdir "$TEST_BASE"
run_test "$TEST_BASE" 'Try overwriting a directory'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
touch "${TEST_BASE}/$SIMLINK_BASE"
ln -s "${TEST_BASE}/$SIMLINK_BASE" "${TEST_BASE}/$SIMLINK"
run_test "${TEST_BASE}/$SIMLINK" 'Try overwriting a simlink'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
touch "${TEST_BASE}/$A_FILE"
run_test "${TEST_BASE}/$A_FILE" 'Try overwriting a file'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
run_test "${TEST_BASE}/$TEST_FILE" 'Try creating a file in existing directory'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
run_test "${TEST_BASE}/${NO_DIR}/$TEST_FILE" 'Try creating a file in an inexistant directory'
rm -rf "$TEST_BASE"


# Readonly files and dirs

mkdir "$TEST_BASE"
chmod a-w "$TEST_BASE"
run_test "$TEST_BASE" 'Try overwriting a read-only directory'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
touch "${TEST_BASE}/$SIMLINK_BASE"
ln -s "${TEST_BASE}/$SIMLINK_BASE" "${TEST_BASE}/$SIMLINK"
chmod a-w "${TEST_BASE}/$SIMLINK_BASE"
run_test "${TEST_BASE}/$SIMLINK" 'Try overwriting a simlink to a read-only file'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
touch "${TEST_BASE}/$A_FILE"
chmod a-w "${TEST_BASE}/$A_FILE"
run_test "${TEST_BASE}/$A_FILE" 'Try overwriting a read-only file'
rm -rf "$TEST_BASE"

mkdir "$TEST_BASE"
chmod a-w "$TEST_BASE"
run_test "${TEST_BASE}/$TEST_FILE" 'Try creating a file in existing read-only directory'
chmod +w "$TEST_BASE"
rm -rf "$TEST_BASE"


# Other user's files and dirs

sudo echo -n ''


sudo mkdir "$TEST_BASE"
run_test "$TEST_BASE" 'Try overwriting other users directory'
sudo rm -rf "$TEST_BASE"

sudo mkdir "$TEST_BASE"
sudo touch "${TEST_BASE}/$SIMLINK_BASE"
sudo ln -s "${TEST_BASE}/$SIMLINK_BASE" "${TEST_BASE}/$SIMLINK"
run_test "${TEST_BASE}/$SIMLINK" 'Try overwriting other users simlink'
sudo rm -rf "$TEST_BASE"

sudo mkdir "$TEST_BASE"
sudo touch "${TEST_BASE}/$A_FILE"
run_test "${TEST_BASE}/$A_FILE" 'Try overwriting other users file'
sudo rm -rf "$TEST_BASE"

sudo mkdir "$TEST_BASE"
run_test "${TEST_BASE}/$TEST_FILE" 'Try creating a file in existing other users directory'
sudo rm -rf "$TEST_BASE"
