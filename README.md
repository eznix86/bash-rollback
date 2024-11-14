# Bash Rollback Handler

A script that provides automatic rollback functionality when commands fail. Think of it as a simple transaction system for bash scripts.

Improvement of [bash-rollback](https://github.com/siilike/bash-rollback.git)

## How It Works

```bash
source rollback.sh

# Create something and register its cleanup
touch /tmp/test.txt
rb "rm -f /tmp/test.txt"

# If script fails after this point, it will automatically:
# 1. Detect the failure
# 2. Execute registered rollbacks in reverse order
# 3. Report any rollback failures
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

kubectl create namespace test
rb "kubectl delete namespace test"

kubectl apply -f deployment.yaml
rb "kubectl delete -f deployment.yaml"

# If anything fails, both resources are cleaned up in reverse order
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

