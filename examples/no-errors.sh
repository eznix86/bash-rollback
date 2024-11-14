#!/bin/bash

source ../rollback.sh

echo "Running command 1"

echo "Command 1 executed"
rb "echo 'Command 1 rolled back'"

echo "Running command 2"
echo "Command 2 executed"
rb "echo 'Command 2 rolled back'"

echo "Running command 3"

echo "Command 3 executed"
rb "echo 'Command 3 rolled back'"

echo "Script completed"
