#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "user" [ "$(whoami)" = "yocto" ]
check "git" git --version
check "python3" python3 --version
check "required-tools" which gawk wget diffstat unzip chrpath socat cpio
check "locale" [ "$LANG" = "en_US.UTF-8" ]
check "build-essential" gcc --version

# Report result
reportResults
