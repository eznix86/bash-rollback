#!/bin/bash

source ../rollback.sh

# Example commands with rollbacks
echo "Running command 1"
command1() {
    echo "Command 1 executed"
    rb "echo 'Command 1 rolled back'"
}
command1

echo "Running command 2"
command2() {
    echo "Command 2 executed"
    rb "echo 'Command 2 rolled back'"
}
command2

echo "Running command 3"
command3() {
    echo "Command 3 executed"
    rb "echo 'Command 3 rolled back'"
    return 1 # Simulating a failure
}
command3

echo "Script completed"
