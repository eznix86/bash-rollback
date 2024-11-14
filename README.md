# Bash Rollback Handler

A script that provides automatic rollback functionality when commands fail. Think of it as a simple transaction system for bash scripts.

Improvement of [bash-rollback](https://github.com/siilike/bash-rollback.git)

## How It Works

```bash
source rollback.sh

touch /tmp/test.txt # if this fails
rb "rm -f /tmp/test.txt" # this will be executed
```

Features:

- Registers rollback commands as you go
- Auto-executes them in reverse order on failure
- Supports both single commands and multi-line rollbacks
- Only rolls back on errors (non-zero exit)

## Basic Usage

```bash
#!/bin/bash
source rollback.sh

mkdir -p /tmp/test
rb "rm -rf /tmp/test"

# Create a file and add content
echo "test content" > /tmp/test/file.txt
rb "rm -f /tmp/test/file.txt"

# Start a background process
nohup tail -f /dev/null > /tmp/test/output.log 2>&1 & 
PID=$!
rb "kill $PID"

# Download a file
wget https://example.com/file -O /tmp/test/downloaded.txt
rb "rm -f /tmp/test/downloaded.txt"

# Create and modify permissions
touch /tmp/test/secure.txt
chmod 600 /tmp/test/secure.txt
rb "rm -f /tmp/test/secure.txt"

# If any command fails, everything gets rollback in reverse order
```

## Installation

```sh
curl -o rollback.sh https://raw.githubusercontent.com/eznix86/repo/bash-rollback/rollback.sh

chmod +x rollback.sh
```

## Usage

```sh
# Local
source rollback.sh
# or
. rollback.sh

# Remote
source <(curl -s https://raw.githubusercontent.com/eznix86/bash-rollback/main/rollback.sh)
```
